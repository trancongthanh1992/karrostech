//
//  Genres.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation

struct Genres<Model: Codable>: Codable {

    let genres: [GenreModel]?
        
}

extension Genres where Model == GenreModel{
    
}
