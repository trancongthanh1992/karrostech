//
//  ReachedScroll.swift
//  KarrosTech
//
//  Created by Tran Cong Thanh on 3/17/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView  {
    
    var reachedBottom: Signal<()> {
        return contentOffset.asDriver()
            .flatMap { [weak base] contentOffset -> Signal<()> in
                guard let scrollView = base else {
                    return Signal.empty()
                }
                
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top
                    - scrollView.contentInset.bottom
                
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                
                let y = contentOffset.y + scrollView.contentInset.top
                return y > threshold ? Signal.just(()) : Signal.empty()
            }
    }
    
    var reachedTrailing: Signal<()> {
        return contentOffset.asDriver()
            .flatMap { [weak base] contentOffset -> Signal<()> in
                guard let scrollView = base else {
                    return Signal.empty()
                }
                
                
                let visibleWidth = scrollView.frame.width - scrollView.contentInset.left
                    - scrollView.contentInset.right
                
                let threshold = max(0.0, scrollView.contentSize.width - visibleWidth)
                
                let x = contentOffset.x + scrollView.contentInset.right
                
                return x > threshold ? Signal.just(()) : Signal.empty()
            }
    }
}
