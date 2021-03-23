//
//  Results.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation

// MARK: - Welcome
struct Results<Model: Codable>: Codable {
    var id: Int?
    var dates: DatesEntity?
    var page: Int?
    var results: [Model]?
    var totalPages, totalResults: Int?
    

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dates = "dates"
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Result<Model: Codable>: Codable {
    var id: Int?
    var dates: DatesEntity?
    var page: Int?
    var results: Model?
    var totalPages, totalResults: Int?
    

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dates = "dates"
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct ResultWatchProvider: Codable {
    var id: Int?
    var dates: DatesEntity?
    var page: Int?
    var results: WatchProviderEntity?
    var totalPages, totalResults: Int?
    

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case dates = "dates"
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
