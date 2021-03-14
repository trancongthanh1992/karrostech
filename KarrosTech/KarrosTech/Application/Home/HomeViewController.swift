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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        TheMovieDbRepository.provider.getHomeRepository(movieId: 277685, apiKey: "438fea3c2c223596a2aa1b8de0828d19").subscribe { (data) in
//            ///
//            ///
//            print(data)
//        }.disposed(by: disposeBag)
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

