//
//  ViewController.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    let disposeBag = DisposeBag()
    private var remote: TheMovieDbRemotable = TheMovieDbRemote()
    
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeRemote = TheMovieDbRemote()
        let homeLocal = TheMovieDbLocal()
        let homeRepository = TheMovieDbRepository(remote: homeRemote, local: homeLocal)
        let homeUseCase = HomeUseCase(repository: homeRepository)
        
        viewModel = HomeViewModel(useCase: homeUseCase)
        
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

