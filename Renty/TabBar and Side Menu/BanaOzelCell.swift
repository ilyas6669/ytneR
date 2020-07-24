//
//  BanaOzelCell.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class BanaOzelCell: UICollectionViewCell {
    
    @IBOutlet weak var imgUrun: UIImageView!
    @IBOutlet weak var lblUrunAdi: UILabel!
    @IBOutlet weak var lblUrunAdi2: UILabel!
    @IBOutlet weak var lblFiyat: UILabel!
    
    @IBOutlet weak var favoritBtn: UIButton!
    
    
    @IBOutlet weak var btnMesaj: UIImageView!
    
    var btnTapAction : (()->())?
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
        
         self.layer.cornerRadius = 15
        imgUrun.layer.cornerRadius = 10
        
        imgUrun.contentMode = .scaleAspectFill
        
        
    }
    
   
    @IBAction func testbtn(_ sender: Any) {
        btnTapAction?()
    }
    
   
    
}
