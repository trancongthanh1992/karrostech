//
//  CommentTableViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/20/21.
//

import UIKit
import Reusable
import RxSwift

class CommentTableViewCell: UITableViewCell, NibReusable {
//
//    let cellWidthConstant: CGFloat = 300
//    let cellHeightConstant: CGFloat = 138
    
    var viewModel: DetailsViewModel!
    
    var model: ReviewModel! {
        didSet {
//            self.bindCollectionView(model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CommentTableViewCell {
    
    private func bind(_ model: ReviewModel) {
        
    }
}
