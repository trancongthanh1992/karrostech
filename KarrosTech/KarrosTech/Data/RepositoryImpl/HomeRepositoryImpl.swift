//
//  HomeRepositoryImpl.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/23/21.
//

import Foundation
import RxSwift

class HomeRepositoryImpl: HomeRepository {
    
    let remoteDataSource: HomeRemote
    let localDataSource: HomeLocal
    
    init(remote: HomeRemote, local: HomeLocal) {
        remoteDataSource = remote
        localDataSource = local
    }
    
    func getHome() -> ObHomeResultable {
        let obTrending = remoteDataSource.fetchTrending(page: 1).retry(3)
        let obCategory = remoteDataSource.fetchCategory(page: 1).retry(3)
        let obPopular = remoteDataSource.fetchPopular(page: 1).retry(3)
        let obTopRated = remoteDataSource.fetchTopRated(page: 1).retry(3)
        let obUpcoming = remoteDataSource.fetchUpcoming(page: 1).retry(3)
        
        
        return Observable.zip(obTrending, obCategory, obPopular, obTopRated, obUpcoming) {
            return ($0, $1, $2, $3, $4)
        }
    }
    
    func loadMoreTrending(page: Int) -> Observable<Results<TrendingEntity>> {
        remoteDataSource.fetchTrending(page: page)
    }
    
    func loadMoreCategory(page: Int) -> Observable<Genres<GenreEntity>> {
        remoteDataSource.fetchCategory(page: page)
    }
    
    func loadMorePopular(page: Int) -> Observable<Results<PopularEntity>> {
        remoteDataSource.fetchPopular(page: page)
    }
    
    func loadMoreTopRated(page: Int) -> Observable<Results<TopRatedEntity>> {
        remoteDataSource.fetchTopRated(page: page)
    }
    
    func loadMoreUpcoming(page: Int) -> Observable<Results<UpcomingEntity>> {
        remoteDataSource.fetchUpcoming(page: page)
    }
}
