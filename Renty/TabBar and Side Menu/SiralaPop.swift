//
//  SiralaPop.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/25/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit



class SiralaPop: UIView {
    
//    let views : SiralaPop = {
//        let view = SiralaPop()
//        return view
//    }()
    
    let view6 : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        view.layer.cornerRadius = 37
        view.heightAnchor.constraint(equalToConstant: 232).isActive = true
        view.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return view
    }()
    
    let imgSirala : UIImageView = {
       let img = UIImageView(image: #imageLiteral(resourceName: "swap"))
        return img
    }()
    
    let lblSirala : UILabel = {
       let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.text = "Sırala"
        lbl.font = UIFont.boldSystemFont(ofSize: 19)
        return lbl
    }()
    
  
    

    override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .rgb(red: 4, green: 140, blue: 99)
        
        let imgSiralaSV = UIStackView(arrangedSubviews: [imgSirala,lblSirala])
        imgSiralaSV.axis = .horizontal
        imgSiralaSV.spacing = 5
        imgSiralaSV.translatesAutoresizingMaskIntoConstraints = false
        
       
        
        addSubview(view6)
//        view6.addSubview(buttonlar)
        addSubview(imgSiralaSV)
    

        _ = view6.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        imgSiralaSV.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //imgSiralaSV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgSiralaSV.topAnchor.constraint(equalTo: topAnchor,constant: 20).isActive = true
//
//        buttonlar.centerXAnchor.constraint(equalTo: view6.centerXAnchor).isActive = true
//        buttonlar.centerYAnchor.constraint(equalTo: view6.centerYAnchor).isActive = true
        
    
    
}
    
    
    
    
    @objc func enYeniClicked() {
      
    }
    
    
    
   
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
