//
//  Extension+StackView.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}


//class TextFieldd: UITextField{
//    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
