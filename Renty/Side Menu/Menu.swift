//
//  Menu.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/29/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage




//enum MenuType : Int {
//    case profil
//    case mesajlar
//    case urunlerim
//    case aldiklarim
//
//
//}

class Menu: UITableViewController {
    
    
    

    @IBOutlet weak var imgProfil: UIImageView!
    
    @IBOutlet weak var lblisim: UILabel!

    
    override func viewDidLoad() {
    super.viewDidLoad()
        getveri()
        
    imgProfil.image = UIImage(named: "user1")
    imgProfil.backgroundColor = .white
    imgProfil.contentMode = .scaleAspectFill
    imgProfil.layer.borderWidth = 4
    imgProfil.layer.masksToBounds = false
    imgProfil.layer.borderColor = UIColor.rgb(red: 0, green: 90, blue: 63).cgColor
    imgProfil.layer.cornerRadius = imgProfil.frame.size.height / 2
    imgProfil.clipsToBounds = true
    

    }
        
    func makeAlert(tittle: String, message : String) {
            let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
    }
    
 
    func getveri(){

        let userID = Auth.auth().currentUser?.uid

              let userRef = Database.database().reference().child("user").child(userID!)

                     userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                       // Get user value
                       let value = snapshot.value as? NSDictionary

                       let namesurname = value?["namesurname"] as? String ?? ""
                       let profilepicture = value?["profilepicture"] as? String ?? ""
                        

                        self.lblisim.text = namesurname


                        if(profilepicture != ""){
                          self.imgProfil.sd_setImage(with: URL(string: "\(profilepicture)"))
                        }



                       }) { (error) in
                         print(error.localizedDescription)
                     }



    }
    
  
                
        
        
    }
    
   
    
    

    
   

