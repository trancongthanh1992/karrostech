//
//  DetailsRemote.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/23/21.
//

import Foundation
import Moya
import RxSwift

protocol DetailsRemote {
    var provider: MoyaProvider<NetworkService> { get }
    
    func fetchDetailsMovie(movieId: Int) -> Observable<MovieDetailsEntity>
    func fetchDetailsVideo(movieId: Int) -> Observable<Results<VideoEntity>>
    func fetchDetailsCredits(movieId: Int) -> Observable<CreditsEntity>
    func fetchDetailsReview(movieId: Int) -> Observable<Results<ReviewEntity>>
    func fetchDetailsWatchProviders(movieId: Int) -> Observable<ResultWatchProviderEntity>
    func fetchDetailsRecommendations(movieId: Int) -> Observable<Results<RecommendationEntity>>
}

class DetailsRemoteImlp: DetailsRemote {
    
    var provider =  MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin()])
    
    func fetchDetailsMovie(movieId: Int) -> Observable<MovieDetailsEntity> {
        provider
            .rx
            .request(.details(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(MovieDetailsEntity.self)
            .debug("MovieDetailsEntity")
            .asObservable()
    }
    
    func fetchDetailsVideo(movieId: Int) -> Observable<Results<VideoEntity>> {
        provider
            .rx
            .request(.detailsVideo(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<VideoEntity>.self)
            .debug("VideoEntity")
            .asObservable()
    }
    
    func fetchDetailsCredits(movieId: Int) -> Observable<CreditsEntity> {
        provider
            .rx
            .request(.detailsCredits(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(CreditsEntity.self)
            .debug("CreditsEntity")
            .asObservable()
    }
    
    func fetchDetailsReview(movieId: Int) -> Observable<Results<ReviewEntity>> {
        provider
            .rx
            .request(.detailsReview(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<ReviewEntity>.self)
            .debug("ReviewEntity")
            .asObservable()
    }
    
    func fetchDetailsWatchProviders(movieId: Int) -> Observable<ResultWatchProviderEntity> {
        provider
            .rx
            .request(.detailsWatchProviders(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(ResultWatchProviderEntity.self)
            .debug("ResultWatchProvider")
            .asObservable()
    }
    
    func fetchDetailsRecommendations(movieId: Int) -> Observable<Results<RecommendationEntity>> {
        provider
            .rx
            .request(.detailsRecommendations(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<RecommendationEntity>.self)
            .debug("RecommendationEntity")
            .asObservable()
    }

}
