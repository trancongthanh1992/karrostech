//
//  TheMovieDbRepository.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/14/21.
//

import Foundation
import RxSwift
import RxSwiftExt

typealias HomeResultable = Observable<(Results<RecommendationModel>, Genres<GenreModel>, Results<PopularModel>, Results<TopRatedModel>, Results<UpcomingModel>)>

protocol TheMovieDbRepositoryType {
    
    var remote: TheMovieDbRemotable { get }
    var local: TheMovieDbLocatable { get }
    
    func getHomeRepository(movieId: Int,page: Int) -> HomeResultable
    
    func getLoadMoreRecommendations(movieId: Int, page: Int) -> Observable<Results<RecommendationModel>>
    func getLoadMoreCategory(page: Int) -> Observable<Genres<GenreModel>>
    func getLoadMorePopular(page: Int) -> Observable<Results<PopularModel>>
    func getLoadMoreTopRated(page: Int) -> Observable<Results<TopRatedModel>>
    func getLoadMoreUpcoming(page: Int) -> Observable<Results<UpcomingModel>>
    
    func getDetailRepository() -> Void
}

class TheMovieDbRepository: TheMovieDbRepositoryType {
    
    var remote: TheMovieDbRemotable
    var local: TheMovieDbLocatable
    
    init(remote: TheMovieDbRemotable, local: TheMovieDbLocatable) {
        self.remote = remote
        self.local = local
    }

    
    func getHomeRepository(movieId: Int,page: Int = 1) -> HomeResultable {
        
        let obRecommendations = remote.fetchRecommendations(movieId: movieId, page: page)
        let obCategory = remote.fetchCategory(page: page)
        let obPopular = remote.fetchPopular(page: page)
        let obTopRated = remote.fetchTopRated(page: page)
        let obUpcoming = remote.fetchUpcoming(page: page)
        
        
        return Observable.zip(obRecommendations, obCategory, obPopular, obTopRated, obUpcoming) {
            return ($0, $1, $2, $3, $4)
        }
    }
    
    func getLoadMoreRecommendations(movieId: Int, page: Int = 1) -> Observable<Results<RecommendationModel>> {
        let obRecommendations = remote.fetchRecommendations(movieId: movieId, page: page)
        
        return obRecommendations
    }
    
    func getLoadMoreCategory(page: Int) -> Observable<Genres<GenreModel>> {
        let obCategory = remote.fetchCategory(page: page)
        
        return obCategory
    }
    
    func getLoadMorePopular(page: Int) -> Observable<Results<PopularModel>> {
        let obPopular = remote.fetchPopular(page: page)
        
        return obPopular
    }
    
    func getLoadMoreTopRated(page: Int) -> Observable<Results<TopRatedModel>> {
        let obTopRated = remote.fetchTopRated(page: page)
        
        return obTopRated
    }
    
    func getLoadMoreUpcoming(page: Int) -> Observable<Results<UpcomingModel>> {
        let obUpcoming = remote.fetchUpcoming(page: page)
        
        return obUpcoming
    }
    
    
    func getDetailRepository() -> Void {
        
    }
}
