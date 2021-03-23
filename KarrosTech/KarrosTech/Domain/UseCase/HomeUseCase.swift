//
//  HomeUseCase.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/23/21.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getHome(page: Int) -> ObHomeResultable
    func loadMoreTrending(page: Int) -> Observable<Results<TrendingEntity>>
    func loadMoreCategory(page: Int) -> Observable<Genres<GenreEntity>>
    func loadMorePopular(page: Int) -> Observable<Results<PopularEntity>>
    func loadMoreTopRated(page: Int) -> Observable<Results<TopRatedEntity>>
    func loadMoreUpcoming(page: Int) -> Observable<Results<UpcomingEntity>>
}

class HomeUseCaseImpl: HomeUseCase {
    
    let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func getHome(page: Int) -> ObHomeResultable {
        repository.getHome()
    }
    
    func loadMoreTrending(page: Int) -> Observable<Results<TrendingEntity>> {
        repository.loadMoreTrending(page: page)
    }
    
    func loadMoreCategory(page: Int) -> Observable<Genres<GenreEntity>> {
        repository.loadMoreCategory(page: page)
    }
    
    func loadMorePopular(page: Int) -> Observable<Results<PopularEntity>> {
        repository.loadMorePopular(page: page)
    }
    
    func loadMoreTopRated(page: Int) -> Observable<Results<TopRatedEntity>> {
        repository.loadMoreTopRated(page: page)
    }
    
    func loadMoreUpcoming(page: Int) -> Observable<Results<UpcomingEntity>> {
        repository.loadMoreUpcoming(page: page)
    }
}
