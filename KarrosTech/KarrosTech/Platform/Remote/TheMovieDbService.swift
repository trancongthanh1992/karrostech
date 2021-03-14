//
//  TheMovieDbService.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation
import Moya

let apiKey = "438fea3c2c223596a2aa1b8de0828d19"
let language = "vi-VN"

public enum TheMovieDbService {
    case recommendations(movieId: Int, page: Int)
    case category(page: Int)
    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
}

extension TheMovieDbService: TargetType {

    public var baseURL: URL { URL(string: "https://api.themoviedb.org")! }
    
    public var path: String {
        switch self {
        case let .recommendations(movieId, _):
            return "/3/movie/\(movieId)/recommendations"
        case .category(_):
            return "/3/genre/tv/list"
        case .popular(_):
            return "/3/movie/popular"
        case .topRated(_):
            return "/3/movie/top_rated"
        case .upcoming(_):
            return "/3/movie/upcoming"
        
        }
    }
    
    public var task: Task {
        switch self {
        case let .recommendations(_, page):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language, "page": page],
                encoding: URLEncoding.queryString
            )
        case let .category(page):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language, "page": page],
                encoding: URLEncoding.queryString
            )
        case let .popular(page):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language, "page": page],
                encoding: URLEncoding.queryString
            )
        case let .topRated(page):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language, "page": page],
                encoding: URLEncoding.queryString
            )
        case let .upcoming(page):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language, "page": page],
                encoding: URLEncoding.queryString
            )
        }
        
    }
    
    public var method: Moya.Method {
        switch self {
        case .recommendations, .category, .popular, .topRated, .upcoming:
            return .get
        }
    }
    

    
    public var sampleData: Data {
        return Data()
    }
    
    
    
    public var headers: [String : String]? {
        nil
    }
    
}
