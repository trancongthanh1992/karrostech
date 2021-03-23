//
//  RecommendationCollectionViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/19/21.
//

import UIKit
import RxSwift
import Kingfisher
import Reusable

class RecommendationCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var disposeBag: DisposeBag!
    
    var model: TrendingEntity! {
        didSet {
            bindingModel(model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
        self.imageView.kf.cancelDownloadTask()
    }

    private func setupView() {
        self.imageView.contentMode = .scaleToFill
        self.imageView.applyshadowWithCorner(containerView: shadowView)
    }
    
    private func bindingModel(_ model: TrendingEntity) -> Void {
        guard let backdropPath = model.backdropPath else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(backdropPath)")
        self.imageView.kf.setImage(with: url)
    }
    
}
