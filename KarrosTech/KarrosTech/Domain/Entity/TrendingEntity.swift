//
//  TrendingEntity.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/23/21.
//

import Foundation

struct TrendingEntity: Codable {
    let id: Int?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?
    let adult: Bool?
    let backdropPath: String?
    let voteCount: Int?
    let genreIDS: [Int]?
    let video: Bool?
    let originalLanguage: String?
    let originalTitle, posterPath: String?
    let popularity: Double?
    let mediaType: String?
    let originalName: String?
    let originCountry: [String]?
    let firstAirDate, name: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case adult
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case genreIDS = "genre_ids"
        case video
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case firstAirDate = "first_air_date"
        case name
    }
}
