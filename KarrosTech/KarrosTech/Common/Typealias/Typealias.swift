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
typealias ObHomeResultable = Observable<(Results<RecommendationModel>, Genres<GenreModel>, Results<PopularModel>, Results<TopRatedModel>, Results<UpcomingModel>)>
typealias HomeResultable = (Results<RecommendationModel>, Genres<GenreModel>, Results<PopularModel>, Results<TopRatedModel>, Results<UpcomingModel>)

///
typealias DataSourceHomeSection = RxTableViewSectionedReloadDataSource<HomeSectionData>
typealias DataSourceDetailsSection = RxTableViewSectionedReloadDataSource<DetailsSectionData>

///
typealias ObDetailsResultable = Observable<(MovieDetailsModel, CreditsModel, Results<VideoModel>, Results<ReviewModel>, Results<RecommendationModel>)>
typealias DetailsResultable = (MovieDetailsModel, CreditsModel, Results<VideoModel>, Results<ReviewModel>, Results<RecommendationModel>)


///
typealias ObResultsRecommendationModel = BehaviorRelay<Results<RecommendationModel>>
typealias ObResultsCategoryModel = BehaviorRelay<Genres<GenreModel>>
typealias ObResultsPopularModel = BehaviorRelay<Results<PopularModel>>
typealias ObResultsTopRatedModel = BehaviorRelay<Results<TopRatedModel>>
typealias ObResultsUpcomingModel = BehaviorRelay<Results<UpcomingModel>>

///
typealias ResultsRecommendationModel = Results<RecommendationModel>
typealias ResultsCategoryModel = Genres<GenreModel>
typealias ResultsPopularModel = Results<PopularModel>
typealias ResultsTopRatedModel = Results<TopRatedModel>
typealias ResultsUpcomingModel = Results<UpcomingModel>
typealias ResultsReviewModel = Results<ReviewModel>

///
typealias ObMovieDetailsModel = Observable<MovieDetailsModel>
typealias ObYourRateModel = Observable<YourRateModel>
typealias ObCreditsModel = Observable<CreditsModel>
typealias ObResultsVideoModel = Observable<Results<VideoModel>>
typealias ObResultsCommentModel = Observable<Results<ReviewModel>>
typealias ObResultWatchProvider = Observable<ResultWatchProvider>
