//
//  ProfilBar.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/29/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CarbonKit
import Firebase
import Cosmos
import MessageUI


class ProfilBar: UIViewController,CarbonTabSwipeNavigationDelegate,UIGestureRecognizerDelegate {
    

    
    let popUpWindow: PopUpWindow = {
        let view = PopUpWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 37
        return view
}()
        
    let visualEffectView : UIVisualEffectView = {
    let blurEffect = UIBlurEffect(style: .light)
    let view = UIVisualEffectView(effect: blurEffect)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()
    
    var controllerNames = ["ÜRÜNLERİM","ALDIKLARIM","FAVORILERIM"]
    var carbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    
    let transiton = SildeInTransition()
    
    let cover = UIImageView(image: #imageLiteral(resourceName: "cover"))
    
    let btnPopMenu: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setImage(UIImage(named: "icmenu"), for: .normal)
        btn.addTarget(self, action: #selector(btnPopClicked), for: .touchUpInside)
        return btn
}()
    
   
    
    let profilImage : UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        img.image = UIImage(named: "user1")
        img.heightAnchor.constraint(equalToConstant: 120).isActive = true
        img.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        img.contentMode = .scaleAspectFill
        img.layer.borderWidth = 4
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.rgb(red: 0, green: 90, blue: 63).cgColor
        img.layer.cornerRadius = img.frame.size.height / 2
        img.clipsToBounds = true
        img.backgroundColor = .white
       
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
}()
    
    let btnUrunEkle : UIButton = {
       let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "profilurunekle"), for: .normal)
        btn.layer.cornerRadius = 0.5 * btn.bounds.size.width
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(kecurunEkle), for: .touchUpInside)
        return btn
    }()
    
    let lblIsim : UILabel =  {
    let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 19)
        return lbl
        
}()
    
    let cosmos : CosmosView = {
        let cosmos = CosmosView()
        cosmos.rating = 0
        cosmos.settings.updateOnTouch = false
        cosmos.settings.emptyBorderColor = UIColor.rgb(red: 51, green: 81, blue: 72)
        cosmos.settings.filledColor = UIColor.yellow
        
        cosmos.settings.starMargin = 0
        
        return cosmos
    }()
    
    let view1 = UIView()
    
    var userid = ""
    
    
    var itemlist : [NSDictionary] = []
    
    private var tap: UITapGestureRecognizer!
    
    let col = Urunlerim()
    
    let btnLeftPop : UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "left1"), for: .normal)
        btn.addTarget(self, action: #selector(popLeftAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        layoutDuzenle()
        controluser()
        getuserveri()
        
        
        
       
    }
    
    
    
    
    func layoutDuzenle() {
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: controllerNames, delegate: self)
        carbonTabSwipeNavigation.setTabBarHeight(50)
        carbonTabSwipeNavigation.setNormalColor(UIColor.white)
        carbonTabSwipeNavigation.setSelectedColor(UIColor.white)
        carbonTabSwipeNavigation.setIndicatorColor(UIColor.white)
        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(view.frame.width/3, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(view.frame.width/3, forSegmentAt: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(view.frame.width/3, forSegmentAt: 2)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: view1)
        
      
        popUpWindow.btnAyarlar.addTarget(self, action: #selector(getAyaralara), for: .touchUpInside)
        
        
       
        
//        self.tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
//        self.tap.delegate = self
//        //gestureREcongizer.cancelsTouchesInView = false
//        self.view.addGestureRecognizer(self.tap)
        
        let logo = UIImage(named: "ic_asset_logo-1")
        let imageView = UIImageView(image:logo)
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        self.navigationItem.titleView = imageView
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(anaSayfaAction))
        imageView.addGestureRecognizer(gesture)
        
        view.addSubview(cover)
        view.addSubview(profilImage)
        view.addSubview(lblIsim)
        view.addSubview(btnPopMenu)
        
        view.addSubview(view1)
        view.addSubview(btnUrunEkle)
        view.addSubview(cosmos)
        view.addSubview(visualEffectView)
       
        
        
        _ = cosmos.anchor(top: lblIsim.bottomAnchor, bottom: nil, leading: profilImage.trailingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 0, right: 0))
         _ = profilImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 30, left: 20, bottom: 0, right: 0))

        cover.heightAnchor.constraint(equalToConstant: 80).isActive = true
        _ = cover.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = lblIsim.anchor(top: cover.bottomAnchor, bottom: nil, leading: profilImage.trailingAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 7, right: 0),boyut: .init(width: 100, height: 20))
        _ = btnPopMenu.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 20))
        
        _ = btnUrunEkle.anchor(top: cover.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 10))
        _ = view1.anchor(top: profilImage.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
        popUpWindow.btnRaporEt.addTarget(self, action: #selector(btnRaporEtAction), for: .touchUpInside)
        
        
        
    }
    
    @objc func btnPopClicked() {
           print("test")
           view.addSubview(popUpWindow)
           popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
           popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           popUpWindow.heightAnchor.constraint(equalToConstant: 200).isActive = true
           popUpWindow.widthAnchor.constraint(equalToConstant: 250).isActive = true
        view.addSubview(btnLeftPop)

        btnLeftPop.topAnchor.constraint(equalTo: view.topAnchor,constant: 10).isActive = true
        btnLeftPop.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
           
           popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           popUpWindow.alpha = 0
        btnLeftPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           UIView.animate(withDuration: 0.5) {
               self.visualEffectView.alpha = 1
               self.popUpWindow.alpha = 1
               self.popUpWindow.transform = CGAffineTransform.identity
            self.btnLeftPop.alpha = 1
            self.btnLeftPop.transform = CGAffineTransform.identity
            
           }
         
       }
    
    
    @objc func popLeftAction() {
        UIView.animate(withDuration: 0.5, animations: {
                      self.visualEffectView.alpha = 0
                      self.popUpWindow.alpha = 0
            self.btnLeftPop.alpha = 0
                          self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
             self.btnLeftPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                  }) { (_) in
                      self.popUpWindow.removeFromSuperview()
                    self.btnLeftPop.removeFromSuperview()

                  }
        
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.col.collectionView) == true {
            return false
        }
        return true
    }
    
    
    @objc func btnRaporEtAction() {
        guard MFMailComposeViewController.canSendMail() else {
                   makeAlertt(tittle: "Geri Bildirim", message: "Bu eylemi hiç bir uygulama gerçekleştiremez")
                   return
               }
               let composer = MFMailComposeViewController()
               composer.mailComposeDelegate = self
               composer.setToRecipients(["test@gmail.com"])
               composer.setSubject("Hata")
               
               present(composer, animated: true, completion: nil)
    }
    
    @objc func anaSayfaAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
               vc.selectedIndex = 0
               vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true, completion: nil)
      }
    
    @objc func getAyaralara() {
//        let ayarlar = ProfilAyarlari()
//        present(ayarlar, animated: true, completion: nil)
        
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SideMenuAyarlar") as? SideMenuAyarlar
        vc?.modalPresentationStyle = .automatic
        self.present(vc!, animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc!, animated: true)
        
       
    }
    
  
    
    func getuserveri(){
        
        
        let userRef = Database.database().reference().child("user").child(userid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let namesurname = value?["namesurname"] as? String ?? ""
            let profilepicture = value?["profilepicture"] as? String ?? ""
            let userrate = value?["userrate"] as? String ?? ""
            
            self.lblIsim.text = namesurname
            self.cosmos.rating = Double(userrate)!
            
            if(profilepicture != ""){
                self.profilImage.sd_setImage(with: URL(string: "\(profilepicture)"))
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    @objc func kecurunEkle() {
        self.tabBarController?.selectedIndex = 2
    }
    
    func makeAlert(tittle: String, message : String) {
               let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
               let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
               alert.addAction(okButton)
               self.present(alert, animated: true, completion: nil)
       }
    
    
    
       func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
                 guard let storyboard = storyboard else {return UIViewController()}
                 if index == 0
                 {
                     return storyboard.instantiateViewController(identifier: "Urunlerim")
                 }
                  else if index == 1
                 {
                     return storyboard.instantiateViewController(identifier: "Aldiklarim")
                 }
              else
              {
                  return storyboard.instantiateViewController(identifier: "Favorilerim")
              }
                 
                 
                }
    
   
        
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        
        let menuViewController = storyboard?.instantiateViewController(identifier: "MenuViewController")
        menuViewController?.modalPresentationStyle = .overCurrentContext
        menuViewController?.transitioningDelegate = self
        present(menuViewController!, animated: true, completion: nil)
    }
    
    
    
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
   
    

}

extension ProfilBar : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresentig = true
        return transiton
    }


    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresentig = false
        return transiton
    }



    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
                self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()

        }
    }
    
    func controluser() {
        if userid == ""{
            let userID = Auth.auth().currentUser?.uid

            userid = userID!
        }
    }



}


extension ProfilBar  : MFMailComposeViewControllerDelegate{
    
}
