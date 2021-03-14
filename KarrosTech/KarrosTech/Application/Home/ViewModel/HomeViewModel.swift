//
//  HomeViewModel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import RxOptional
import RxDataSources

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
        let pullToRefreshTrigger: Driver<Void>
        let selectItemTrigger: Driver<IndexPath>
    }
    
    struct Output {
        
    }
    
//    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
//
//    }
    
    
    
//    struct Input {
//        let movieId: Int = 277685

//     }
//
//     struct Output {
////         let repos: Driver<[GithubRepo]>
////         let selected: Driver<Void>
//
//     }
//
//
//    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
//
////        input
////            .firstLoadTrigger
////            .flatMapLatest { _ in
////
////        }
////
//        let home = input.firstLoadTrigger.flatMapLatest { _  in
//            return useCase
//                .getHomeRepository(request: TheMovieDbRepositoryRequest()).map { (<#(Results<RecommendationModel>, Genres<GenreModel>, Results<PopularModel>, Results<TopRatedModel>, Results<UpcomingModel>)#>) -> R in
//                    <#code#>
//                }
//
//        }
//
//
//        return Output()
//    }
}

