//
//  TypeView.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/19/21.
//

import UIKit
import Reusable

class TypeView: UIView, NibOwnerLoadable {
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNibContent()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        self.title.fontSize()
        self.title.numberOfLines = 2
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.applyshadowWithCorner(
            containerView: shadowView,
            cornerRadius: 10
        )
    }
    
}
