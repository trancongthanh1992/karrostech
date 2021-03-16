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

struct HomeViewModel {

    let useCase: HomeUseCaseType

    struct Input {
        let firstLoadTrigger: Driver<Void>
//        let pullToRefreshTrigger: Driver<Void>
//        let selectItemTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let homeSectionData: Driver<[HomeSectionData]>
    }
    
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
        let result = input.firstLoadTrigger.flatMap { _ in
            return useCase.repository
                .getHomeRepository(movieId: 277685, page: 1)
                .map { (data: HomeResultable)  in

                    let recommendationHeader = HeaderSectionViewData(
                        titleHeader: "RECOMMENDATIONS",
                        isShowViewMore: true,
                        backgroundColor: "white",
                        fontSize: 19
                    )
                    let categoryHeader = HeaderSectionViewData(
                        titleHeader: "CATEGORY",
                        isShowViewMore: true,
                        backgroundColor: "white",
                        fontSize: 19
                    )
                    let popularHeader = HeaderSectionViewData(
                        titleHeader: "POPULAR",
                        isShowViewMore: true,
                        backgroundColor: "white",
                        fontSize: 19
                    )
                    let topRated = HeaderSectionViewData(
                        titleHeader: "TOP RATED",
                        isShowViewMore: true,
                        backgroundColor: "white",
                        fontSize: 19
                    )
                    let upComing = HeaderSectionViewData(
                        titleHeader: "UPCOMING",
                        isShowViewMore: true,
                        backgroundColor: "white",
                        fontSize: 19
                    )


                    let recommendationItems = HomeSectionDataItem.Recommendation(data.0)
                    let categoryItems = HomeSectionDataItem.Category(data.1)
                    let popularItems = HomeSectionDataItem.Popular(data.2)
                    let topRatedItems = HomeSectionDataItem.TopRated(data.3)
                    let upComingItems = HomeSectionDataItem.Upcoming(data.4)
                    
                    return [
                        HomeSectionData(header: recommendationHeader, items: [recommendationItems]),
                        HomeSectionData(header: categoryHeader, items: [categoryItems]),
                        HomeSectionData(header: popularHeader, items: [popularItems]),
                        HomeSectionData(header: topRated, items: [topRatedItems]),
                        HomeSectionData(header: upComing, items: [upComingItems])
                    ]
                }
                .debug("getHomeRepository Result")
                .asDriver(onErrorJustReturn: [HomeSectionData]())
        }

        let output = Output(homeSectionData: result)

        return output
    }
}
