//
//  UpcomingCollectionViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/19/21.
//

import UIKit
import RxSwift
import Kingfisher
import Reusable

class UpcomingCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var containerView: TypeView!
    
    private var disposeBag: DisposeBag!
    
    var model: UpcomingModel! {
        didSet {
            bindingModel(model)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.containerView.imageView.kf.cancelDownloadTask()
    }
    
    private func bindingModel(_ model: UpcomingModel) -> Void {
        self.containerView.title.text = model.title
        guard let posterPath = model.posterPath else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)")
        self.containerView.imageView.kf.setImage(with: url)
    }
}
