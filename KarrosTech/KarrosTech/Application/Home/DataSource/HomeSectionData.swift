//
//  HomeSectionData.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/15/21.
//

import Foundation
import RxDataSources

enum HomeSectionDataItem {
    case Recommendation(Results<RecommendationModel>)
    case Category(Genres<GenreModel>)
    case Popular(Results<PopularModel>)
    case TopRated(Results<TopRatedModel>)
    case Upcoming(Results<UpcomingModel>)
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
