//
//  BlackedView.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/27/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class BlackedView: UIViewController {
    
    let imgBlock = UIImageView(image: #imageLiteral(resourceName: "block"))
    let lblBlocked : UILabel = {
       let lbl = UILabel()
        lbl.text = "Admin tarafindan block olundunuz"
        lbl.textColor = .white
        lbl.numberOfLines = 4
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        
        //backgraoundGradient()
        view.addSubview(imgBlock)
        view.addSubview(lblBlocked)
        
        imgBlock.translatesAutoresizingMaskIntoConstraints = false
        
        imgBlock.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgBlock.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        lblBlocked.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lblBlocked.topAnchor.constraint(equalTo: imgBlock.bottomAnchor,constant: 20).isActive = true
    
        
            }
    
    
     
    
//
//    fileprivate func backgraoundGradient() {
//        let gradient = CAGradientLayer()
//        let ustRenk = #colorLiteral(red: 0, green: 0.1490196078, blue: 0.1019607843, alpha: 1)
//        let alrRenk = #colorLiteral(red: 0.01568627451, green: 0.5490196078, blue: 0.3882352941, alpha: 1)
//        gradient.colors = [ustRenk.cgColor,alrRenk.cgColor]
//        gradient.locations = [0,1]
//        view.layer.addSublayer(gradient)
//        gradient.frame = view.bounds
//    }
   

}
