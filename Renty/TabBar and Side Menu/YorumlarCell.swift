//
//  YorumlarCell.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Cosmos

class YorumlarCell: UICollectionViewCell {
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var imgProfil: UIImageView!
    @IBOutlet weak var imgProfil2: UIImageView!
    
    @IBOutlet weak var lblIsim: UILabel!
    @IBOutlet weak var lblIsim2: UILabel!
    
    @IBOutlet weak var lblMesaj: UILabel!
    
    @IBOutlet weak var lblMesaj2: UILabel!
    
    @IBOutlet weak var lblTarih: UILabel!
    
    @IBOutlet weak var lblTarih2: UILabel!
    
    
    @IBOutlet weak var cosmos: CosmosView!
    
    @IBOutlet weak var cosmos2: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view1.roundCorners([.topRight,.bottomLeft,.bottomRight], radius: 15)
        view2.roundCorners([.topRight,.bottomLeft,.bottomRight], radius: 15)
       
        
        imgProfil.heightAnchor.constraint(equalToConstant: 52).isActive = true
        imgProfil.widthAnchor.constraint(equalToConstant: 52).isActive = true
        imgProfil.backgroundColor = .white
        imgProfil.backgroundColor = .white
        imgProfil.layer.cornerRadius = imgProfil.frame.size.height / 2
        imgProfil.contentMode = .scaleAspectFill
        imgProfil.clipsToBounds = true
        
        imgProfil2.heightAnchor.constraint(equalToConstant: 52).isActive = true
        imgProfil2.widthAnchor.constraint(equalToConstant: 52).isActive = true
        imgProfil2.backgroundColor = .white
        imgProfil2.backgroundColor = .white
        imgProfil2.layer.cornerRadius = imgProfil.frame.size.height / 2
        imgProfil2.contentMode = .scaleAspectFill
        imgProfil2.clipsToBounds = true
        
        
        
    }

}
