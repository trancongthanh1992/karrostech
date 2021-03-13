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
}
