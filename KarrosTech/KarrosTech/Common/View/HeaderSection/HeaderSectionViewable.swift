//
//  HeaderSectionViewable.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import Foundation

protocol HeaderSectionViewable {
    var titleHeader: String { get }
    var isShowViewMore: Bool { get }
    var backgroundColor: String { get }
    var fontSize: Int { get }
    var page: Int? { get set }
    var totalPage: Int? { get set }
}

struct HeaderSectionViewData: HeaderSectionViewable {
    var titleHeader: String
    var isShowViewMore: Bool
    var backgroundColor: String
    var fontSize: Int
    var page: Int?
    var totalPage: Int?
}
