//
//  RateView.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import UIKit
import Reusable

class RateView: UIView, NibOwnerLoadable {

    
    @IBOutlet weak var rateStackView: UIStackView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var writeCommentButton: UIButton!
    
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
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setupView()
    }
    
    
    func setupView() {
        rateLabel
            .fontSize(22)
            .color(.lightGray)
        rateLabel.text = "0.0"
        
        writeCommentButton.setTitle("WRITE A COMMENT", for: .normal)
        writeCommentButton.setTitleColor(.white, for: .normal)
        writeCommentButton.backgroundColor = .systemBlue
        writeCommentButton.layer.cornerRadius = 6
    }
}
