//
//  File.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit


class OzelTextField : UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
}


class OzelTextView : UITextView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
  }
}


