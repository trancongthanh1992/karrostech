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
                
                cell.setUpView(cellClass: HotCollectionViewCell.self,
                               identifier: "RecommendationCollectionViewCell",
                               collectionViewItemSize: (width: 300, height: 170)
                )
        
                
                if let result = model.results {
                    Driver
                        .just(result)
                        .drive(cell.collectionView!.rx.items(cellIdentifier: "RecommendationCollectionViewCell", cellType: HotCollectionViewCell.self)) { row, indexPath, cell in
                            cell.backgroundColor = UIColor.red
                            
                            ///
    //                        cell.containerView =
                            ///
                        }
                        .disposed(by: self.disposeBag)
                }

               
                return cell
            case let .Category(model):
                let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! HomeTableViewCell<Genres<GenreModel>>
                cell.model = model

                cell.setUpView(cellClass: CategoryCollectionViewCell.self,
                               identifier: "CategoryCollectionViewCell",
                               collectionViewItemSize: (width: 140, height: 80)
                )
                
                if let result = model.genres {
                    Driver
                        .just(result)
                        .drive(cell.collectionView!.rx.items(cellIdentifier: "CategoryCollectionViewCell", cellType: CategoryCollectionViewCell.self)) { row, indexPath, cell in
                            cell.backgroundColor = UIColor.green
                            
                            ///
    //                        cell.containerView =
                            ///
                        }
                        .disposed(by: self.disposeBag)
                }
                
                return cell
            case let .Popular(model):
                let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! HomeTableViewCell<Results<PopularModel>>
                cell.model = model
                
                cell.setUpView(cellClass: MovieCollectionViewCell.self,
                               identifier: "PopularCollectionViewCell",
                               collectionViewItemSize: (width: 140, height: 260)
                )
                
                if let result = model.results {
                    Driver
                        .just(result)
                        .drive(cell.collectionView!.rx.items(cellIdentifier: "PopularCollectionViewCell", cellType: MovieCollectionViewCell.self)) { row, indexPath, cell in
                            cell.backgroundColor = UIColor.blue
                            
                            ///
    //                        cell.containerView =
                            ///
                        }
                        .disposed(by: self.disposeBag)
                }
                
                return cell
            case let .TopRated(model):
                let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as! HomeTableViewCell<Results<TopRatedModel>>
                cell.model = model
                cell.setUpView(cellClass: MovieCollectionViewCell.self,
                               identifier: "TopRatedCollectionViewCell",
                               collectionViewItemSize: (width: 140, height: 260)
                )
                
                if let result = model.results {
                    Driver
                        .just(result)
                        .drive(cell.collectionView!.rx.items(cellIdentifier: "TopRatedCollectionViewCell", cellType: MovieCollectionViewCell.self)) { row, indexPath, cell in
                            cell.backgroundColor = UIColor.purple
                            
                            ///
    //                        cell.containerView =
                            ///
                        }
                        .disposed(by: self.disposeBag)
                }

                return cell
            case let .Upcoming(model):
                let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! HomeTableViewCell<Results<UpcomingModel>>
                cell.model = model
                cell.setUpView(cellClass: MovieCollectionViewCell.self,
                               identifier: "UpcomingCollectionViewCell",
                               collectionViewItemSize: (width: 140, height: 260)
                )
                
                if let result = model.results {
                    Driver
                        .just(result)
                        .drive(cell.collectionView!.rx.items(cellIdentifier: "UpcomingCollectionViewCell", cellType: MovieCollectionViewCell.self)) { row, indexPath, cell in
                            cell.backgroundColor = UIColor.black
                            
                            ///
    //                        cell.containerView =
                            ///
                        }
                        .disposed(by: self.disposeBag)
                }
                
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
