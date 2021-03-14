//
//  RecommendationModel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation

struct RecommendationModel: Codable {
    let video: Bool?
    let voteAverage: Double?
    let title, overview, releaseDate: String?
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let genreIDS: [Int]?
    let voteCount: Int?
    let originalLanguage: OriginalLanguageModel?
    let originalTitle, posterPath: String?
    let popularity: Double?

    enum CodingKeys: String, CodingKey {
        case video
        case voteAverage = "vote_average"
        case title, overview
        case releaseDate = "release_date"
        case adult
        case backdropPath = "backdrop_path"
        case id
        case genreIDS = "genre_ids"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case popularity
    }
}
