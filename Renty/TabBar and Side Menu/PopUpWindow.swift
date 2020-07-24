//
//  PopUpWindow.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/9/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import MessageUI



class PopUpWindow: UIView {
    
    weak var controller:UIViewController!
    
    
    let view6 : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        view.layer.cornerRadius = 37
        view.heightAnchor.constraint(equalToConstant: 132).isActive = true
        view.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return view
    }()
    
    let profilImage : UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        img.image = UIImage(named: "user1")
        img.backgroundColor = .white
        img.heightAnchor.constraint(equalToConstant: 32).isActive = true
        img.widthAnchor.constraint(equalToConstant: 32).isActive = true
        img.layer.cornerRadius = img.frame.size.height / 2
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        //img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let label6 : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let btnAyarlar: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "setting"), for: .normal)
        btn.setTitle("   AYARLAR", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnAyarlarClicked), for: .touchUpInside)
        return btn
    }()
    
    
    let btnRaporEt: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage(named: "raporet2"), for: .normal)
        btn.setTitle("  RAPOR ET", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnRaporEtAction), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .rgb(red: 4, green: 140, blue: 99)
        
        getveri()
        
        
        addSubview(view6)
        addSubview(profilImage)
        addSubview(label6)
        view6.addSubview(btnAyarlar)
        view6.addSubview(btnRaporEt)
        
        
        
        
        _ = profilImage.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil,padding: .init(top: 15, left: 40, bottom: 0, right: 0))
        _ = view6.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        _ = label6.anchor(top: topAnchor, bottom: nil, leading: profilImage.trailingAnchor, trailing: nil,padding: .init(top: 17, left: 20, bottom: 0, right: 0))
        
        
        
        
        
        
        
        
        
        btnAyarlar.centerXAnchor.constraint(equalTo: view6.centerXAnchor).isActive = true
        btnAyarlar.centerYAnchor.constraint(equalTo: view6.centerYAnchor,constant: -20).isActive = true
        btnRaporEt.centerXAnchor.constraint(equalTo: view6.centerXAnchor).isActive = true
        btnRaporEt.centerYAnchor.constraint(equalTo: view6.centerYAnchor,constant: 25).isActive = true
        
        
        
        
        
    }
    func getveri(){
        
        let userID = Auth.auth().currentUser?.uid
        
        if userID != nil {
        let userRef = Database.database().reference().child("user").child(userID!)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let namesurname = value?["namesurname"] as? String ?? ""
            let profilepicture = value?["profilepicture"] as? String ?? ""
            
            self.label6.text = namesurname
            
            
            if(profilepicture != ""){
                self.profilImage.sd_setImage(with: URL(string: "\(profilepicture)"))
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        }
        
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnAyarlarClicked() {
        
        
//        UIApplication.topViewController()?.performSegue(withIdentifier: "ayarlar", sender: nil)
    }
    
    @objc func btnRaporEtAction() {
       
    }
    
    
    
    
    
}

extension PopUpWindow  : MFMailComposeViewControllerDelegate{
    
}



class SildeInTransition: NSObject,UIViewControllerAnimatedTransitioning {
    
    var isPresentig = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
        
    }
    
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        
        let conteinerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        
        if isPresentig {
            
            //Add menu view controller to conteiner
            conteinerView.addSubview(toViewController.view)
            
            //init frame of screen
            
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
            
        }
        
        
        //animateonscreen
        
        let transform =  {
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
            
        }
        //Anime back off screen
        let indetfy = {
            fromViewController.view.transform = .identity
        }
        
        //Animation of the transition
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresentig ? transform() : indetfy()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
        
        
        
    }
    
    
}




