//
//  DaireselImageView.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit
import Firebase

open class DaireselImageView : UIImageView {
    public  init(genislik : CGFloat,image : UIImage? = nil ) {
        super.init(image: image)
        
        contentMode = .scaleAspectFill
        
        if genislik != 0 {
            widthAnchor.constraint(equalToConstant: genislik).isActive = true
            
        }
        
        heightAnchor.constraint(equalToConstant: genislik).isActive = true
        clipsToBounds = true
    }
    
    open override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = frame.width / 2
    }
    
    
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 
}
