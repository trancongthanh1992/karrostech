//
//  BelongsToCollectionModel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/14/21.
//

import Foundation

struct BelongsToCollectionEntity: Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
