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
        
        let remote = DetailsRemoteImlp()
        let local = DetailsLocalImpl()
        let repository = DetailsRepositoryImpl(remote: remote, local: local)
        let useCase = DetailsUseCaseImpl(repository: repository)
        
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
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSectionView = HeaderSectionView()
        let headerSectionViewData = dataSource!.sectionModels[section].header
        headerSectionView.setupView(headerSectionViewData)
        return headerSectionView
    }
}



//func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//    if(velocity.y>0) {
//        //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
//        UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//            self.navigationController?.setToolbarHidden(true, animated: true)
//            print("Hide")
//        }, completion: nil)
//
//    } else {
//        UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//            self.navigationController?.setToolbarHidden(false, animated: true)
//            print("Unhide")
//        }, completion: nil)
//      }
//   }


//func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//   if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//      navigationController?.setNavigationBarHidden(true, animated: true)
//
//   } else {
//      navigationController?.setNavigationBarHidden(false, animated: true)
//   }
//}



//- (void)scrollViewDidScroll: (UIScrollView *)scroll {
//    // UITableView only moves in one direction, y axis
//    CGFloat currentOffset = scroll.contentOffset.y;
//    CGFloat maximumOffset = scroll.contentSize.height - scroll.frame.size.height;
//
//    // Change 10.0 to adjust the distance from bottom
//    if (maximumOffset - currentOffset <= 10.0) {
//        self.navigationController?.hidden = YES;
//    }
//    else{
//        self.navigationController?.hidden = NO;
//    }
//}
