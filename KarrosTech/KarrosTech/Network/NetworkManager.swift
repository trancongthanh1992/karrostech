//
//  NetworkManager.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation
import Moya
import RxSwift
import RxSwiftExt

protocol Networkable {
    var provider: MoyaProvider<TheMovieDbService> { get }
    
    func fetchRecommendations(movieId: Int, apiKey: String) -> Observable<Results<RecommendationModel>>
//    func fetchCategory(apiKey: String, completion: @escaping (Result<Genres<GenreMovieModel>, Error>) -> ())
//    func fetchPopular(apiKey: String, completion: @escaping (Result<Results<PopularModel>, Error>) -> ())
//    func fetchTopRated(apiKey: String, completion: @escaping (Result<Results<TopRatedModel>, Error>) -> ())
//    func fetchUpcoming(apiKey: String, completion: @escaping (Result<Results<UpcomingModel>, Error>) -> ())
//    func fetchMovieDetail(movieId: String, completion: @escaping (Result<Void, Error>) -> ())
}

class NetworkManager: Networkable {
    var provider =  MoyaProvider<TheMovieDbService>(plugins: [NetworkLoggerPlugin()])
    
    func fetchRecommendations(movieId: Int, apiKey: String) -> Observable<Results<RecommendationModel>> {
        provider
            .rx
            .request(.recommendations(movieId: movieId, apiKey: apiKey))
            .map(Results<RecommendationModel>.self)
            .asObservable()
    }
    
}
