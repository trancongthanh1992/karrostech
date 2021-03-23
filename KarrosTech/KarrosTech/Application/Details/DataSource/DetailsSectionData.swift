//
//  DetailsSectionData.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/20/21.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa
import UIKit
import Reusable

enum DetailsSectionDataItem {
    case Info(ObMovieDetailsModel)
    case Rate(ObYourRateModel)
    case Credit(ObCreditsModel)
    case Video(ObResultsVideoModel)
    case Comment(ReviewEntity)
    case Recommendation(ObResultsRecommendationModel)
}

struct DetailsSectionData {
    var header: HeaderSectionViewable
    var items: [DetailsSectionDataItem]
}

extension DetailsSectionData: SectionModelType {
    typealias Item = DetailsSectionDataItem
    
    init(original: DetailsSectionData, items: [DetailsSectionDataItem]) {
        self = original
        self.items = items
    }
}


struct DetailsDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource(viewModel: DetailsViewModel) -> DataSourceDetailsSection {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            switch item {
            case let .Info(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as InfoTableViewCell
                cell.viewModel = viewModel
                cell.model = model
                return cell
            case let .Rate(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as YourRateTableViewCell
                cell.viewModel = viewModel
                cell.model = model
                return cell
            case let .Credit(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as CreditsTableViewCell
                cell.viewModel = viewModel
                cell.model = model
                return cell
            case let .Video(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as VideoTableViewCell
                cell.viewModel = viewModel
                cell.model = model
                return cell
            case let .Comment(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as CommentTableViewCell
                cell.viewModel = viewModel
                
//                cell.model = model
                return cell
            case let .Recommendation(model):
                let cell = tableView.dequeueReusableCell(for: indexPath) as DetailsRecommendationTableViewCell
                cell.viewModel = viewModel
                cell.model = model
                return cell
            }
        })
    }
    
    static let infoHeader = HeaderSectionViewData(
        titleHeader: "",
        isShowViewMore: true,
        backgroundColor: .systemGray6,
        fontSize: 19
    )
    static let yourRateHeader = HeaderSectionViewData(
        titleHeader: "Your Rate",
        isShowViewMore: true,
        backgroundColor: .systemGray6,
        fontSize: 19
    )
    static let seriesCastHeader = HeaderSectionViewData(
        titleHeader: "Series Cast",
        isShowViewMore: true,
        backgroundColor: .systemGray6,
        fontSize: 19
    )
    static let videoHeader = HeaderSectionViewData(
        titleHeader: "Video",
        isShowViewMore: true,
        backgroundColor: .systemGray6,
        fontSize: 19
    )
    static let commentsHeader = HeaderSectionViewData(
        titleHeader: "Comments",
        isShowViewMore: true,
        backgroundColor: .systemGray6,
        fontSize: 19
    )
    static let recommendationsHeader = HeaderSectionViewData(
        titleHeader: "Recommendations",
        isShowViewMore: true,
        backgroundColor: .systemGray6,
        fontSize: 19
    )
}


