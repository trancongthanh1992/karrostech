//
//  TheMovieDbRemote.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation
import Moya
import RxSwift
import RxSwiftExt

protocol TheMovieDbRemotable {
    var provider: MoyaProvider<TheMovieDbService> { get }
    
    func fetchRecommendations(movieId: Int, page: Int) -> Observable<Results<RecommendationModel>>
    func fetchCategory(page: Int) -> Observable<Genres<GenreModel>>
    func fetchPopular(page: Int) -> Observable<Results<PopularModel>>
    func fetchTopRated(page: Int) -> Observable<Results<TopRatedModel>>
    func fetchUpcoming(page: Int) -> Observable<Results<UpcomingModel>>
//    func fetchMovieDetail(movieId: String, completion: @escaping (Result<Void, Error>) -> ())
}

class TheMovieDbRemote: TheMovieDbRemotable {

    var provider =  MoyaProvider<TheMovieDbService>(plugins: [NetworkLoggerPlugin()])
    
    func fetchRecommendations(movieId: Int, page: Int) -> Observable<Results<RecommendationModel>> {
        provider
            .rx
            .request(.recommendations(movieId: movieId, page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<RecommendationModel>.self)
            .debug("RecommendationModel")
            .asObservable()
            
    }
    
    func fetchCategory(page: Int) -> Observable<Genres<GenreModel>> {
        provider
            .rx
            .request(.category(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Genres<GenreModel>.self)
            .debug("GenreModel")
            .asObservable()
    }
    
    func fetchPopular(page: Int) -> Observable<Results<PopularModel>> {
        provider
            .rx
            .request(.popular(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<PopularModel>.self)
            .debug("PopularModel")
            .asObservable()
    }
    
    func fetchTopRated(page: Int) -> Observable<Results<TopRatedModel>> {
        provider
            .rx
            .request(.topRated(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<TopRatedModel>.self)
            .debug("TopRatedModel")
            .asObservable()
    }
    
    func fetchUpcoming(page: Int) -> Observable<Results<UpcomingModel>> {
        provider
            .rx
            .request(.upcoming(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<UpcomingModel>.self)
            .debug("UpcomingModel")
            .asObservable()
    }
}
