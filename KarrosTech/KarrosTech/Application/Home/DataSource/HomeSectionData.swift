//
//  HomeSectionData.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/15/21.
//

import Foundation
import RxDataSources
import RxSwift


typealias DataSourceHomeSection = RxTableViewSectionedReloadDataSource<HomeSectionData>

//typealias ObResultRecommendationModel = Observable<Results<RecommendationModel>>
//typealias ObResultCategoryModel = Observable<Genres<GenreModel>>
//typealias ObResultPopularModel = Observable<Results<PopularModel>>
//typealias ObResultTopRatedModel = Observable<Results<TopRatedModel>>
//typealias ObResultUpcomingModel = Observable<Results<UpcomingModel>>

typealias ObResultRecommendationModel = BehaviorSubject<Results<RecommendationModel>>
typealias ObResultCategoryModel = BehaviorSubject<Genres<GenreModel>>
typealias ObResultPopularModel = BehaviorSubject<Results<PopularModel>>
typealias ObResultTopRatedModel = BehaviorSubject<Results<TopRatedModel>>
typealias ObResultUpcomingModel = BehaviorSubject<Results<UpcomingModel>>

typealias ResultRecommendationModel = Results<RecommendationModel>
typealias ResultCategoryModel = Genres<GenreModel>
typealias ResultPopularModel = Results<PopularModel>
typealias ResultTopRatedModel = Results<TopRatedModel>
typealias ResultUpcomingModel = Results<UpcomingModel>

enum HomeSectionDataItem {
    
    case Recommendation(ObResultRecommendationModel)
    case Category(ObResultCategoryModel)
    case Popular(ObResultPopularModel)
    case TopRated(ObResultTopRatedModel)
    case Upcoming(ObResultUpcomingModel)
    
//    case Recommendation(ResultRecommendationModel)
//    case Category(ResultCategoryModel)
//    case Popular(Results<PopularModel>)
//    case TopRated(Results<TopRatedModel>)
//    case Upcoming(Results<UpcomingModel>)
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
    
    static func dataSource(viewModel: HomeViewModel) -> DataSourceHomeSection {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            switch item {
            case let .Recommendation(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as RecommendationTableViewCell
                cell.viewModel = viewModel
                cell.model = model
                return cell
            case let .Category(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as CategoryTableViewCell
                cell.model = model
                return cell
            case let .Popular(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as PopularTableViewCell
                cell.viewModel = viewModel
                cell.model = model
                return cell
            case let .TopRated(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as TopRatedTableViewCell
                cell.viewModel = viewModel
                cell.model = model
                return cell
            case let .Upcoming(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as UpcomingTableViewCell
                cell.viewModel = viewModel
                cell.model = model
                return cell
            }
        })
    }
    
    static let recommendationHeader = HeaderSectionViewData(
        titleHeader: "RECOMMENDATIONS",
        isShowViewMore: true,
        backgroundColor: "white",
        fontSize: 19,
        page: nil,
        totalPage: nil
    )
    static let categoryHeader = HeaderSectionViewData(
        titleHeader: "CATEGORY",
        isShowViewMore: true,
        backgroundColor: "white",
        fontSize: 19,
        page: nil,
        totalPage: nil
    )
    static let popularHeader = HeaderSectionViewData(
        titleHeader: "POPULAR",
        isShowViewMore: true,
        backgroundColor: "white",
        fontSize: 19,
        page: nil,
        totalPage: nil
    )
    static let topRated = HeaderSectionViewData(
        titleHeader: "TOP RATED",
        isShowViewMore: true,
        backgroundColor: "white",
        fontSize: 19,
        page: nil,
        totalPage: nil
    )
    static let upComing = HeaderSectionViewData(
        titleHeader: "UPCOMING",
        isShowViewMore: true,
        backgroundColor: "white",
        fontSize: 19,
        page: nil,
        totalPage: nil
    )
}
