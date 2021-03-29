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

import YouTubePlayer

class DetailsVideoViewItemCollectionViewCell: UICollectionViewCell, NibReusable {

    private var disposeBag: DisposeBag = DisposeBag()
    @IBOutlet weak var containerView: VideoViewItem!
    var indexPath: Int!
    var playSubject: PublishSubject<(item: VideoEntity,cell: DetailsVideoViewItemCollectionViewCell, indexPath: Int)>!
        
    var model: VideoEntity! {
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
    }

    
    private func bindingModel(_ model: VideoEntity) -> Void {
        
        guard let key = model.key else { return }
        containerView.videoView.playerVars = [
             "playsinline": "1",
             "controls": "0",
             "showinfo": "0"
             ] as YouTubePlayerView.YouTubePlayerParameters
        containerView.videoView.loadVideoID(key)
    
        containerView.playButton.isHidden = model.isPlay
        
        containerView.didPlayVideo = {[unowned self] videoPlayer in
            playSubject.onNext((item: model, cell: self, indexPath: indexPath))
        }
    }
}
