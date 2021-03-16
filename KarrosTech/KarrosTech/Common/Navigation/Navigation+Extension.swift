//
//  Navigation+Extension.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/16/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
     func setNavigationBarColor(color: UIColor = UIColor.white) -> Void{
        self.navigationBar.tintColor = color
        self.navigationBar.barTintColor = color
        self.navigationBar.isTranslucent = false
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.backgroundColor = UIColor.clear
     }
    
    func setNavigationBarShadow() -> Void {
        self.navigationBar.layer.masksToBounds = false
        self.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationBar.layer.shadowRadius = 4.0
        self.navigationBar.layer.shadowOpacity = 0.22
    }
    
    func setNavigationBarLogo(image: String = "logo", imageHeight: CGFloat = 27) -> Void {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: image)

        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func setNavigationBarButtonRight(image: String = "", action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: image), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
}
