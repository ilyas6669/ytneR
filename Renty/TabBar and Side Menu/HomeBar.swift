//
//  HomeBar.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/29/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CarbonKit


class HomeBar: UIViewController,CarbonTabSwipeNavigationDelegate {
   
    var controllerNames = ["BANA ÖZEL","KATEGORİLER"]
    var carbonTabSwipeNavigation = CarbonTabSwipeNavigation()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let logo = UIImage(named: "ic_asset_logo-1")
        let imageView = UIImageView(image:logo)
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        self.navigationItem.titleView = imageView
        imageView.isUserInteractionEnabled = true
        let gestureRecongizer = UITapGestureRecognizer(target: self, action: #selector(rentyAnaSayfa))
        imageView.addGestureRecognizer(gestureRecongizer)
        
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: controllerNames, delegate: self)
        carbonTabSwipeNavigation.setTabBarHeight(50)
        carbonTabSwipeNavigation.setNormalColor(UIColor.white)
        carbonTabSwipeNavigation.setSelectedColor(UIColor.white)
        carbonTabSwipeNavigation.setIndicatorColor(UIColor.white)
        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(view.frame.width/2, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(view.frame.width/2, forSegmentAt: 1)
        
        
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
       
    
    }
    
    @objc func rentyAnaSayfa() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        guard let storyboard = storyboard else {return UIViewController()} 
        if index == 0
        {
            return storyboard.instantiateViewController(identifier: "BanaOzel")
        }
        else
        {
            return storyboard.instantiateViewController(identifier: "Kategoriler")
        }
        
        
       }

   
    
    }
   


