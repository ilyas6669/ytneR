//
//  Mesajlar.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/15/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class Mesajlar: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var secilenIndex = 0
   
    var userIdList : [String] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 0, green: 90, blue: 63)
//        navigationController?.navigationBar.tintColor = UIColor.white
//        navigationItem.title = "Mesajlar"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MesajlarCell", bundle: nil), forCellWithReuseIdentifier: "MesajlarCell")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //layout.itemSize = CGSize(width: 330, height: 150)
            layout.itemSize = CGSize(width: 350, height: 80)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
        }
        self.kullanicilarialmak()
        
        
    }
    
    func kullanicilarialmak(){
        
        let userID = Auth.auth().currentUser?.uid
        let userRef = Database.database().reference().child("Chatlist").child(userID!)
        
        userRef.observe(.value, with: { (snapshot) in
            
            self.userIdList.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                let id = value!["id"] as? String ?? ""
                
                self.userIdList.append(id)
                
            }
            
            self.collectionView.reloadData()
        })
        
        
    }

    @IBAction func leftAction(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
    }
    

}

extension Mesajlar : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userIdList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MesajlarCell", for: indexPath) as! MesajlarCell
        
        let userid = self.userIdList[indexPath.row]
        let myuserID = Auth.auth().currentUser?.uid

        let userRef = Database.database().reference().child("user").child(userid)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            
            let namesurname = value?["namesurname"] as? String ?? ""
            let profilepicture = value?["profilepicture"] as? String ?? ""
            _ = value?["userrate"] as? String ?? ""
            
            
            if(profilepicture != ""){
                cell.imgUser.sd_setImage(with: URL(string: "\(profilepicture)"))
            }
            
            ///get isim
            cell.lblIsim.text = "\(namesurname)"
            
            ///get last message
            var theLastMessage = "default"
            
            let chatsRef = Database.database().reference().child("Chats")
            chatsRef.observe(.value, with: { (snapshot) in
                                
                for child in snapshot.children {
                    
                    let snap = child as! DataSnapshot //get first snapshot
                    let value = snap.value as? NSDictionary //get second snapshot
                    
                    let receiver   = value!["receiver"] as? String ?? ""
                    let sender     = value!["sender"] as? String ?? ""
                    let message    = value!["message"] as? String ?? ""
                    let time       = value!["time"] as? String ?? ""
                    let date       = value!["date"] as? String ?? ""
                    
                    if (receiver == myuserID && sender == userid) || (receiver == userid && sender == myuserID) {
                        
                        theLastMessage = message
                        
                        cell.lblSaat.text = time
                        cell.lblTarih.text = date
                        
                    }
                    
                }
                
                if theLastMessage == "default" {
                    cell.lbbMesaj.text = "Mesaj Yok"
                }else{
                    cell.lbbMesaj.text = theLastMessage
                }
                
            })
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           secilenIndex = indexPath.row
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        let userid = self.userIdList[indexPath.row]
        vc.receiver = userid
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
      
        
//        let chat = ViewMesaj()
//        //let userid = self.userIdList[indexPath.row]
//        chat.modalPresentationStyle = .fullScreen
//        //chat.receiver = userid
//        present(chat, animated: true, completion: nil)
        
       
        
        
    }
    
    
    
}
