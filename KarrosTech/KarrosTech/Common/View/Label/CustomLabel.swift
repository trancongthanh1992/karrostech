//
//  CustomLabel.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/17/21.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    var fontSize: CGFloat = 15
    var fontName: String = "Helvetica"

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupLabel(fontName: fontName, fontSize: fontSize)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel(fontName: fontName, fontSize: fontSize)
    }
    func setupLabel(fontName: String, fontSize: CGFloat){
        self.font = UIFont(name:fontName,size:fontSize)
    }
}
