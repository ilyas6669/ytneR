//
//  TextFieldIntend.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit

class TextFieldIntend : UITextField {
    
    let padding : CGFloat
    
    public init(placeholder : String? = nil,padding : CGFloat = 0, cornerRadius : CGFloat = 0, keuboardType : UIKeyboardType = .default, backgroundColor : UIColor = UIColor.clear, isSecurtyTextEntry : Bool = false) {
        
        self.padding = padding
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
