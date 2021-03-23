//
//  CategoryCollectionViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/16/21.
//

import UIKit
import RxSwift
import Kingfisher
import Reusable

class CategoryCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var title: UILabel!
 
    private var disposeBag: DisposeBag!
    
    var model: GenreEntity! {
        didSet {
            bindingModel(model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }

    func setupView() -> Void {
        self.title.fontSize(16)
        self.containerView.layer.cornerRadius = 6
        self.containerView.backgroundColor = .blue
        self.containerView.layer.masksToBounds = true
        self.shadowView.applyshadowWithCorner(cornerRadius: 6)
    }
    
    private func bindingModel(_ model: GenreEntity) -> Void {
        title.text = model.name
    }
    
}
