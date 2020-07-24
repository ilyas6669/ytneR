//
//  BenzerUrunCell.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/11/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class BenzerUrunCell: UICollectionViewCell {

    @IBOutlet weak var imgUrun: UIImageView!
    
    
    
    @IBOutlet weak var lblurun: UILabel!
    
    
    @IBOutlet weak var lblFiyat: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.layer.cornerRadius = 10
        self.imgUrun.layer.cornerRadius = 15
        imgUrun.contentMode = .scaleAspectFit
        
    }

}
