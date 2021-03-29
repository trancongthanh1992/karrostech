//
//  VideoViewItem.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import UIKit
import Reusable
import YouTubePlayer

class VideoViewItem: UIView, NibOwnerLoadable {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var videoView: YouTubePlayerView!
    @IBOutlet weak var playButton: UIButton!
    var didPlayVideo: ((YouTubePlayerView) -> Void)!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        videoView.contentMode = .scaleAspectFill
        videoView.layer.cornerRadius = 8
        videoView.layer.masksToBounds = true
        shadowView.applyshadowWithCorner(cornerRadius: 12)
        playButton.setImage(UIImage(named: "ic-play-white"), for: .normal)
    }
    
    @IBAction func onPlayVideo(_ sender: Any) {
        self.didPlayVideo(self.videoView)
    }
    
}
