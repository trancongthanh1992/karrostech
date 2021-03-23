//
//  NetworkService.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation
import Moya

let apiKey = "438fea3c2c223596a2aa1b8de0828d19"
let language = "en-US"

public enum NetworkService {
    case trending(page: Int)
    case category(page: Int)
    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    
    ///
    case details(movieId: Int)
    case detailsVideo(movieId: Int)
    case detailsCredits(movieId: Int)
    case detailsReview(movieId: Int)
    case detailsSimilar(movieId: Int)
    case detailsWatchProviders(movieId: Int)
    case detailsRecommendations(movieId: Int)
}

extension NetworkService: TargetType {

    public var baseURL: URL { URL(string: "https://api.themoviedb.org")! }
    
    public var path: String {
        switch self {
        case .trending(_):
            return "/3/trending/all/week"
        case .category(_):
            return "/3/genre/tv/list"
        case .popular(_):
            return "/3/movie/popular"
        case .topRated(_):
            return "/3/movie/top_rated"
        case .upcoming(_):
            return "/3/movie/upcoming"
            
        ///
        case let .details(movieId):
            return "/3/movie/\(movieId)"
        case let .detailsReview(movieId):
            return "/3/movie/\(movieId)/reviews"
        case let .detailsVideo(movieId):
            return "/3/movie/\(movieId)/videos"
        case let .detailsCredits(movieId: movieId):
            return "/3/movie/\(movieId)/credits"
        case let .detailsSimilar(movieId: movieId):
            return "/3/movie/\(movieId)/similar"
        case let .detailsWatchProviders(movieId: movieId):
            return "/3/movie/\(movieId)/watch/providers"
        case let .detailsRecommendations(movieId: movieId):
            return "/3/movie/\(movieId)/recommendations"
        }
    }
    
    public var task: Task {
        switch self {
        case let .trending(page):
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
        case .details(_):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        case .detailsReview(_):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        case .detailsVideo(_):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        case .detailsCredits(_):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        case .detailsSimilar(_):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        case .detailsWatchProviders(_):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        case .detailsRecommendations(_):
            return .requestParameters(
                parameters: ["api_key" : apiKey, "language": language],
                encoding: URLEncoding.queryString
            )
        }
        
    }
    
    public var method: Moya.Method {
        switch self {
        case .trending,
             .category,
             .popular,
             .topRated,
             .upcoming,
             .details,
             .detailsVideo,
             .detailsReview,
             .detailsCredits,
             .detailsSimilar,
             .detailsWatchProviders,
             .detailsRecommendations:
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
