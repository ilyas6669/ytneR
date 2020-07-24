//
//  BanaOzel.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import SDWebImage

class BanaOzel: UIViewController {
    

   let tokens = Messaging.messaging().fcmToken
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   let data3 = [UIColor.rgb(red: 4, green: 140, blue: 99),UIColor.rgb(red: 112, green: 182, blue:
    44),UIColor.rgb(red: 201, green: 213, blue: 51)]
    
   var itemlist : [NSDictionary] = []

    
    let geri : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "left"), for: .normal)
        btn.layer.cornerRadius = 0.5 * btn.bounds.size.width
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(sifremiSifirlaa), for: .touchUpInside)
        return btn
    }()
    
    let estimateWidth = 160.0
    var cellMarginSize = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BanaOzelCell",bundle: nil), forCellWithReuseIdentifier: "BanaOzelCell")
        
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //layout.itemSize = CGSize(width: 167, height: 249)
            
           layout.minimumLineSpacing = 10
//            layout.minimumInteritemSpacing = 5
        }
        
        getitemfromDB()
        savetokenstoDB()
        
    }
    
    func sendnotification(userid:String,title:String,body:String){
        
        let tokenRef = Database.database().reference().child("user").child(userid)
        tokenRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                
                let token = value?["token"] as? String ?? ""
        
                let sender = PushNotificationSender()
                sender.sendPushNotification(to: token,title: title,body: body)
            
            }) { (error) in
                print(error.localizedDescription)
            }
        
  
    }
    
    func savetokenstoDB(){
    
        let userID = Auth.auth().currentUser!.uid
        //database token kayit etme
        let ref = Database.database().reference()
        ref.child("Tokens").child(userID).child("token").setValue(self.tokens)
        
    }
    
    @objc func sifremiSifirlaa() {
        
    }
    

}


extension BanaOzel : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanaOzelCell", for: indexPath) as! BanaOzelCell
        
        
        //reng secimi
        switch indexPath.row % 3 {
        case 0:
            cell.backgroundColor = .rgb(red: 4, green: 140, blue: 99)
            break
        case 1:
            cell.backgroundColor = .rgb(red: 112, green: 182, blue: 44)
            break
        case 2:
            cell.backgroundColor = .rgb(red: 201, green: 213, blue: 51)
            break
        default:
            cell.backgroundColor = .black
            break
        }
        
        
        //itemleri collection viewda gosterme
        let value2 = self.itemlist[indexPath.row]

        let itemid = value2["itemid"] as? String ?? ""
        let kind1 = value2["kind1"] as? String ?? ""
        let kind2 = value2["kind2"] as? String ?? ""
        let price = value2["pricestr"] as? String ?? ""
        let photo0 = value2["photo0"] as? String ?? ""
        let title = value2["title"] as? String ?? ""
            
        if title != "" {
            
            cell.lblUrunAdi.text = title
            cell.lblUrunAdi.isHidden = false
            cell.lblUrunAdi2.isHidden = true
            
        }else {
            
            //set first category
                if kind1 != "empty"{
                    cell.lblUrunAdi.text = kind1
                    cell.lblUrunAdi.isHidden = false
                }else{
                    cell.lblUrunAdi.text = ""
                    cell.lblUrunAdi.isHidden = true
                }
                
                //set second category
                if kind2 != "empty"{
                    cell.lblUrunAdi2.text = kind2
                    cell.lblUrunAdi2.isHidden = false
                }else{
                    cell.lblUrunAdi2.text = ""
                    cell.lblUrunAdi2.isHidden = true
                }
            
        }
        
    
       
        cell.lblFiyat.text = "\(price) TL"
        cell.imgUrun.sd_setImage(with: URL(string: "\(photo0)"))
        
       checkfavoritestatus(itemid: itemid, button: cell.favoritBtn)
//
        //set favorite button
        cell.btnTapAction = {
            () in

            let tagstatus = cell.favoritBtn.tag
            let userID = Auth.auth().currentUser?.uid

            print("Deneme\(tagstatus) De\(userID ?? "")")

            if(tagstatus==0){
                Database.database().reference().child("Favorite").child(userID!).child(itemid).setValue(true)
            }else{
                Database.database().reference().child("Favorite").child(userID!).child(itemid).removeValue()
            }
            
        }
        
        return cell
    }
    
  
    
    func checkfavoritestatus(itemid:String,button:UIButton){

        let userID = Auth.auth().currentUser?.uid

        let userRef = Database.database().reference().child("Favorite").child(userID!)

        userRef.observe(.value, with: { (snapshot) in

            if(snapshot.hasChild(itemid)){
                button.setImage(UIImage(named: "star2"), for: .normal)
                button.tag = 1
            }else{
                button.setImage(UIImage(named: "star-1"), for: .normal)
                button.tag = 0
            }

        }) { (error) in
            print(error.localizedDescription)
        }


    }
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
       let value2 = self.itemlist[indexPath.row]
       let itemid = value2["itemid"] as? String ?? ""
        
       let uruneklson = UrunSayfasi()
       uruneklson.modalPresentationStyle = .fullScreen
       uruneklson.itemid = itemid
       navigationController?.pushViewController(uruneklson, animated: true)

    }
    
    func getitemfromDB(){
        
        let userRef = Database.database().reference().child("items")
//        let userRef = Database.database().reference().child("items")

        userRef.observe(.value, with: { (snapshot) in
        
            self.itemlist.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                let itempublish = value!["itempublish"] as? Bool ?? false
                              
                if itempublish {
                    self.itemlist.append(value!)
                }

            }
            
         
            //reverseni yeni bunu
//            self.itemlist = self.itemlist.reversed()
        
            self.itemlist = self.itemlist.shuffled()
            self.collectionView.reloadData()
        })
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: 250)
    }
    
    func calculateWith() -> CGFloat {
        let estimadeWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimadeWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
    
}


