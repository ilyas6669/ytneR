//
//  EngellenenKullanicilar.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class EngellenenKullanicilar: UIViewController {
    
    let lblUst : UILabel = {
       let lbl = UILabel()
        lbl.text = "*engellenmesini kaldırmak istediğiniz kullanıcının üzerine basılı tutun"
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 11)
        return lbl
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutDuzenle()
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        let logo = UIImage(named: "EngellenenKullanicilar")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        
        
        
        
    }
    
    
    func layoutDuzenle() {
        view.addSubview(lblUst)
        
        
        
        
        _ = lblUst.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding:.init(top: 0, left: 5, bottom: 0, right: 5))
    }
    
    
    @IBAction func btnLeft(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
}
