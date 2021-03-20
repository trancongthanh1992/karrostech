//
//  HeaderSectionViewable.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import Foundation
import UIKit

protocol HeaderSectionViewable {
    var titleHeader: String { get }
    var isShowViewMore: Bool { get }
    var backgroundColor: UIColor { get }
    var fontSize: Int { get }
}

struct HeaderSectionViewData: HeaderSectionViewable {
    var titleHeader: String
    var isShowViewMore: Bool
    var backgroundColor: UIColor
    var fontSize: Int
}
