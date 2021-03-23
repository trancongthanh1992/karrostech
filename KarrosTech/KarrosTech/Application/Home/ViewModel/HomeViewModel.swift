//
//  HomeViewModel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeUseCaseType {
    var repository: TheMovieDbRepositoryType { get set }
}

struct HomeUseCase: HomeUseCaseType {
    var repository: TheMovieDbRepositoryType
}

class HomeViewModel {
    
    let useCase: HomeUseCaseType
    private let dispose = DisposeBag()
    
    // Input
    let firstLoadTrigger: Observable<Void>
    let pullToRefreshTrigger: Observable<Void>
    let loadMoreRecommendationTrigger: PublishSubject<Pagable>
    let loadMorePopularTrigger: PublishSubject<Pagable>
    let loadMoreTopRatedTrigger: PublishSubject<Pagable>
    let loadMoreUpcomingTrigger: PublishSubject<Pagable>
    
    // Output
    var homeSectionData: BehaviorRelay<[HomeSectionData]> = BehaviorRelay(value: [HomeSectionData]())
    let isEndLoading = PublishSubject<Bool>()
    
    init(useCase: HomeUseCaseType,
         firstLoadTrigger: Observable<Void>,
         pullToRefreshTrigger: Observable<Void>,
         loadMoreRecommendationTrigger: PublishSubject<Pagable>,
         loadMorePopularTrigger: PublishSubject<Pagable>,
         loadMoreTopRatedTrigger: PublishSubject<Pagable>,
         loadMoreUpcomingTrigger: PublishSubject<Pagable>) {
        
        self.useCase = useCase
        self.firstLoadTrigger = firstLoadTrigger
        self.pullToRefreshTrigger = pullToRefreshTrigger
        self.loadMoreRecommendationTrigger = loadMoreRecommendationTrigger
        self.loadMorePopularTrigger = loadMorePopularTrigger
        self.loadMoreTopRatedTrigger = loadMoreTopRatedTrigger
        self.loadMoreUpcomingTrigger = loadMoreUpcomingTrigger
        
        let resultData = Observable.merge(firstLoadTrigger, pullToRefreshTrigger)
            .flatMapLatest { _ in
                return useCase.repository
                    .getHomeRepository(movieId: 299536, page: 1)
            }
        
        resultData
            .map({ _ in true })
            .bind(to: isEndLoading)
            .disposed(by: dispose)
        
        resultData
            .map { [unowned self] data in self.mapData(data) }
            .bind(to: homeSectionData)
            .disposed(by: dispose)
        
        
        loadMoreRecommendationTrigger
            .filter({ $0.page < $0.total })
            .flatMapFirst { (e)  in
                return useCase
                    .repository
                    .getLoadMoreRecommendations(movieId: 299536, page: (e.page + 1))
            }
            .withLatestFrom(homeSectionData, resultSelector: { (resultApiData: $0, resultHomeData: $1) })
            .subscribe (onNext: { data in
                if case let .Recommendation(dataModel) = data.resultHomeData[0].items[0] {
                    var pageData = Results<RecommendationEntity>()
                    pageData.page = data.resultApiData.page
                    pageData.totalPages = data.resultApiData.totalPages
                    pageData.results = dataModel.value.results! + data.resultApiData.results!
                    dataModel.accept(pageData)
                }
            }).disposed(by: dispose)
        
        loadMorePopularTrigger
            .filter({ $0.page < $0.total })
            .flatMapFirst { e in
                return useCase
                    .repository
                    .getLoadMorePopular(page: (e.page + 1))
            }
            .withLatestFrom(homeSectionData, resultSelector: { (resultApiData: $0, resultHomeData: $1) })
            .subscribe (onNext: { data in
                if case let .Popular(dataModel) = data.resultHomeData[2].items[0] {
                    var pageData = Results<PopularEntity>()
                    pageData.page = data.resultApiData.page
                    pageData.totalPages = data.resultApiData.totalPages
                    pageData.results = dataModel.value.results! + data.resultApiData.results!
                    dataModel.accept(pageData)
                }
            }).disposed(by: dispose)
        
        
        loadMoreTopRatedTrigger
            .filter({ $0.page < $0.total })
            .flatMapFirst { e in
                return useCase
                    .repository
                    .getLoadMoreTopRated(page: (e.page + 1))
            }
            .withLatestFrom(homeSectionData, resultSelector: { (resultApiData: $0, resultHomeData: $1) })
            .subscribe (onNext: { data in
                if case let .TopRated(dataModel) = data.resultHomeData[3].items[0] {
                    var pageData = Results<TopRatedEntity>()
                    pageData.page = data.resultApiData.page
                    pageData.totalPages = data.resultApiData.totalPages
                    pageData.results = dataModel.value.results! + data.resultApiData.results!
                    dataModel.accept(pageData)
                }
            }).disposed(by: dispose)
        
        
        loadMoreUpcomingTrigger
            .filter({ $0.page < $0.total })
            .flatMapFirst { e in
                return useCase
                    .repository
                    .getLoadMoreUpcoming(page: (e.page + 1))
            }
            .withLatestFrom(homeSectionData, resultSelector: { (resultApiData: $0, resultHomeData: $1) })
            .subscribe (onNext: { data in
                if case let .Upcoming(dataModel) = data.resultHomeData[4].items[0] {
                    var pageData = Results<UpcomingEntity>()
                    pageData.page = data.resultApiData.page
                    pageData.totalPages = data.resultApiData.totalPages
                    pageData.results = dataModel.value.results! + data.resultApiData.results!
                    dataModel.accept(pageData)
                }
            }).disposed(by: dispose)
        
        
    }
    
    private func mapDataRecommendation(_ data: Results<RecommendationEntity>) -> Results<RecommendationEntity> {
        return data
    }
    
    private func mapDataPopular(_ data: Results<PopularEntity>) -> Results<PopularEntity> {
        return data
    }
    
    private func mapDataTopRated(_ data: Results<TopRatedEntity>) -> Results<TopRatedEntity> {
        return data
    }
    
    private func mapDataUpcoming(_ data: Results<UpcomingEntity>) -> Results<UpcomingEntity> {
        return data
    }
    
    private func mapData(_ data: HomeResultable) -> [HomeSectionData] {
        let recommendationItems = HomeSectionDataItem.Recommendation(BehaviorRelay(value: data.0))
        let categoryItems = HomeSectionDataItem.Category(BehaviorRelay(value: data.1))
        let popularItems = HomeSectionDataItem.Popular(BehaviorRelay(value: data.2))
        let topRatedItems = HomeSectionDataItem.TopRated(BehaviorRelay(value: data.3))
        let upComingItems = HomeSectionDataItem.Upcoming(BehaviorRelay(value: data.4))
        
        return [
            HomeSectionData(header: HomeDataSource.recommendationHeader, items: [recommendationItems]),
            HomeSectionData(header: HomeDataSource.categoryHeader, items: [categoryItems]),
            HomeSectionData(header: HomeDataSource.popularHeader, items: [popularItems]),
            HomeSectionData(header: HomeDataSource.topRated, items: [topRatedItems]),
            HomeSectionData(header: HomeDataSource.upComing, items: [upComingItems])
        ]
    }
    
    
}
