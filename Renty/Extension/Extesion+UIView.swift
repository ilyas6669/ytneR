//
//  Extesion+UIView.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//
import Foundation
import UIKit

struct AnchorConstraintss {
    var top : NSLayoutConstraint?
    var bottom : NSLayoutConstraint?
    var trailng : NSLayoutConstraint?
    var leading : NSLayoutConstraint?
    var width : NSLayoutConstraint?
    var heaight : NSLayoutConstraint?
    
}

extension UIView {
    func anchor(top : NSLayoutYAxisAnchor?,
                bottom : NSLayoutYAxisAnchor?,
                leading : NSLayoutXAxisAnchor?,
                trailing : NSLayoutXAxisAnchor?,
                padding : UIEdgeInsets = .zero,
                boyut : CGSize = .zero) -> AnchorConstraintss {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var aConstraint = AnchorConstraintss()
        
        if let top = top {
            aConstraint.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let bottom = bottom {
            aConstraint.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let leading = leading {
            aConstraint.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let trailing = trailing {
            aConstraint.trailng = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if boyut.width != 0 {
            aConstraint.width = widthAnchor.constraint(equalToConstant: boyut.width)
        }
        
        if boyut.height != 0 {
            aConstraint.heaight = heightAnchor.constraint(equalToConstant: boyut.height)
        }
        
        [aConstraint.top,aConstraint.bottom,aConstraint.trailng,aConstraint.leading,aConstraint.width,aConstraint.heaight].forEach {$0?.isActive = true}
        
        return aConstraint
        
    }
    
    func doldurSuperView(padding : UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let sTop = superview?.topAnchor {
            topAnchor.constraint(equalTo: sTop, constant: padding.top).isActive = true
        }
        
        if let sBottom = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: sBottom, constant: padding.bottom).isActive = true
            
        }
        
        if let sLeading = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: sLeading, constant: padding.left).isActive = true
        }
        
        if let sTrailing = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: sTrailing, constant: -padding.right).isActive = true
        }
        
        
    }
    
    func merkezKonumlamdirmaSuperView(boyut : CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let merkezX = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: merkezX).isActive = true
        }
        
        if let merkezY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: merkezY).isActive = true
        }
        
        if boyut.height != 0 {
            heightAnchor.constraint(equalToConstant: boyut.height).isActive = true
        }
        if boyut.width != 0 {
            widthAnchor.constraint(equalToConstant: boyut.width).isActive = true
        }
        
    }
    
    func merkezY(_ anchor : NSLayoutXAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    func merkezX(_ anchor : NSLayoutYAxisAnchor) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    func merkezXSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superViewCenterXanchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXanchor).isActive = true
        }
    }
    
    func merkezYSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superViewCenterYanchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superViewCenterYanchor).isActive = true
        }
    }
    
    @discardableResult
    func constraintYukseklik(_ yukseklik : CGFloat) -> AnchorConstraintss {
        translatesAutoresizingMaskIntoConstraints = false
        var const = AnchorConstraintss()
        
        const.heaight = heightAnchor.constraint(equalToConstant: yukseklik)
        const.heaight?.isActive = true
        return const
    }
    
    @discardableResult
    func constraintGenislik(_ genislik : CGFloat) -> AnchorConstraintss {
        translatesAutoresizingMaskIntoConstraints = false
        var const = AnchorConstraintss()
        
        const.width = widthAnchor.constraint(equalToConstant: genislik)
        const.width?.isActive = true
        return const
    }
    
    func golgeEkle(opacity : Float = 0,yaricap : CGFloat = 0 ,offset : CGSize = .zero,renk : UIColor = .black){
        layer.shadowOpacity = opacity
        layer.shadowRadius = yaricap
        layer.shadowOffset = offset
        layer.shadowColor = renk.cgColor
    }
    
    convenience init(arkaPlanRenk: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = arkaPlanRenk
    }

    
}
