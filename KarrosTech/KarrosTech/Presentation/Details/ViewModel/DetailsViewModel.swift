//
//  DetailViewModel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import Foundation
import RxSwift
import RxOptional
import RxSwiftExt
import RxCocoa

class DetailsViewModel {
    
    
    let useCase: DetailsUseCase
    private let dispose = DisposeBag()
    
    // Input
    let firstLoadTrigger: Observable<Int>
    let loadMoreCreditsTrigger: PublishSubject<DetailsPagable>
    let loadMoreRecommendationTrigger: PublishSubject<DetailsPagable>
    
    
    // Output
    var detailSectionData: BehaviorRelay<[DetailsSectionData]> = BehaviorRelay(value: [DetailsSectionData]())
    
    let isEndLoading = PublishSubject<Bool>()
    
    init(useCase: DetailsUseCase,
         firstLoadTrigger: Observable<Int>,
         loadMoreCreditsTrigger: PublishSubject<DetailsPagable>,
         loadMoreRecommendationTrigger: PublishSubject<DetailsPagable>
    ) {
        self.useCase = useCase
        self.firstLoadTrigger = firstLoadTrigger
        self.loadMoreCreditsTrigger = loadMoreCreditsTrigger
        self.loadMoreRecommendationTrigger = loadMoreRecommendationTrigger
        
        let resultData = firstLoadTrigger
            .flatMapLatest { movieId in
                return useCase
                    .getDetails(movieId: movieId)
            }
        
        resultData
            .map({ _ in true })
            .bind(to: isEndLoading)
            .disposed(by: dispose)
        
        resultData
            .map { [unowned self] data in self.mapData(data) }
            .bind(to: detailSectionData)
            .disposed(by: dispose)
    }
}

extension DetailsViewModel {
    
    private func mapData(_ data: DetailsResultable) -> [DetailsSectionData] {
        
        let infoItems = DetailsSectionDataItem.Info(Observable.just(data.0))
        let rateItems = DetailsSectionDataItem.Rate(Observable.just(YourRateEntity(rating: 0.0, content: "")))
        let creditItems = DetailsSectionDataItem.Credit(Observable.just(data.1))
        let videoItems = DetailsSectionDataItem.Video(BehaviorRelay(value: data.2))
        let commentItems = data.3.results?.map({ DetailsSectionDataItem.Comment($0) })
        let recommendationItems = DetailsSectionDataItem.Recommendation(BehaviorRelay(value: data.4))
        
        
        return [
            DetailsSectionData(header: DetailsDataSource.infoHeader, items: [infoItems]),
            DetailsSectionData(header: DetailsDataSource.yourRateHeader, items: [rateItems]),
            DetailsSectionData(header: DetailsDataSource.seriesCastHeader, items: [creditItems]),
            DetailsSectionData(header: DetailsDataSource.videoHeader, items: [videoItems]),
            DetailsSectionData(header: DetailsDataSource.commentsHeader, items: commentItems ?? []),
            DetailsSectionData(header: DetailsDataSource.recommendationsHeader, items: [recommendationItems]),
        ]
    }
    
}
