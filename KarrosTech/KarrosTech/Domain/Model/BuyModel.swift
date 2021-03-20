//
//  BuyModel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/21/21.
//

import Foundation

// MARK: - Buy
struct BuyModel: Codable {
    let displayPriority: Int?
    let logoPath: String?
    let providerID: Int?
    let providerName: String?

    enum CodingKeys: String, CodingKey {
        case displayPriority = "display_priority"
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
    }
}
