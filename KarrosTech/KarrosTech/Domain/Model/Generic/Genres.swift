//
//  Genres.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation

struct Genres<Model: Codable>: Codable {

    let genres: [GenreEntity]?
        
}

extension Genres where Model == GenreEntity{
    
}
