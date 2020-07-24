//
//  Uzanti+UIStackView.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit


extension UIStackView {
    
    @discardableResult
    func withMargin(_ margin : UIEdgeInsets) -> UIStackView {
        layoutMargins = margin
        isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    
    @discardableResult
    func padTop(_ top : CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }
    
    @discardableResult
    func padBottom(_ bottom : CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
    }
    
    @discardableResult
    func padRight(_ right : CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }
    
    @discardableResult
    func padLeft( _ left :CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }
    
}


