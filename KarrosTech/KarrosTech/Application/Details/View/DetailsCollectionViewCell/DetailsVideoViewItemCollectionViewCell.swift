//
//  DetailsVideoViewItemCollectionViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/21/21.
//

import UIKit
import RxSwift
import Kingfisher
import Reusable
import AVKit
import AVFoundation

class DetailsVideoViewItemCollectionViewCell: UICollectionViewCell, NibReusable {

    private var disposeBag: DisposeBag = DisposeBag()
    @IBOutlet weak var containerView: VideoViewItem!
    
    
    var avPlayer = AVPlayer()
    var avPlayerLayer = AVPlayerLayer()
    
    var model: VideoModel! {
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
//        self.containerView.imageView.kf.cancelDownloadTask()
    }

    
    private func bindingModel(_ model: VideoModel) -> Void {
//        guard let profilePath = model.profilePath else { return }
//        let url = URL(string: "https://image.tmdb.org/t/p/w300\(profilePath)")
//        self.containerView.imageView.kf.setImage(with: url)
    }
}
