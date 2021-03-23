//
//  InfoView.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/12/21.
//

import UIKit
import Reusable

class InfoView: UIView, NibOwnerLoadable {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var totalRateLabel: UILabel!
    @IBOutlet weak var totalRateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var typeStackView: UIStackView!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    func setupView() {
        self.movieImageView.contentMode = .scaleAspectFill
        self.thumbImageView.contentMode = .scaleAspectFit
        self.thumbImageView.applyshadowWithCorner(containerView: shadowView)
        
        self.totalRateLabel.numberOfLines = 1
        self.totalRateLabel.font = UIFont(name: "Helvetica", size: 18)
        //self.totalRateLabel.textColor = .init(red: 241, green: 202, blue: 35, alpha: 255)
        
        self.dateLabel.font = UIFont(name: "Helvetica", size: 18)
        //self.dateLabel.textColor = .init(red: 62, green: 74, blue: 89, alpha: 255)
        
        self.titleLabel.font = UIFont(name: "Helvetica", size: 24)
        //self.titleLabel.textColor = .init(red: 62, green: 74, blue: 89, alpha: 255)
            
        self.contentLabel.numberOfLines = 4
        self.contentLabel.font = UIFont(name: "Helvetica", size: 18)
        //self.contentLabel.textColor = .init(red: 62, green: 74, blue: 89, alpha: 255)
            
        self.readMoreButton.setTitle("Read more", for: .normal)
        
    }
}
