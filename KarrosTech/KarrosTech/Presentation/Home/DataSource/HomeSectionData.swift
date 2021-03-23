//
//  HomeSectionData.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/15/21.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa
import UIKit
import Reusable

enum HomeSectionDataItem {
    case Trending(ObResultsTrendingModel)
    case Category(ObResultsCategoryModel)
    case Popular(ObResultsPopularModel)
    case TopRated(ObResultsTopRatedModel)
    case Upcoming(ObResultsUpcomingModel)
}

struct HomeSectionData {
    var header: HeaderSectionViewable
    var items: [HomeSectionDataItem]
}

extension HomeSectionData: SectionModelType {
    typealias Item = HomeSectionDataItem
    
    init(original: HomeSectionData, items: [HomeSectionDataItem]) {
        self = original
        self.items = items
    }
}


struct HomeDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource(viewModel: HomeViewModel, navigationController: UINavigationController) -> DataSourceHomeSection {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            switch item {
            case let .Trending(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as RecommendationTableViewCell
                cell.viewModel = viewModel
                cell.modelSelected = { model in
                    let viewController = DetailsViewController.instantiate()
                    viewController.movieId = model.id
                    navigationController.pushViewController(viewController, animated: true)
                }
                cell.model = model
                return cell
            case let .Category(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as CategoryTableViewCell
                cell.model = model
                return cell
            case let .Popular(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as PopularTableViewCell
                cell.viewModel = viewModel
                cell.modelSelected = { model in
                    let viewController = DetailsViewController.instantiate()
                    viewController.movieId = model.id
                    navigationController.pushViewController(viewController, animated: true)
                }
                cell.model = model
                return cell
            case let .TopRated(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as TopRatedTableViewCell
                cell.viewModel = viewModel
                cell.modelSelected = { model in
                    let viewController = DetailsViewController.instantiate()
                    viewController.movieId = model.id
                    navigationController.pushViewController(viewController, animated: true)
                }
                cell.model = model
                return cell
            case let .Upcoming(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as UpcomingTableViewCell
                cell.modelSelected = { model in
                    let viewController = DetailsViewController.instantiate()
                    viewController.movieId = model.id
                    navigationController.pushViewController(viewController, animated: true)
                }
                cell.viewModel = viewModel
                
                cell.model = model
                return cell
            }
        })
    }
    
    static let recommendationHeader = HeaderSectionViewData(
        titleHeader: "RECOMMENDATIONS",
        isShowViewMore: true,
        backgroundColor: .white,
        fontSize: 19
    )
    static let categoryHeader = HeaderSectionViewData(
        titleHeader: "CATEGORY",
        isShowViewMore: true,
        backgroundColor: .white,
        fontSize: 19
    )
    static let popularHeader = HeaderSectionViewData(
        titleHeader: "POPULAR",
        isShowViewMore: true,
        backgroundColor: .white,
        fontSize: 19
    )
    static let topRated = HeaderSectionViewData(
        titleHeader: "TOP RATED",
        isShowViewMore: true,
        backgroundColor: .white,
        fontSize: 19
    )
    static let upComing = HeaderSectionViewData(
        titleHeader: "UPCOMING",
        isShowViewMore: true,
        backgroundColor: .white,
        fontSize: 19
    )
}
