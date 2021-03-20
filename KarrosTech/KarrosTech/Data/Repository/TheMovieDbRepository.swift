//
//  TheMovieDbRepository.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/14/21.
//

import Foundation
import RxSwift
import RxSwiftExt

protocol TheMovieDbRepositoryType {
    
    var remote: TheMovieDbRemotable { get }
    var local: TheMovieDbLocatable { get }
    
    func getHomeRepository(movieId: Int,page: Int) -> ObHomeResultable
    
    ///
    func getLoadMoreRecommendations(movieId: Int, page: Int) -> Observable<Results<RecommendationModel>>
    func getLoadMoreCategory(page: Int) -> Observable<Genres<GenreModel>>
    func getLoadMorePopular(page: Int) -> Observable<Results<PopularModel>>
    func getLoadMoreTopRated(page: Int) -> Observable<Results<TopRatedModel>>
    func getLoadMoreUpcoming(page: Int) -> Observable<Results<UpcomingModel>>
    
    ///
    func getDetails(movieId: Int, page: Int) -> ObDetailsResultable
    func getDetailsMovieRepository(movieId: Int) -> Observable<MovieDetailsModel>
    func getDetailsCreditsRepository(movieId: Int) -> Observable<CreditsModel>
    func getDetailsVideoRepository(movieId: Int) -> Observable<Results<VideoModel>>
    func getDetailsReviewRepository(movieId: Int) -> Observable<Results<ReviewModel>>
    func getDetailsWatchProvidersRepository(movieId: Int) -> Observable<ResultWatchProvider>
}

class TheMovieDbRepository: TheMovieDbRepositoryType {
    
    var remote: TheMovieDbRemotable
    var local: TheMovieDbLocatable
    
    init(remote: TheMovieDbRemotable, local: TheMovieDbLocatable) {
        self.remote = remote
        self.local = local
    }

    
    func getHomeRepository(movieId: Int,page: Int = 1) -> ObHomeResultable {
        
        let obRecommendations = remote.fetchRecommendations(movieId: movieId, page: page).retry(3)
        let obCategory = remote.fetchCategory(page: page).retry(3)
        let obPopular = remote.fetchPopular(page: page).retry(3)
        let obTopRated = remote.fetchTopRated(page: page).retry(3)
        let obUpcoming = remote.fetchUpcoming(page: page).retry(3)
        
        
        return Observable.zip(obRecommendations, obCategory, obPopular, obTopRated, obUpcoming) {
            return ($0, $1, $2, $3, $4)
        }
    }
    
    func getLoadMoreRecommendations(movieId: Int, page: Int = 1) -> Observable<Results<RecommendationModel>> {
        return remote.fetchRecommendations(movieId: movieId, page: page)
    }
    
    func getLoadMoreCategory(page: Int) -> Observable<Genres<GenreModel>> {
        return remote.fetchCategory(page: page)
    }
    
    func getLoadMorePopular(page: Int) -> Observable<Results<PopularModel>> {
        return remote.fetchPopular(page: page)
    }
    
    func getLoadMoreTopRated(page: Int) -> Observable<Results<TopRatedModel>> {
        return remote.fetchTopRated(page: page)
        
    }
    
    func getLoadMoreUpcoming(page: Int) -> Observable<Results<UpcomingModel>> {
        return remote.fetchUpcoming(page: page)
    }

    func getDetails(movieId: Int, page: Int = 1) -> ObDetailsResultable {
        
        let obDetailsMovie = remote.fetchDetailsMovie(movieId: movieId).retry(3)
        let obDetailsCredit = remote.fetchDetailsCredits(movieId: movieId).retry(3)
        let obDetailsVideo = remote.fetchDetailsVideo(movieId: movieId).retry(3)
        let obDetailsReview = remote.fetchDetailsReview(movieId: movieId).retry(3)
        let obRecommendations = remote.fetchRecommendations(movieId: movieId, page: page).retry(3)

        return Observable.zip(obDetailsMovie, obDetailsCredit, obDetailsVideo, obDetailsReview, obRecommendations) {
            return ($0, $1, $2, $3, $4)
        }
    }
    
    func getDetailsMovieRepository(movieId: Int) -> Observable<MovieDetailsModel> {
        return remote.fetchDetailsMovie(movieId: movieId)
    }
    
    func getDetailsVideoRepository(movieId: Int) -> Observable<Results<VideoModel>> {
        return remote.fetchDetailsVideo(movieId: movieId)
    }
    
    func getDetailsReviewRepository(movieId: Int) -> Observable<Results<ReviewModel>> {
        return remote.fetchDetailsReview(movieId: movieId)
    }
    
    func getDetailsCreditsRepository(movieId: Int) -> Observable<CreditsModel> {
        return remote.fetchDetailsCredits(movieId: movieId)
    }
    
    func getDetailsWatchProvidersRepository(movieId: Int) -> Observable<ResultWatchProvider> {
        return remote.fetchDetailsWatchProviders(movieId: movieId)
    }
   
}
