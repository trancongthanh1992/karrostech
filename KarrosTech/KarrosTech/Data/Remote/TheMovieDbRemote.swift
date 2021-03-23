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
    
    func fetchRecommendations(movieId: Int, page: Int) -> Observable<Results<RecommendationEntity>>
    func fetchCategory(page: Int) -> Observable<Genres<GenreEntity>>
    func fetchPopular(page: Int) -> Observable<Results<PopularEntity>>
    func fetchTopRated(page: Int) -> Observable<Results<TopRatedEntity>>
    func fetchUpcoming(page: Int) -> Observable<Results<UpcomingEntity>>
    
    ///
    func fetchDetailsMovie(movieId: Int) -> Observable<MovieDetailsEntity>
    func fetchDetailsVideo(movieId: Int) -> Observable<Results<VideoEntity>>
    func fetchDetailsCredits(movieId: Int) -> Observable<CreditsEntity>
    func fetchDetailsReview(movieId: Int) -> Observable<Results<ReviewEntity>>
    func fetchDetailsWatchProviders(movieId: Int) -> Observable<ResultWatchProvider>
}

class TheMovieDbRemote: TheMovieDbRemotable {

    var provider =  MoyaProvider<TheMovieDbService>(plugins: [NetworkLoggerPlugin()])
    
    func fetchRecommendations(movieId: Int, page: Int) -> Observable<Results<RecommendationEntity>> {
        provider
            .rx
            .request(.recommendations(movieId: movieId, page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<RecommendationEntity>.self)
            .debug("RecommendationModel")
            .asObservable()
            
    }
    
    func fetchCategory(page: Int) -> Observable<Genres<GenreEntity>> {
        provider
            .rx
            .request(.category(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Genres<GenreEntity>.self)
            .debug("GenreModel")
            .asObservable()
    }
    
    func fetchPopular(page: Int) -> Observable<Results<PopularEntity>> {
        provider
            .rx
            .request(.popular(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<PopularEntity>.self)
            .debug("PopularModel")
            .asObservable()
    }
    
    func fetchTopRated(page: Int) -> Observable<Results<TopRatedEntity>> {
        provider
            .rx
            .request(.topRated(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<TopRatedEntity>.self)
            .debug("TopRatedModel")
            .asObservable()
    }
    
    func fetchUpcoming(page: Int) -> Observable<Results<UpcomingEntity>> {
        provider
            .rx
            .request(.upcoming(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<UpcomingEntity>.self)
            .debug("UpcomingModel")
            .asObservable()
    }
    
    func fetchDetailsMovie(movieId: Int) -> Observable<MovieDetailsEntity> {
        provider
            .rx
            .request(.details(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(MovieDetailsEntity.self)
            .debug("MovieDetailModel")
            .asObservable()
    }
    
    func fetchDetailsVideo(movieId: Int) -> Observable<Results<VideoEntity>> {
        provider
            .rx
            .request(.detailsVideo(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<VideoEntity>.self)
            .debug("VideoModel")
            .asObservable()
    }
    
    func fetchDetailsReview(movieId: Int) -> Observable<Results<ReviewEntity>> {
        provider
            .rx
            .request(.detailsReview(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<ReviewEntity>.self)
            .debug("UpcomingModel")
            .asObservable()
    }
    
    func fetchDetailsCredits(movieId: Int) -> Observable<CreditsEntity> {
        provider
            .rx
            .request(.detailsCredits(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(CreditsEntity.self)
            .debug("CreditsModel")
            .asObservable()
    }
    
    func fetchDetailsWatchProviders(movieId: Int) -> Observable<ResultWatchProvider> {
        provider
            .rx
            .request(.detailsWatchProviders(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(ResultWatchProvider.self)
            .debug("Results<UsModel>")
            .asObservable()
    }
}
