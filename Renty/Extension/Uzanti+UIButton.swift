//
//  Uzanti+UIButton.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    convenience init(baslik : String,baslikRenk : UIColor,baslikFont : UIFont = .systemFont(ofSize: 15),arkaPlanRenk : UIColor = .clear,target : Any? = nil, action : Selector? = nil){
        
        
        
        self.init(type: .system)
        
        setTitle(baslik, for: .normal)
        
        setTitleColor(baslikRenk, for: .normal)
        
        self.titleLabel?.font = baslikFont
        self.backgroundColor = arkaPlanRenk
        
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
            
            
        }
    }
    
    
    convenience init(image : UIImage,tintColor : UIColor? = nil,target : Any? = nil,action : Selector? = nil) {
        self.init(type : .system)
        
        
        if tintColor == nil {
            setImage(image, for: .normal)
        }else {
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
