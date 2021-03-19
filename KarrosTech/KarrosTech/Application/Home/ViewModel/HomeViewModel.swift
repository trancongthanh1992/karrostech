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
        
        let resultTrigger = BehaviorRelay<HomeResultable?>(value: nil)
        
        
        let resultData = Observable.merge(firstLoadTrigger, pullToRefreshTrigger)
            .flatMapLatest { _ in
                return useCase.repository
                    .getHomeRepository(movieId: 277685, page: 1)
            }
        
        resultData
            .bind(to: resultTrigger)
            .disposed(by: dispose)
        
        resultData
            .map({ _ in true })
            .bind(to: isEndLoading)
            .disposed(by: dispose)
        
        resultTrigger
            .filterNil()
            .map { [unowned self] data in self.mapData(data) }
            .bind(to: homeSectionData)
            .disposed(by: dispose)
        
        
        loadMoreRecommendationTrigger
            .filter({ $0.page < $0.total })
            .flatMapFirst { (e)  in
                return useCase
                    .repository
                    .getLoadMoreRecommendations(movieId: 277685, page: (e.page + 1))
            }
            .do(onNext: { (data) in
                var resultRecommend = resultTrigger.value?.0
                resultRecommend?.page = data.page
                resultRecommend?.totalPages = data.totalPages
            })
            .withLatestFrom(resultTrigger, resultSelector: { (resultApiData: $0, resultTriggerData: $1) })
            .withLatestFrom(homeSectionData, resultSelector: { (resultApiData: $0.resultApiData, resultTriggerData: $0.resultTriggerData, resultHomeData: $1) })
            .subscribe (onNext: { data in
                let oldData = data.resultTriggerData!.0.results
                let apiData = data.resultApiData.results!
                    
                var pageData = Results<RecommendationModel>()
                pageData.page = data.resultApiData.page
                pageData.totalPages = data.resultApiData.totalPages
                pageData.results = oldData! + apiData
                if case let .Recommendation(dataModel) = data.resultHomeData[0].items[0] {
                    dataModel.onNext(pageData)
                }
            }).disposed(by: dispose)
            
        
        
        
        loadMorePopularTrigger
            .filter({ $0.page < $0.total })
            .flatMapFirst { e in
                return useCase
                    .repository
                    .getLoadMorePopular(page: (e.page + 1))
            }
            .map({ [unowned self] data in self.mapDataPopular(data) })
            .subscribe(onNext: { data in
                var resultData = resultTrigger.value
                resultData?.2.page = data.page
                resultData?.2.totalPages = data.totalPages
                resultData?.2.results?.append(contentsOf: data.results!)
                
                resultTrigger.accept(resultData)
            })
            .disposed(by: dispose)
        
        
        
        loadMoreTopRatedTrigger
            .filter({ $0.page < $0.total })
            .flatMapFirst { e in
                return useCase
                    .repository
                    .getLoadMoreTopRated(page: (e.page + 1))
            }
            .map({ [unowned self] data in self.mapDataTopRated(data) })
            .subscribe(onNext: { data in
                var resultData = resultTrigger.value
                resultData?.3.page = data.page
                resultData?.3.totalPages = data.totalPages
                resultData?.3.results?.append(contentsOf: data.results!)
                resultTrigger.accept(resultData)
            })
            .disposed(by: dispose)
        
        
        loadMoreUpcomingTrigger
            .filter({ $0.page < $0.total })
            .flatMapFirst { e in
                return useCase
                    .repository
                    .getLoadMoreUpcoming(page: (e.page + 1))
            }
            .map({ [unowned self] data  in self.mapDataUpcoming(data) })
            .subscribe(onNext: { data in
                var resultData = resultTrigger.value
                resultData?.4.page = data.page
                resultData?.4.totalPages = data.totalPages
                resultData?.4.results?.append(contentsOf: data.results!)
                resultTrigger.accept(resultData)
            })
            .disposed(by: dispose)
        
        
    }
    
    private func mapDataRecommendation(_ data: Results<RecommendationModel>) -> Results<RecommendationModel> {
        return data
    }
    
    private func mapDataPopular(_ data: Results<PopularModel>) -> Results<PopularModel> {
        return data
    }
    
    private func mapDataTopRated(_ data: Results<TopRatedModel>) -> Results<TopRatedModel> {
        return data
    }
    
    private func mapDataUpcoming(_ data: Results<UpcomingModel>) -> Results<UpcomingModel> {
        return data
    }
    
    private func mapData(_ data: HomeResultable) -> [HomeSectionData] {
        let recommendationItems = HomeSectionDataItem.Recommendation(BehaviorSubject(value: data.0))
        let categoryItems = HomeSectionDataItem.Category(BehaviorSubject(value: data.1))
        let popularItems = HomeSectionDataItem.Popular(BehaviorSubject(value: data.2))
        let topRatedItems = HomeSectionDataItem.TopRated(BehaviorSubject(value: data.3))
        let upComingItems = HomeSectionDataItem.Upcoming(BehaviorSubject(value: data.4))
        
        return [
            HomeSectionData(header: HomeDataSource.recommendationHeader, items: [recommendationItems]),
            HomeSectionData(header: HomeDataSource.categoryHeader, items: [categoryItems]),
            HomeSectionData(header: HomeDataSource.popularHeader, items: [popularItems]),
            HomeSectionData(header: HomeDataSource.topRated, items: [topRatedItems]),
            HomeSectionData(header: HomeDataSource.upComing, items: [upComingItems])
        ]
    }
    
    
}
