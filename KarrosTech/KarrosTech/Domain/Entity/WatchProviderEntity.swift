//
//  WatchProvider.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/21/21.
//

import Foundation

struct WatchProviderEntity: Codable {
    let us: UsEntity?

    enum CodingKeys: String, CodingKey {
        case us = "US"
    }
}
