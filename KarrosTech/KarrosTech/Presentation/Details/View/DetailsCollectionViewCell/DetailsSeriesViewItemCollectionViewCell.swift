//
//  DetailsSeriesViewItemCollectionViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/21/21.
//

import UIKit
import RxSwift
import Kingfisher
import Reusable

class DetailsSeriesViewItemCollectionViewCell: UICollectionViewCell, NibReusable {
    
    private var disposeBag: DisposeBag = DisposeBag()
    @IBOutlet weak var containerView: SeriesViewItem!
    
    var model: Cast! {
        didSet {
            bindingModel(model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
        self.containerView.imageView.kf.cancelDownloadTask()
    }

    
    private func bindingModel(_ model: Cast) -> Void {
        self.containerView.nameLabel.text = model.name
        self.containerView.positionLabel.text = model.knownForDepartment
        
        guard let profilePath = model.profilePath else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(profilePath)")
        self.containerView.imageView.kf.setImage(with: url)
    }
}
