//
//  DetailViewController.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
import RxDataSources

class DetailsViewController: UIViewController, StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = UIStoryboard(
        name: "Main",
        bundle: nil
    )
    
    var movieId: Int!
    
    private let disposeBag = DisposeBag()
    var viewModel: DetailsViewModel!
    var dataSource: RxTableViewSectionedReloadDataSource<DetailsSectionData>!
    
    @IBOutlet weak var tableView: UITableView!
    let refreshHandler = UIRefreshControl()
    
    let loadMoreCreditsTrigger = PublishSubject<DetailsPagable>()
    let loadMoreRecommendationTrigger = PublishSubject<DetailsPagable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        
        let remote = TheMovieDbRemote()
        let rocal = TheMovieDbLocal()
        let repository = TheMovieDbRepository(remote: remote, local: rocal)
        let useCase = DetailsUseCase(repository: repository)
        
        ///
        viewModel = DetailsViewModel(useCase: useCase,
                                     firstLoadTrigger: Observable<Int>.just(movieId),
                                     loadMoreCreditsTrigger: loadMoreCreditsTrigger,
                                     loadMoreRecommendationTrigger: loadMoreRecommendationTrigger
        )
        
        viewModel.isEndLoading
            .subscribe { [unowned self](_) in
                self.refreshHandler.endRefreshing()
            }
            .disposed(by: disposeBag)
        
        ///
        dataSource = DetailsDataSource.dataSource(viewModel: viewModel)
        viewModel.detailSectionData
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

extension DetailsViewController {
    
    func configTableView() -> Void {
        ///
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        tableView.addSubview(refreshHandler)
        
        if #available(iOS 11.0, *) {
            self.tableView.insetsContentViewsToSafeArea = false;
            self.tableView.contentInsetAdjustmentBehavior = .never;
        }
        
        ///
        tableView.register(cellType: InfoTableViewCell.self)
        tableView.register(cellType: YourRateTableViewCell.self)
        tableView.register(cellType: CreditsTableViewCell.self)
        tableView.register(cellType: VideoTableViewCell.self)
        tableView.register(cellType: CommentTableViewCell.self)
        tableView.register(cellType: DetailsRecommendationTableViewCell.self)
        
        ///
        self.tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}


extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 2:
            return 180
        case 3:
            return 170
        case 4:
            return 140
        case 5:
            return 210
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSectionView = HeaderSectionView()
        let headerSectionViewData = dataSource!.sectionModels[section].header
        headerSectionView.setupView(headerSectionViewData)
        return headerSectionView
    }
}
