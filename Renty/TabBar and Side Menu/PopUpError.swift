//
//  PopUpError.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/17/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class PopUpError: UIView {

    let imgError : UIImageView = {
       let img = UIImageView(image: #imageLiteral(resourceName: "alert"))
        return img
    }()
    
    let lblError : UILabel = {
       let lbl = UILabel()
        lbl.text = "Lütfen en az 1 fotoğraf ekleyin"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 19)
            
        return lbl
    }()
    
    
    override init(frame: CGRect) {
       super.init(frame: frame) 
        backgroundColor = .rgb(red: 201, green: 213, blue: 51)
        addSubview(imgError)
        addSubview(lblError)
        
        
        _ = imgError.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 5, right: 0))
        _ = lblError.anchor(top: topAnchor, bottom: nil, leading: imgError.trailingAnchor, trailing: nil,padding: .init(top: 40, left: 2, bottom: 0, right: 1))
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
