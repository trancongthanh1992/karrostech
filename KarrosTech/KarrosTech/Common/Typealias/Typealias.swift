//
//  Typealias.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/20/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

///
typealias ObHomeResultable = Observable<(Results<TrendingEntity>, Genres<GenreEntity>, Results<PopularEntity>, Results<TopRatedEntity>, Results<UpcomingEntity>)>
typealias HomeResultable = (Results<TrendingEntity>, Genres<GenreEntity>, Results<PopularEntity>, Results<TopRatedEntity>, Results<UpcomingEntity>)

///
typealias DataSourceHomeSection = RxTableViewSectionedReloadDataSource<HomeSectionData>
typealias DataSourceDetailsSection = RxTableViewSectionedReloadDataSource<DetailsSectionData>

///
typealias ObDetailsResultable = Observable<(MovieDetailsEntity, CreditsEntity, Results<VideoEntity>, Results<ReviewEntity>, Results<RecommendationEntity>)>
typealias DetailsResultable = (MovieDetailsEntity, CreditsEntity, Results<VideoEntity>, Results<ReviewEntity>, Results<RecommendationEntity>)


///
typealias ObResultsTrendingModel = BehaviorRelay<Results<TrendingEntity>>
typealias ObResultsRecommendationModel = BehaviorRelay<Results<RecommendationEntity>>
typealias ObResultsCategoryModel = BehaviorRelay<Genres<GenreEntity>>
typealias ObResultsPopularModel = BehaviorRelay<Results<PopularEntity>>
typealias ObResultsTopRatedModel = BehaviorRelay<Results<TopRatedEntity>>
typealias ObResultsUpcomingModel = BehaviorRelay<Results<UpcomingEntity>>

///
typealias ResultsRecommendationModel = Results<RecommendationEntity>
typealias ResultsCategoryModel = Genres<GenreEntity>
typealias ResultsPopularModel = Results<PopularEntity>
typealias ResultsTopRatedModel = Results<TopRatedEntity>
typealias ResultsUpcomingModel = Results<UpcomingEntity>
typealias ResultsReviewModel = Results<ReviewEntity>

///
typealias ObMovieDetailsModel = Observable<MovieDetailsEntity>
typealias ObYourRateModel = Observable<YourRateEntity>
typealias ObCreditsModel = Observable<CreditsEntity>
typealias ObResultsVideoModel = BehaviorRelay<Results<VideoEntity>>
typealias ObResultsCommentModel = Observable<Results<ReviewEntity>>
typealias ObResultWatchProvider = Observable<ResultWatchProviderEntity>
