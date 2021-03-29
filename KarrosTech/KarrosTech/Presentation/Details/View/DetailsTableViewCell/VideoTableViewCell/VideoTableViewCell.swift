//
//  VideoTableViewCell.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/20/21.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import YouTubePlayer

class VideoTableViewCell: UITableViewCell, NibReusable {
    
    let cellWidthConstant: CGFloat = 200
    let cellHeightConstant: CGFloat = 170
    var disposeBag = DisposeBag()
    let playSubject = PublishSubject<(item: VideoEntity,cell: DetailsVideoViewItemCollectionViewCell, indexPath: Int)>()
    
    lazy var collectionView: UICollectionView = { width, height in
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout(width, height))
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(cellType: DetailsVideoViewItemCollectionViewCell.self)
        return collectionView
    }(cellWidthConstant, cellHeightConstant)
    
    var viewModel: DetailsViewModel!
    
    var model: ObResultsVideoModel! {
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


extension VideoTableViewCell {
    private func collectionViewLayout(_ cellWidth: CGFloat, _ cellHeight: CGFloat) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        return layout
    }
    
    private func setupView() {
        
        self.contentView.addSubview(collectionView)
        self.collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

extension VideoTableViewCell {
    
    
    private func bindCollectionView(_ model: ObResultsVideoModel) {
        model
            .map { $0.results }
            .filterNil()
            
            .bind(to: collectionView.rx.items(
                    cellIdentifier: DetailsVideoViewItemCollectionViewCell.reuseIdentifier,
                    cellType: DetailsVideoViewItemCollectionViewCell.self))
            { [unowned self] indexPath, item, cell in
                cell.model = item
                cell.indexPath = indexPath
                cell.playSubject = playSubject
            }
            .disposed(by: disposeBag)
        
        playSubject
            .withLatestFrom(self.model) { modelCell, modelData -> Results<VideoEntity> in

                var videos = modelData.results!.map({
                    return VideoEntity(id: $0.id,
                                       iso639_1: $0.iso639_1,
                                       iso3166_1: $0.iso3166_1,
                                       key: $0.key,
                                       name: $0.name,
                                       site: $0.site,
                                       size: $0.size,
                                       type: $0.type,
                                       isPlay: false
                    )
                })
                
                videos[modelCell.indexPath].isPlay = true

                let results = Results<VideoEntity>(id: modelData.id,
                                                   dates: modelData.dates,
                                                   page: modelData.page,
                                                   results: videos,
                                                   totalPages: modelData.totalPages,
                                                   totalResults: modelData.totalResults
                )
                return results
            }
            .bind(to: self.model)
            .disposed(by: disposeBag)
        
        
    }
}

extension VideoTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let videoCell = collectionView.cellForItem(at: indexPath) as! DetailsVideoViewItemCollectionViewCell
        videoCell.containerView.videoView.pause()
    }
}
