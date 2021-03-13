//
//  HeaderSectionView.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/13/21.
//

import UIKit

class HeaderSectionView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadMore: UIButton!
    
    
    // headerHome
    // headerHomeRecommend 61
    // headerCateogry 59
    // headerPopular 59
    // headerTopRated: 59
    
    // headerDetail 48

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func onLoadMore(_ sender: Any) {
        
    }
    
}
//
//extension HeaderSectionView: HeaderSectionViewable {
//    var titleHeader: String {
//        get {
//            self.title.text ?? ""
//        }
//       
//    }
//
//    var isShowViewMore: Bool {
//        get {
//            <#code#>
//        }
//        
//    }
//
//    var backgroundColor: String {
//        get {
//            <#code#>
//        }
//        
//    }
//
//    var fontSize: Int {
//        get {
//            <#code#>
//        }
//        
//    }
//
//
//}
