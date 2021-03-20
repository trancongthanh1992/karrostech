//
//  InfoTableViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/20/21.
//

import UIKit
import Reusable
import RxSwift
import Kingfisher

class InfoTableViewCell: UITableViewCell, NibReusable {

    let cellWidthConstant: CGFloat = 300
    let cellHeightConstant: CGFloat = 640
    private var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var containerView: InfoView!
    
    var viewModel: DetailsViewModel!
    
    var model: ObMovieDetailsModel! {
        didSet {
            self.bindCollectionView(model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        self.containerView.thumbImageView.kf.cancelDownloadTask()
        self.containerView.movieImageView.kf.cancelDownloadTask()
    }
    
}

extension InfoTableViewCell {
    
    private func bindCollectionView(_ model: ObMovieDetailsModel) {

        model.map { $0.title }
            .bind(to: self.containerView.titleLabel.rx.text.asObserver())
            .disposed(by: disposeBag)
        
        model.map { $0.overview }
            .filterNil()
            .bind(to: self.containerView.contentLabel.rx.text.asObserver())
            .disposed(by: disposeBag)
        
        model.map { $0.backdropPath }
            .filterNil()
            .bind(onNext: ({ [unowned self] value in
                self.containerView.movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(value)"))
            }))
            .disposed(by: disposeBag)
        
        model.map { $0.posterPath }
            .filterNil()
            .bind(onNext: ({ [unowned self] value in
                self.containerView.thumbImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w300\(value)"))
            }))
            .disposed(by: disposeBag)
    }
}
