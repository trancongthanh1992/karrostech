//
//  ResultModel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/14/21.
//

import Foundation

struct ResultEntity: Codable {
    let author: String?
    let authorDetails: AuthorDetailsEntity?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}
