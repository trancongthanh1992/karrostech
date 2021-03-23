//
//  YourRateTableViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/20/21.
//

import UIKit
import Reusable
import RxSwift

class YourRateTableViewCell: UITableViewCell, NibReusable {

    let cellWidthConstant: CGFloat = 300
    let cellHeightConstant: CGFloat = 160
    
    @IBOutlet weak var containerView: RateView!
    
    var viewModel: DetailsViewModel!
    
    var model: ObYourRateModel! {
        didSet {
            self.bindCollectionView(model)
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

extension YourRateTableViewCell {
    
    private func bindCollectionView(_ model: ObYourRateModel) {

    }
}
