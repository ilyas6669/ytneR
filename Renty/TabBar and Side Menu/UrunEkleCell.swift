//
//  UrunEkleCell.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/3/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit




class UrunEkleCell: UICollectionViewCell {

    @IBOutlet weak var lblTip: UILabel!
    
    @IBOutlet weak var imgTip: UIImageView!
    
    
    @IBOutlet weak var imgTip2: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 28
        
//        self.backgroundColor = .white
        
       
        
    }
    
    
    
    func setData(text:String,img:UIImage,color:UIColor){
        self.lblTip.text = text
        self.imgTip2.image = img
        self.backgroundColor = color
    }
    
    
    

}
