//
//  ExtensionUIColor.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/19/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green : CGFloat,blue : CGFloat) -> UIColor  {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        
        
    }
}


extension UIViewController{
    func hideKeyboardWhenTappedRecongizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardd))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboardd() {
        
        
        view.endEditing(true)
    }
    
    
}
