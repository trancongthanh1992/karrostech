//
//  HomeRemote.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/23/21.
//

import Foundation
import Moya
import RxSwift

protocol HomeRemote {
    var provider: MoyaProvider<NetworkService> { get }
    
    func fetchTrending(page: Int) -> Observable<Results<TrendingEntity>>
    func fetchCategory(page: Int) -> Observable<Genres<GenreEntity>>
    func fetchPopular(page: Int) -> Observable<Results<PopularEntity>>
    func fetchTopRated(page: Int) -> Observable<Results<TopRatedEntity>>
    func fetchUpcoming(page: Int) -> Observable<Results<UpcomingEntity>>
}

class HomeRemoteImpl: HomeRemote {
   
    var provider =  MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin()])
  
    func fetchTrending(page: Int) -> Observable<Results<TrendingEntity>> {
        provider
            .rx
            .request(.trending(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<TrendingEntity>.self)
            .debug("TrendingEntity")
            .asObservable()
    }
    
    func fetchCategory(page: Int) -> Observable<Genres<GenreEntity>> {
        provider
            .rx
            .request(.category(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Genres<GenreEntity>.self)
            .debug("GenreEntity")
            .asObservable()
    }
    
    func fetchPopular(page: Int) -> Observable<Results<PopularEntity>> {
        provider
            .rx
            .request(.popular(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<PopularEntity>.self)
            .debug("PopularEntity")
            .asObservable()
    }
    
    func fetchTopRated(page: Int) -> Observable<Results<TopRatedEntity>> {
        provider
            .rx
            .request(.topRated(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<TopRatedEntity>.self)
            .debug("TopRatedEntity")
            .asObservable()
    }
    
    func fetchUpcoming(page: Int) -> Observable<Results<UpcomingEntity>> {
        provider
            .rx
            .request(.upcoming(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .observeOn(MainScheduler.instance)
            .map(Results<UpcomingEntity>.self)
            .debug("UpcomingEntity")
            .asObservable()
    }
}

