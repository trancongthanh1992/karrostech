//
//  TagViewItem.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/22/21.
//

import UIKit
import Reusable

class TagViewItem: UIView, NibOwnerLoadable {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        self.typeLabel.numberOfLines = 1
        self.typeLabel
            .fontSize(12)
            .color(.white)
        
        self.containerView.backgroundColor = .link
    }
}
