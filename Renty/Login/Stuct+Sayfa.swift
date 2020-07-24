//
//  Stuct+Sayfa.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/21/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit


struct Sayfa {
    let goruntu : String
    let baslik : String
    
}

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}


extension UITextField {
    func loginIcon(_ image : UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 8, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconConteinerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconConteinerView.addSubview(iconView)
        leftView = iconConteinerView
        leftViewMode = .always
    }
}

extension UITextField {
    func rigticonn(_ image : UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 8, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconConteinerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconConteinerView.addSubview(iconView)
        rightView = iconConteinerView
        rightViewMode = .always
    }
}
