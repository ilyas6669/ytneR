//
//  GuvenlikAyarlari.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class GuvenlikAyarlari: UIViewController {
    
    var activityIndicator : UIActivityIndicatorView = {
       var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let alertView : UIView = {
       let view = UIView()
        view.backgroundColor = .rgb(red: 201, green: 213, blue: 51)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        
        let logo = UIImage(named: "GuvenlikAyarlari")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
    }
    
    @IBAction func btnLeft(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSifremiDeyis(_ sender: Any) {
        activityIndicator.startAnimating()
        let userID = Auth.auth().currentUser?.uid
        
        let userRef = Database.database().reference().child("user").child(userID!)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let email = value?["email"] as? String ?? ""
            
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                
                self.makeAlert(tittle: "Başarılı", message: "Email adresinize gönderdiğimiz linke tıklıyarak şifrenizi değişebilirsiniz")
                self.activityIndicator.stopAnimating()
                
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    func makeAlert(tittle: String, message : String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
