//
//  WelcomeSayfa.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/21/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class WelcomeSayfa: UICollectionViewCell {
    
     let image1 = UIImageView(image: #imageLiteral(resourceName: "re"))
    
     let lbl1 : UILabel = {
        let lbl = UILabel()
        lbl.text = "Merhaba!"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 23, weight: .light)
        return lbl
    }()
    
    
    

    override init(frame: CGRect) {
    super.init(frame: frame)

        self.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        
       
        
        
        addSubview(lbl1)
        
        addSubview(image1)
        
        
        _ = lbl1.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 40, bottom: 120, right: 40))
        
       
        _ = image1.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
   
}
