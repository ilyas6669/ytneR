//
//  CikisYapPop.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
//yetim he yoxu icine pox tek tek ansdorid ios da axtaardim hesene yoxdu yetim sen bidene o dediyi urunu silde yukluyeh getsin hecn problem yaranmir axi bele qalanda mene 2 defe deyibde sefaki neyese girende atir ona gore baxirdim bu o biri lipixida tpammiram test olan itemi 		
class CikisYapPop: UIView {
    
    weak var controller:UIViewController!
    
    let imgCikis = UIImageView(image: #imageLiteral(resourceName: "logout"))
    
    let lblCikis : UILabel = {
       let lbl = UILabel()
        lbl.text = "Çıkış Yap"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    let lblCikis2 : UILabel = {
       let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.numberOfLines = 2
        lbl.text = "Çıkış yapmak istediğinizden emin\nmisiniz?"
        return lbl
    }()
    
    let btnEvet : UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.rgb(red: 201, green: 213, blue: 51), for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitle("EVET", for: .normal)
        button.addTarget(self, action: #selector(evetAction), for: .touchUpInside)
        return button
    }()
    
    let btnHayir : UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.rgb(red: 201, green: 213, blue: 51), for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitle("HAYIR", for: .normal)
        button.addTarget(self, action: #selector(hayirAction), for: .touchUpInside)
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(imgCikis)
        addSubview(lblCikis)
        addSubview(lblCikis2)
        addSubview(btnEvet)
        addSubview(btnHayir)
        
        
        
        
        _ = imgCikis.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil,padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        _ = lblCikis.anchor(top: topAnchor, bottom: nil, leading: imgCikis.trailingAnchor, trailing: nil,padding: .init(top: 18, left: 10, bottom: 0, right: 0))
        _ = lblCikis2.anchor(top: imgCikis.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        _ = btnHayir.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 10, right: 0))
        _ = btnEvet.anchor(top: nil, bottom: bottomAnchor, leading: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 10))
        
        
        
    }
    
    @objc func evetAction() {
//        try! Auth.auth().signOut()
        do {
            try Auth.auth().signOut()
            let login = Login()
            login.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(login, animated: true, completion: nil)
            
            
        } catch {
            print("error")
        }
    }
    
    @objc func hayirAction() {
        
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
      vc.selectedIndex = 0
      vc.modalPresentationStyle = .fullScreen
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
}


extension UIApplication {

    static func topViewController() -> UIViewController? {
        guard var top = shared.keyWindow?.rootViewController else {
            return nil
        }
        while let next = top.presentedViewController {
            top = next
        }
        return top
    }
}
