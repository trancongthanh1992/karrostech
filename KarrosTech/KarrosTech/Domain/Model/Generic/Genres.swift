//
//  Genres.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation

struct Genres<Entity: Codable>: Codable {

    let genres: [GenreEntity]?
        
}

extension Genres where Entity == GenreEntity{
    
}
