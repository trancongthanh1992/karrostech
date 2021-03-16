//
//  HomeTableViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/16/21.
//

import UIKit
import RxSwift
import RxCocoa

typealias HomeItemCollectionViewSize = (width: Int, height: Int)

class HomeTableViewCell<T>: UITableViewCell {

    var model: T?

    private var disposeBag = DisposeBag()
    
    var collectionView: UICollectionView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpView(cellClass: AnyClass?,
                   identifier: String,
                   collectionViewItemSize: HomeItemCollectionViewSize) -> Void {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionViewItemSize.width, height: collectionViewItemSize.height)
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.backgroundColor = .white
        collectionView?.register(cellClass, forCellWithReuseIdentifier: identifier)
        self.contentView.addSubview(collectionView!)
        
        
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
    }
    
//    private func customInit() {
//        // View load nib into UIView.
//        let bundle = Bundle.main
//        let nibName = String(describing: Self.self)
//        bundle.loadNibNamed(nibName, owner: self, options: nil)
//        
//        // Add contentView for loading by xib.
//        addSubview(contentView)
//        contentView.frame = bounds
//        contentView.autoresizingMask = [
//            .flexibleWidth,
//            .flexibleHeight
//        ]
//        
//        addActionButtonShadow()
//    }
    
}
