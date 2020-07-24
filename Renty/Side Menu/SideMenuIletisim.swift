//
//  SideMenuIletisim.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/16/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class SideMenuIletisim: UIViewController {
    
    let imgPhone : UIImageView = {
    let img = UIImageView(image: #imageLiteral(resourceName: "phone"))
        return img
    }()
    
    let lblPhone :UILabel = {
       let lbl = UILabel()
        lbl.text = "Telefon"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 24)
        return lbl
    }()

    let lblNumber :UILabel = {
       let lbl = UILabel()
        lbl.text = "0546 236 68 07"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 24)
        return lbl
    }()
    
    let imgWeb :UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "internet"))
        return img
    }()
    
    let lblMail :UILabel = {
       let lbl = UILabel()
        lbl.text = "Mail"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 24)
        return lbl
    }()
    
    let lblInfo :UILabel = {
       let lbl = UILabel()
        lbl.text = "info@rentyapp.co"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 24)
        return lbl
    }()
    
    let lblwww :UILabel = {
       let lbl = UILabel()
        lbl.text = "www.rentyapp.co"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 24)
        return lbl
    }()
    
    let imgSosyal :UIImageView = {
       let img = UIImageView(image: #imageLiteral(resourceName: "phone-2"))
        return img
    }()
    
    let lblSosyal :UILabel = {
       let lbl = UILabel()
        lbl.text = "Sosyal Medya"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 24)
        return lbl
    }()
    
    let lblwww2 :UILabel = {
       let lbl = UILabel()
        lbl.text = "www.instagram.com/rentyapp.co"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 22)
        return lbl
    }()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layotDuzenle()
        
        
        let logo = UIImage(named: "Iletısım")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

    }
    
    func layotDuzenle() {
        view.addSubview(imgPhone)
        view.addSubview(lblPhone)
        view.addSubview(lblNumber)
        view.addSubview(imgWeb)
        view.addSubview(lblMail)
        view.addSubview(lblInfo)
        view.addSubview(lblwww)
        view.addSubview(imgSosyal)
        view.addSubview(lblSosyal)
        view.addSubview(lblwww2)
        
        
        _ = imgPhone.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 10, left: 25, bottom: 0, right: 0))
        _ = lblPhone.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: imgPhone.trailingAnchor, trailing: nil,padding: .init(top: 15, left: 10, bottom: 0, right: 0))
        _ = lblNumber.anchor(top: lblPhone.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 25, bottom: 0, right: 0))
        _ = imgWeb.anchor(top: lblNumber.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 20, left: 25, bottom: 0, right: 0))
        _ = lblMail.anchor(top: lblNumber.bottomAnchor, bottom: nil, leading: imgWeb.trailingAnchor, trailing: nil,padding: .init(top: 20, left: 10, bottom: 0, right: 0))
        _ = lblInfo.anchor(top: imgWeb.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 25, bottom: 0, right: 0))
        _ = lblwww.anchor(top: lblInfo.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 25, bottom: 0, right: 0))
        _ = imgSosyal.anchor(top: lblwww.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 20, left: 25, bottom: 0, right: 0))
        _ = lblSosyal.anchor(top: lblwww.bottomAnchor, bottom: nil, leading: imgSosyal.trailingAnchor, trailing: nil,padding: .init(top: 20, left: 10, bottom: 0, right: 0))
        _ = lblwww2.anchor(top: lblSosyal.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 25, bottom: 0, right: 0))
    }
    
    
    
    @IBAction func btnLeft(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
