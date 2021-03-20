//
//  Utils+Extension.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/18/21.
//

import Foundation
import UIKit

extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadius: CGFloat = 6){
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowRadius = cornerRadius
        containerView.layer.shadowOpacity = 0.9
//        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadius).cgPath
        
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
}


extension UIView {
    func applyshadowWithCorner(cornerRadius: CGFloat = 6) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = cornerRadius
        self.layer.shadowOpacity = 0.9
    }
}

extension UILabel{
    
    @discardableResult
    func fontSize(_ size: CGFloat = 15) -> UILabel {
        self.font = UIFont(name: "Helvetica", size: size)
        return self
    }
 
    @discardableResult
    func color(_ color: UIColor = .black) -> UILabel {
        self.textColor = color
        return self
    }
}
