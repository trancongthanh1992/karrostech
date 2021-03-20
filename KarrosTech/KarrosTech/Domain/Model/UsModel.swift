//
//  UsModel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/21/21.
//

import Foundation

// MARK: - Us
struct UsModel: Codable {
    let link: String?
    let rent, flatrate, buy: [BuyModel]?
}
