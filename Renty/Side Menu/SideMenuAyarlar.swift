//
//  SideMenuAyarlar.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/16/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class SideMenuAyarlar: UIViewController {
    
//    let btnProfilAyarlari :UIButton = {
//        let btn = UIButton(type: .custom)
//        btn.setImage(UIImage(named: "Ayarlar3"), for: .normal)
//        btn.setTitle("Profil Ayarlari", for: .normal)
//        btn.setTitleColor(.white, for: .normal)
//        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        return btn
//    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutDuzenle()

      let logo = UIImage(named: "Ayarlar-1")
      let imageView = UIImageView(image:logo)
    self.navigationItem.titleView = imageView
    }
    
    
    func layoutDuzenle() {
        //view.addSubview(btnProfilAyarlari)
        
        
        
        
        //_ = btnProfilAyarlari.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 10, left: 5, bottom: 0, right: 0))
    }
    
    
    

    @IBAction func btnLeft(_ sender: Any) {
         
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
