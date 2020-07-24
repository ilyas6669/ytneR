//
//  SideMenuFavoriler.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/16/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class SideMenuFavoriler: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let estimateWidth = 160.0
       var cellMarginSize = 16.0
    
        var itemlist : [NSDictionary] = []
        var favoritelist : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getfavoriteitem()

       let logo = UIImage(named: "Favorilerim")
       let imageView = UIImageView(image:logo)
       self.navigationItem.titleView = imageView
        
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BanaOzelCell",bundle: nil), forCellWithReuseIdentifier: "BanaOzelCell")
              
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //layout.itemSize = CGSize(width: 167, height: 249)
            layout.minimumLineSpacing = 10
            //layout.minimumInteritemSpacing = 5
              }

             
           }
    
    
    
    @IBAction func btnLeft(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
  
    
  
}


extension SideMenuFavoriler : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanaOzelCell", for: indexPath) as! BanaOzelCell
        
        //itemleri collection viewda gosterme
        let value2 = self.itemlist[indexPath.row]
        
        let itemid = value2["itemid"] as? String ?? ""
        let kind1 = value2["kind1"] as? String ?? ""
        let kind2 = value2["kind2"] as? String ?? ""
        let price = value2["pricestr"] as? String ?? ""
        let photo0 = value2["photo0"] as? String ?? ""
        
        
        
        
        
        //set first category
       
        if kind1 != "empty"{
            cell.lblUrunAdi.text = kind1
            cell.lblUrunAdi.isHidden = false
        }else{
            cell.lblUrunAdi.text = ""
            cell.lblUrunAdi.isHidden = true
        }
        //set second category
        if kind2 == "empty"{
            cell.lblUrunAdi2.text = ""
            cell.lblUrunAdi2.isHidden = true
        }else{
            cell.lblUrunAdi2.text = kind2
            cell.lblUrunAdi2.isHidden = false
        }
        
        cell.lblFiyat.text = "\(price) TL"
        cell.imgUrun.sd_setImage(with: URL(string: "\(photo0)"))
        
        checkfavoritestatus(itemid: itemid, button: cell.favoritBtn)
        
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
    func getfavoriteitem(){
        
        let userID = Auth.auth().currentUser?.uid
        
        let userRef = Database.database().reference().child("Favorite").child(userID!)
        userRef.observe(.value, with: { (snapshot) in
            
            self.favoritelist.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                
                self.favoritelist.append(snap.key)
            }
            
            self.getitemfromDB()
            
            
        })
        
    }
    func getitemfromDB(){
        
        let userRef = Database.database().reference().child("items")
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.itemlist.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot

                let itemid = value!["itemid"] as? String ?? ""
                let itempublish = value!["itempublish"] as? Bool ?? false
                
                if(itempublish){
                    for favoriteid in self.favoritelist {
                        if itemid == favoriteid {
                            self.itemlist.append(value!)
                        }
                    }
                }
                
            }
            
            self.itemlist = self.itemlist.reversed()
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
