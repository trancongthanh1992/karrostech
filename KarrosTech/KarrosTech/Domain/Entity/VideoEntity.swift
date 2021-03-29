//
//  VideoModel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/15/21.
//

import Foundation

struct VideoEntity: Codable {
    let id, iso639_1, iso3166_1, key: String?
    let name, site: String?
    let size: Int?
    let type: String?
    var isPlay = false

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
