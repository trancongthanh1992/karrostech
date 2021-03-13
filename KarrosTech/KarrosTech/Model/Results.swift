//
//  Results.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation

// MARK: - Welcome
struct Results<Model: Codable>: Codable {
    let dates: DatesModel?
    let page: Int?
    let results: [Model]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates = "dates"
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
