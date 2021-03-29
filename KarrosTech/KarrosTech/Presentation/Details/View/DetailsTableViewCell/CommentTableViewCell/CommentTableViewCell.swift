//
//  CommentTableViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/20/21.
//

import UIKit
import Reusable
import RxSwift
import Kingfisher

class CommentTableViewCell: UITableViewCell, NibReusable {
//
//    let cellWidthConstant: CGFloat = 300
//    let cellHeightConstant: CGFloat = 138
    
    @IBOutlet weak var containerView: CommentViewItem!
    var viewModel: DetailsViewModel!
    
    var model: ReviewEntity! {
        didSet {
            self.bind(model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.userAvatarImageView.kf.cancelDownloadTask()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CommentTableViewCell {
    
    private func bind(_ model: ReviewEntity) {
        containerView.contentLabel.text = model.content
        containerView.userNameLabel.text = model.author
        
        if let createAt = model.createdAt {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            if let diffDate = dateFormatterGet.date(from: createAt) {
                containerView.datetimeLabel.text = diffDate.relativeTime
            }
        }
        
        if let urlStr = model.authorDetails?.avatarPath, let url = URL(string: urlStr)  {
            containerView.userAvatarImageView.kf.setImage(with: url)
        }
    }
}
