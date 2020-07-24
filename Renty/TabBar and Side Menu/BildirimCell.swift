//
//  BildirimCell.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/1/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class BildirimCell: UICollectionViewCell {
    @IBOutlet weak var imgBildirim: UIImageView!
    
    
    @IBOutlet weak var lblBildirim: UILabel!
    
    @IBOutlet weak var lblSaat: UILabel!
    
    
    @IBOutlet weak var lblTarih: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.layer.cornerRadius = 15
        
    }

}
