//
//  BindableType.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/16/21.
//

import Foundation
import UIKit

public protocol BindableType: class {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    public func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
