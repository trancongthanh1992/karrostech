//
//  WatchProvider.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/21/21.
//

import Foundation

struct WatchProviderModel: Codable {
    let us: UsModel?

    enum CodingKeys: String, CodingKey {
        case us = "US"
    }
}
