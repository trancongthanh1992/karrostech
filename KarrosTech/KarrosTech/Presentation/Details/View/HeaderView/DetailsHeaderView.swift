//
//  DetailsHeaderView.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/29/21.
//

import Foundation
import UIKit
import Reusable

class DetailsHeaderView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottom: NSLayoutConstraint!
    
    
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
        loadNibContent()
        setupView()
    }
    
    private func setupView() {
        movieImageView.clipsToBounds = true
        movieImageView.backgroundColor = .yellow
        movieImageView.contentMode = .scaleAspectFill
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        
        containerViewHeight.constant = scrollView.contentInset.top
        containerView.clipsToBounds = offsetY <= 0
        
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
        
    }
}
