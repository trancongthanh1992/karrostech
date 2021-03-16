//
//  ViewController.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxSwiftExt
import RxOptional

class HomeViewController: UIViewController, BindableType {

    private let disposeBag = DisposeBag()
    private var remote: TheMovieDbRemotable = TheMovieDbRemote()
    var viewModel: HomeViewModel!
    var dataSource: RxTableViewSectionedReloadDataSource<HomeSectionData>?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        configNavigationBar()
        
        
        let homeRemote = TheMovieDbRemote()
        let homeLocal = TheMovieDbLocal()
        let homeRepository = TheMovieDbRepository(remote: homeRemote, local: homeLocal)
        let homeUseCase = HomeUseCase(repository: homeRepository)
        
        viewModel = HomeViewModel(useCase: homeUseCase)
        
        let input = HomeViewModel.Input(firstLoadTrigger: Driver.just(()))
        let output = viewModel.transform(input: input)
        
        dataSource = RxTableViewSectionedReloadDataSource<HomeSectionData> { (datasource, tableView, indexPath, item) -> UITableViewCell in
            
            switch item {
            case let .Recommendation(model):
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendationTableViewCell", for: indexPath) as! HomeTableViewCell<Results<RecommendationModel>>
                cell.model = model
                
                cell.setUpView(cellClass: HomeCollectionViewCell.self,
                               identifier: "RecommendationCollectionViewCell",
                               collectionViewItemSize: (width: 120, height: 200)
                )
        
                
                Driver
                    .just(cell.model!.results!)
                    .drive(cell.collectionView!.rx.items(cellIdentifier: "RecommendationCollectionViewCell", cellType: HomeCollectionViewCell.self)) { row, indexPath, cell in
                        ///
                        cell.containerView =
                        ///
                    }
                    .disposed(by: self.disposeBag)
               
                return cell
            case let .Category(model):
                let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! HomeTableViewCell<Genres<GenreModel>>
                cell.model = model

                cell.setUpView(cellClass: HomeCollectionViewCell.self,
                               identifier: "CategoryCollectionViewCell",
                               collectionViewItemSize: (width: 120, height: 200)
                )
                
                return cell
            case let .Popular(model):
                let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! HomeTableViewCell<Results<PopularModel>>
                cell.model = model
                
                cell.setUpView(cellClass: HomeCollectionViewCell.self,
                               identifier: "PopularCollectionViewCell",
                               collectionViewItemSize: (width: 120, height: 200)
                )
                
                return cell
            case let .TopRated(model):
                let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as! HomeTableViewCell<Results<TopRatedModel>>
                cell.model = model
                cell.setUpView(cellClass: HomeCollectionViewCell.self,
                               identifier: "TopRatedCollectionViewCell",
                               collectionViewItemSize: (width: 120, height: 200)
                )

                return cell
            case let .Upcoming(model):
                let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! HomeTableViewCell<Results<UpcomingModel>>
                cell.model = model
                cell.setUpView(cellClass: HomeCollectionViewCell.self,
                               identifier: "UpcomingCollectionViewCell",
                               collectionViewItemSize: (width: 120, height: 200)
                )
                
                return cell
            }
            
        }
        
        
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        output.homeSectionData
            .drive(tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    @objc func onTapProfile() {

    }

    @objc func onTapSearch() {

    }
    
    func bindViewModel() {
        
    }
}

extension HomeViewController {
    
    func configNavigationBar() -> Void {
        guard let navigationController = self.navigationController else { return }

        /// NavigationBar Color
        navigationController.setNavigationBarShadow()
        navigationController.setNavigationBarColor(color: UIColor.white)
        
        /// Navigation Bar Button
        self.navigationItem.leftBarButtonItem = navigationController
            .setNavigationBarButtonRight(
                image: "ic-user-main-page",
                action:#selector(onTapProfile)
        )
        
        self.navigationItem.rightBarButtonItem = navigationController.setNavigationBarButtonRight(
            image: "ic-search-color",
            action:#selector(onTapSearch)
        )
         
        /// Logo
        navigationController.setNavigationBarLogo()
    }
 
    func configTableView() -> Void {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 90
        tableView.separatorColor = UIColor.clear
        ///
        tableView.register(HomeTableViewCell<Genres<GenreModel>>.self, forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.register(HomeTableViewCell<Results<PopularModel>>.self, forCellReuseIdentifier: "PopularTableViewCell")
        tableView.register(HomeTableViewCell<Results<TopRatedModel>>.self, forCellReuseIdentifier: "TopRatedTableViewCell")
        tableView.register(HomeTableViewCell<Results<UpcomingModel>>.self, forCellReuseIdentifier: "UpcomingTableViewCell")
        tableView.register(HomeTableViewCell<Results<RecommendationModel>>.self,forCellReuseIdentifier: "RecommendationTableViewCell")
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 170
        case 1:
            return 80
        case 2, 3, 4:
            return 260
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
}
