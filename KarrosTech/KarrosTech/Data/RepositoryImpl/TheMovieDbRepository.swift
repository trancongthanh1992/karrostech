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
    func getLoadMoreRecommendations(movieId: Int, page: Int) -> Observable<Results<RecommendationEntity>>
    func getLoadMoreCategory(page: Int) -> Observable<Genres<GenreEntity>>
    func getLoadMorePopular(page: Int) -> Observable<Results<PopularEntity>>
    func getLoadMoreTopRated(page: Int) -> Observable<Results<TopRatedEntity>>
    func getLoadMoreUpcoming(page: Int) -> Observable<Results<UpcomingEntity>>
    
    ///
    func getDetails(movieId: Int, page: Int) -> ObDetailsResultable
    func getDetailsMovieRepository(movieId: Int) -> Observable<MovieDetailsEntity>
    func getDetailsCreditsRepository(movieId: Int) -> Observable<CreditsEntity>
    func getDetailsVideoRepository(movieId: Int) -> Observable<Results<VideoEntity>>
    func getDetailsReviewRepository(movieId: Int) -> Observable<Results<ReviewEntity>>
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
    
    func getLoadMoreRecommendations(movieId: Int, page: Int = 1) -> Observable<Results<RecommendationEntity>> {
        return remote.fetchRecommendations(movieId: movieId, page: page)
    }
    
    func getLoadMoreCategory(page: Int) -> Observable<Genres<GenreEntity>> {
        return remote.fetchCategory(page: page)
    }
    
    func getLoadMorePopular(page: Int) -> Observable<Results<PopularEntity>> {
        return remote.fetchPopular(page: page)
    }
    
    func getLoadMoreTopRated(page: Int) -> Observable<Results<TopRatedEntity>> {
        return remote.fetchTopRated(page: page)
        
    }
    
    func getLoadMoreUpcoming(page: Int) -> Observable<Results<UpcomingEntity>> {
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
    
    func getDetailsMovieRepository(movieId: Int) -> Observable<MovieDetailsEntity> {
        return remote.fetchDetailsMovie(movieId: movieId)
    }
    
    func getDetailsVideoRepository(movieId: Int) -> Observable<Results<VideoEntity>> {
        return remote.fetchDetailsVideo(movieId: movieId)
    }
    
    func getDetailsReviewRepository(movieId: Int) -> Observable<Results<ReviewEntity>> {
        return remote.fetchDetailsReview(movieId: movieId)
    }
    
    func getDetailsCreditsRepository(movieId: Int) -> Observable<CreditsEntity> {
        return remote.fetchDetailsCredits(movieId: movieId)
    }
    
    func getDetailsWatchProvidersRepository(movieId: Int) -> Observable<ResultWatchProvider> {
        return remote.fetchDetailsWatchProviders(movieId: movieId)
    }
   
}
