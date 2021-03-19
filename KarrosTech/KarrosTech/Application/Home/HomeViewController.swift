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

typealias Pagable = (page: Int, total: Int)

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var remote: TheMovieDbRemotable = TheMovieDbRemote()
    var viewModel: HomeViewModel!
    var dataSource: RxTableViewSectionedReloadDataSource<HomeSectionData>!
    let refreshHandler = UIRefreshControl()
    
    let pageLoadMorePopular = PublishSubject<Pagable>()
    let pageLoadMoreTopRated = PublishSubject<Pagable>()
    let pageLoadMoreUpcoming = PublishSubject<Pagable>()
    let pageLoadMoreRecommendation = PublishSubject<Pagable>()
    
    ///
    //    var input: HomeViewModel.Input!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///
        configTableView()
        configNavigationBar()
        
        ///
        let pullToRefresh = refreshHandler
            .rx
            .controlEvent(UIControlEvents.valueChanged)
            .asObservable()
        
        ///
        let homeRemote = TheMovieDbRemote()
        let homeLocal = TheMovieDbLocal()
        let homeRepository = TheMovieDbRepository(remote: homeRemote, local: homeLocal)
        let homeUseCase = HomeUseCase(repository: homeRepository)

        ///
        viewModel = HomeViewModel(useCase: homeUseCase,
                                  firstLoadTrigger: Observable<Void>.just(()),
                                  pullToRefreshTrigger: pullToRefresh,
                                  loadMoreRecommendationTrigger: pageLoadMoreRecommendation,
                                  loadMorePopularTrigger: pageLoadMorePopular,
                                  loadMoreTopRatedTrigger: pageLoadMoreTopRated,
                                  loadMoreUpcomingTrigger: pageLoadMoreUpcoming
        )
        
        ///
        viewModel.isEndLoading
            .subscribe { [unowned self](_) in
                self.refreshHandler.endRefreshing()
            }
            .disposed(by: disposeBag)
        
        ///
        dataSource = HomeDataSource.dataSource(viewModel: viewModel)
        viewModel.homeSectionData
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

extension HomeViewController {

    
    func configNavigationBar() -> Void {
        guard let navigationController = self.navigationController else { return }
        
        /// NavigationBar Color
        navigationController.setNavigationBarShadow()
        navigationController.setNavigationBarColor(color: UIColor.white)
        
        /// Navigation Bar Button
        self.navigationItem.leftBarButtonItem = navigationController.setNavigationBarButtonRight(image: "ic-user-main-page")
        self.navigationItem.rightBarButtonItem = navigationController.setNavigationBarButtonRight(image: "ic-search-color")
        
        /// Logo
        setNavigationBarLogo()
    }
    
    func configTableView() -> Void {
        ///
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 90
        tableView.separatorColor = UIColor.clear
        tableView.addSubview(refreshHandler)
        
        ///
        tableView.register(cellType: RecommendationTableViewCell.self)
        tableView.register(cellType: CategoryTableViewCell.self)
        tableView.register(cellType: PopularTableViewCell.self)
        tableView.register(cellType: TopRatedTableViewCell.self)
        tableView.register(cellType: UpcomingTableViewCell.self)
        
        ///
        self.tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSectionView = HeaderSectionView()
        let headerSectionViewData = dataSource!.sectionModels[section].header
        headerSectionView.setupView(headerSectionViewData)
        return headerSectionView
    }
}
