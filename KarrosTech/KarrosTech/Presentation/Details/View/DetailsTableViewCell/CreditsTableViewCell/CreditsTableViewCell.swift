//
//  CreditsTableViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/20/21.
//

import UIKit
import Reusable
import RxSwift

class CreditsTableViewCell: UITableViewCell, NibReusable {

    let cellWidthConstant: CGFloat = 70
    let cellHeightConstant: CGFloat = 180
    var disposeBag = DisposeBag()

    lazy var collectionView: UICollectionView = { width, height in

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout(width, height))
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(cellType: DetailsSeriesViewItemCollectionViewCell.self)
        return collectionView
    }(cellWidthConstant, cellHeightConstant)
    
    var viewModel: DetailsViewModel!
    
    var model: ObCreditsModel! {
        didSet {
            self.bindCollectionView(model)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}


extension CreditsTableViewCell {
    private func collectionViewLayout(_ cellWidth: CGFloat, _ cellHeight: CGFloat) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        return layout
    }
    
    private func setupView() {
        
        self.contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

extension CreditsTableViewCell {
    
    private func bindCollectionView(_ model: ObCreditsModel) {
        model
            .map { $0.crew }
            .filterNil()
            .bind(to: collectionView.rx.items(
                    cellIdentifier: DetailsSeriesViewItemCollectionViewCell.reuseIdentifier,
                    cellType: DetailsSeriesViewItemCollectionViewCell.self))
            { indexPath, item, cell in
                cell.model = item
            }
            .disposed(by: disposeBag)
    }
}
