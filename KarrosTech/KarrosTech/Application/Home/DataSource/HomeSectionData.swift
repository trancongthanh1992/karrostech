//
//  HomeSectionData.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/15/21.
//

import Foundation
import RxDataSources

struct HomeSectionDataItem {
    var title: String?
    var posterPath: String?
    var backdropPath: String?
    var type: String?
    var isShowMore: Bool = false
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
