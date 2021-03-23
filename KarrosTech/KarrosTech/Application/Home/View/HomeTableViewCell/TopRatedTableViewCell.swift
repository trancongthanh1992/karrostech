//
//  TopRatedTableViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/19/21.
//

import UIKit
import Reusable
import RxSwift

class TopRatedTableViewCell: UITableViewCell, NibReusable {

    let cellWidthConstant: CGFloat = 140
    let cellHeightConstant: CGFloat = 260
    private var disposeBag: DisposeBag = DisposeBag()
        
    var viewModel: HomeViewModel!
    
    var model: ObResultsTopRatedModel! {
        didSet {
            self.bindCollectionView(model)
        }
    }
    
    var modelSelected: ((TopRatedEntity) -> Void)!
    
    lazy var collectionView: UICollectionView = { width, height in
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout(width, height))
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(cellType: TopRatedCollectionViewCell.self)
        return collectionView
    }(cellWidthConstant, cellHeightConstant)
    
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

extension TopRatedTableViewCell {
    

    private func bindCollectionView(_ model: ObResultsTopRatedModel) {
        model
            .map { model in model.results }
            .filterNil()
            .bind(to: collectionView.rx.items(cellIdentifier: TopRatedCollectionViewCell.reuseIdentifier, cellType: TopRatedCollectionViewCell.self))
            { indexPath, item, cell in
                cell.model = item
            }
            .disposed(by: disposeBag)
        
        collectionView.rx
            .reachedTrailing
            .asObservable()
            .debounce(0.8, scheduler: MainScheduler.instance)
            .withLatestFrom(model, resultSelector: { $1 })
            .map { (page: $0.page!, total: $0.totalPages!) }
            .bind(to: self.viewModel!.loadMoreTopRatedTrigger)
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(TopRatedEntity.self)
            .subscribe(onNext: { [unowned self] model in
                self.modelSelected(model)
            })
            .disposed(by: disposeBag)
    }
    
}

extension TopRatedTableViewCell {
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
