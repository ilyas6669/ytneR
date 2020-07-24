//
//  SideMenuCikisYap.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/16/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class SideMenuCikisYap: UIViewController {
    
    let cikisYapPop: CikisYapPop = {
        let view = CikisYapPop()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
            
        let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "left1"), style: .done, target: self, action: #selector(leftActionn))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 1
        
        
        view.addSubview(cikisYapPop)
        cikisYapPop.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        cikisYapPop.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cikisYapPop.heightAnchor.constraint(equalToConstant: 145).isActive = true
        cikisYapPop.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        cikisYapPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        cikisYapPop.alpha = 0
        UIView.animate(withDuration: 0.5) {
            //self.visualEffectView.alpha = 1
            self.cikisYapPop.alpha = 1
            self.cikisYapPop.transform = CGAffineTransform.identity
        }
    }
    
    
    @objc func leftActionn() {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
       vc.selectedIndex = 0
       vc.modalPresentationStyle = .fullScreen
       self.present(vc, animated: true, completion: nil)
    }
    

   
}
