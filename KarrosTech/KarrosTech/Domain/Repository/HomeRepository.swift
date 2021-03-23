//
//  HomeRepository.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/23/21.
//

import Foundation
import RxSwift

protocol HomeRepository {
    func getHome() -> ObHomeResultable
    func loadMoreTrending(page: Int) -> Observable<Results<TrendingEntity>>
    func loadMoreCategory(page: Int) -> Observable<Genres<GenreEntity>>
    func loadMorePopular(page: Int) -> Observable<Results<PopularEntity>>
    func loadMoreTopRated(page: Int) -> Observable<Results<TopRatedEntity>>
    func loadMoreUpcoming(page: Int) -> Observable<Results<UpcomingEntity>>
}
