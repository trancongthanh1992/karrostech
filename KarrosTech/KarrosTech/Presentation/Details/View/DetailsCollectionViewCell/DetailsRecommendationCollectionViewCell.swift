//
//  DetailsRecommendationCollectionViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/21/21.
//

import UIKit
import RxSwift
import Kingfisher
import Reusable


class DetailsRecommendationCollectionViewCell: UICollectionViewCell, NibReusable {

    private var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var containerView: RecommendationViewItem!
    
    var model: RecommendationEntity! {
        didSet {
            bindingModel(model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
        self.containerView.imageView.kf.cancelDownloadTask()
    }

    
    private func bindingModel(_ model: RecommendationEntity) -> Void {
        self.containerView.titleLabel.text = model.title
        guard let posterPath = model.posterPath else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)")
        self.containerView.imageView.kf.setImage(with: url)
    }

}
