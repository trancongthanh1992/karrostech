//
//  DetailsRepositoryImpl.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/23/21.
//

import Foundation
import RxSwift

class DetailsRepositoryImpl: DetailsRepository {
    
    let remoteDataSource: DetailsRemote
    let localDataSource: DetailsLocal
    
    init(remote: DetailsRemote, local: DetailsLocal) {
        remoteDataSource = remote
        localDataSource = local
    }
    
    func getDetails(movieId: Int) -> ObDetailsResultable {
        let obDetailsMovie = remoteDataSource.fetchDetailsMovie(movieId: movieId).retry(3)
        let obDetailsCredit = remoteDataSource.fetchDetailsCredits(movieId: movieId).retry(3)
        let obDetailsVideo = remoteDataSource.fetchDetailsVideo(movieId: movieId).retry(3)
        let obDetailsReview = remoteDataSource.fetchDetailsReview(movieId: movieId).retry(3)
        let obDetailsRecommendations = remoteDataSource.fetchDetailsRecommendations(movieId: movieId).retry(3)

        return Observable.zip(obDetailsMovie, obDetailsCredit, obDetailsVideo, obDetailsReview, obDetailsRecommendations) {
            return ($0, $1, $2, $3, $4)
        }
    }
    
    //    func getDetailsWatchProvidersRepository(movieId: Int) -> Observable<ResultWatchProvider>
}
