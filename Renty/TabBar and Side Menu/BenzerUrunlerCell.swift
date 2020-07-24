//
//  BenzerUrunlerCell.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/27/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class BenzerUrunlerCell: UICollectionViewCell {
    @IBOutlet weak var lblUrunAdi: UILabel!
    
    
    @IBOutlet weak var urunImg: UIImageView!
    
    
    @IBOutlet weak var fiyatLbl: UILabel!
    
    
    override func awakeFromNib() {
             super.awakeFromNib()
        
        urunImg.layer.cornerRadius = 10
        self.layer.cornerRadius = 15
        
    }
    
}
