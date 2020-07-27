//
//  MesajlarCell.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class MesajlarCell: UICollectionViewCell {

    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lbbMesaj: UILabel!
    @IBOutlet weak var lblIsim: UILabel!
    @IBOutlet weak var lblTarih: UILabel!
    @IBOutlet weak var lblSaat: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 15
        
      imgUser.image = UIImage(named: "user1")
       imgUser.backgroundColor = .white
       imgUser.contentMode = .scaleAspectFill
       imgUser.layer.borderWidth = 4
       imgUser.layer.masksToBounds = false
       imgUser.layer.borderColor = UIColor.rgb(red: 0, green: 90, blue: 63).cgColor
       imgUser.layer.cornerRadius = imgUser.frame.size.height / 2
       imgUser.clipsToBounds = true
        
    }

}
