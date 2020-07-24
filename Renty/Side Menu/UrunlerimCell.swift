//
//  UrunlerimCell.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/22/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class UrunlerimCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgUrunn: UIImageView!
    
    
    @IBOutlet weak var lblUrunIsmi: UILabel!
    
    @IBOutlet weak var lblUrunFIyati: UILabel!
    
    
    @IBOutlet weak var lblUrunAciklama: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         imgUrunn.contentMode = .scaleAspectFill
        imgUrunn.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        
    }

}
