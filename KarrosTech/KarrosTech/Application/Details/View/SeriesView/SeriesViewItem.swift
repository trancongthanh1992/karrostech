//
//  SeriesViewItem.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import UIKit
import Reusable

class SeriesViewItem: UIView, NibOwnerLoadable {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!

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
    
    func setupView() {
        self.nameLabel.numberOfLines = 1
        self.nameLabel
            .fontSize(12)
            .color(.black)
        
        self.positionLabel.numberOfLines = 1
        self.positionLabel
            .fontSize(12)
            .color(.systemGray2)
        
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.applyshadowWithCorner(
            containerView: shadowView,
            cornerRadius: 3
        )
    }
}


