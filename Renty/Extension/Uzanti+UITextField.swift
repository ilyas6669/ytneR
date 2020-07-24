//
//  Uzanti+UITextField.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    convenience init(text : String?,font : UIFont? = UIFont.systemFont(ofSize: 15),textColor : UIColor = .black,textAlignment  : NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        
    }
}
