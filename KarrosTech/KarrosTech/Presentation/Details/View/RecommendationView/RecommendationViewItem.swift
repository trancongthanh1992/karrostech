//
//  RecommendationViewItem.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import UIKit
import Reusable

class RecommendationViewItem: UIView, NibOwnerLoadable {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

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
        titleLabel.numberOfLines = 2
        titleLabel
            .fontSize(12)
            .color(.black)
        
        imageView.applyshadowWithCorner(containerView: shadowView)
    }
}
