//
//  TheMovieDbService.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation
import Moya

let apiKey = ""
let language = "vi-VN"

public enum TheMovieDbService {
    case recommendations(movieId: Int, apiKey: String)
    case category(apiKey: String)
    case popular(apiKey: String)
    case topRated(apiKey: String)
    case upcoming(apiKey: String)
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
        case .recommendations(_, apiKey):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        case .category(apiKey), .popular(apiKey), .topRated(apiKey), .upcoming(apiKey):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        default:
            return .requestPlain
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
