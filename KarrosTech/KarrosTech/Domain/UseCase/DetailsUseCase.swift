//
//  DetailsUseCase.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/23/21.
//

import Foundation
import Moya
import RxSwift

protocol DetailsUseCase {
    func getDetails(movieId: Int) -> ObDetailsResultable
}

class DetailsUseCaseImpl: DetailsUseCase {
    
    let repository: DetailsRepository
    
    init(repository: DetailsRepository) {
        self.repository = repository
    }
    
    func getDetails(movieId: Int) -> ObDetailsResultable {
        repository.getDetails(movieId: movieId)
    }    
}
