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
    
    ///
    func fetchDetailsMovie(movieId: Int) -> Observable<MovieDetailsModel>
    func fetchDetailsVideo(movieId: Int) -> Observable<Results<VideoModel>>
    func fetchDetailsCredits(movieId: Int) -> Observable<CreditsModel>
    func fetchDetailsReview(movieId: Int) -> Observable<Results<ReviewModel>>
    func fetchDetailsWatchProviders(movieId: Int) -> Observable<ResultWatchProvider>
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
    
    func fetchDetailsMovie(movieId: Int) -> Observable<MovieDetailsModel> {
        provider
            .rx
            .request(.details(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(MovieDetailsModel.self)
            .debug("MovieDetailModel")
            .asObservable()
    }
    
    func fetchDetailsVideo(movieId: Int) -> Observable<Results<VideoModel>> {
        provider
            .rx
            .request(.detailsVideo(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<VideoModel>.self)
            .debug("VideoModel")
            .asObservable()
    }
    
    func fetchDetailsReview(movieId: Int) -> Observable<Results<ReviewModel>> {
        provider
            .rx
            .request(.detailsReview(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<ReviewModel>.self)
            .debug("UpcomingModel")
            .asObservable()
    }
    
    func fetchDetailsCredits(movieId: Int) -> Observable<CreditsModel> {
        provider
            .rx
            .request(.detailsCredits(movieId: movieId))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(CreditsModel.self)
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
