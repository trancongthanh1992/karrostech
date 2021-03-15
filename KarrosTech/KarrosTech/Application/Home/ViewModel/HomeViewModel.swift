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
    
    func transform(input: HomeViewModel.Input) -> Void {
        
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


                    let recommendationItems = (data.0.results ?? [])
                        .map { data in
                            return HomeSectionDataItem(title: data.title,
                                                       posterPath: data.posterPath,
                                                       backdropPath: data.backdropPath,
                                                       type: "",
                                                       isShowMore: false
                            )
                        }

                    let categoryItems = (data.1.genres ?? [])
                        .map { data in
                            return HomeSectionDataItem(title: data.name,
                                                       posterPath: "",
                                                       backdropPath: "",
                                                       type: "",
                                                       isShowMore: false
                            )

                        }

                    let popularItems = (data.2.results ?? [])
                        .map { data in
                            return HomeSectionDataItem(title: data.title,
                                                       posterPath: data.posterPath,
                                                       backdropPath: data.backdropPath,
                                                       type: "",
                                                       isShowMore: false
                            )
                        }

                    let topRatedItems = (data.3.results ?? [])
                        .map { data in
                            return HomeSectionDataItem(title: data.title,
                                                       posterPath: data.posterPath,
                                                       backdropPath: data.backdropPath,
                                                       type: "",
                                                       isShowMore: false
                            )
                        }

                    let upComingItems = (data.4.results ?? [])
                        .map { data in
                            return HomeSectionDataItem(title: data.title,
                                                       posterPath: data.posterPath,
                                                       backdropPath: data.backdropPath,
                                                       type: "",
                                                       isShowMore: false
                            )
                        }


                    return [
                        HomeSectionData(header: recommendationHeader, items: recommendationItems),
                        HomeSectionData(header: categoryHeader, items: categoryItems),
                        HomeSectionData(header: popularHeader, items: popularItems),
                        HomeSectionData(header: topRated, items: topRatedItems),
                        HomeSectionData(header: upComing, items: upComingItems)
                    ]
                }.asDriver(onErrorJustReturn: [HomeSectionData]())
              
        }
    }
    
   
}

