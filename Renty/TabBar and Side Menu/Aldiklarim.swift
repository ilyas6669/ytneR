//
//  Aldiklarim.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/8/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class Aldiklarim: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var buyitemlist : [NSDictionary] = []
       var secilenIndex = 0
    
    let fiyat = ["40TL","50TL","60TL"]
    
    let viewAlert : UIView = {
        let view = UIView()
         view.backgroundColor = .white
         view.translatesAutoresizingMaskIntoConstraints = false
         view.heightAnchor.constraint(equalToConstant: 150).isActive = true
         view.widthAnchor.constraint(equalToConstant: 300).isActive = true
         return view
     }()
     
     let imgDelete : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "delete"))
         img.heightAnchor.constraint(equalToConstant: 32).isActive = true
         img.widthAnchor.constraint(equalToConstant: 32).isActive = true
         return img
     }()
     
     let lblCikis : UILabel = {
        let lbl = UILabel()
         lbl.text = "Talebi sil"
         lbl.font = UIFont.boldSystemFont(ofSize: 20)
         lbl.textColor = .black
         lbl.textAlignment = .left
         return lbl
     }()
     
    let lblCikis2 : UILabel = {
          let lbl = UILabel()
           lbl.textColor = .black
           lbl.textAlignment = .left
           lbl.font = UIFont.systemFont(ofSize: 15)
           lbl.numberOfLines = 2
           lbl.text = "Talebi silmek istediğinizden eminmisiniz?"
           return lbl
       }()

     let visualEffectView : UIVisualEffectView = {
         let blurEffect = UIBlurEffect(style: .light)
         let view = UIVisualEffectView(effect: blurEffect)
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
     let btnEvet : UIButton = {
         let button = UIButton(type: .system)
         button.setTitleColor(.rgb(red: 201, green: 213, blue: 51), for: .normal)
         button.backgroundColor = .clear
         button.titleLabel?.font = .boldSystemFont(ofSize: 15)
         button.setTitle("EVET", for: .normal)
         button.addTarget(self, action: #selector(evetAction), for: .touchUpInside)
         return button
     }()
    
    let btnLeftPop : UIButton = {
             let btn = UIButton()
              btn.setImage(UIImage(named: "left1"), for: .normal)
              btn.addTarget(self, action: #selector(popLeftAction), for: .touchUpInside)
              btn.translatesAutoresizingMaskIntoConstraints = false
              return btn
          }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "AldiklarimCell", bundle: nil), forCellWithReuseIdentifier: "AldiklarimCell")
        getaldiklarim()
        
        
        viewAlert.addSubview(imgDelete)
        viewAlert.addSubview(lblCikis)
        viewAlert.addSubview(lblCikis2)
        viewAlert.addSubview(btnEvet)
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
        _ = imgDelete.anchor(top: viewAlert.topAnchor, bottom: nil, leading: viewAlert.leadingAnchor, trailing: nil,padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        _ = lblCikis.anchor(top: viewAlert.topAnchor, bottom: nil, leading: imgDelete.trailingAnchor, trailing: nil,padding: .init(top: 18, left: 10, bottom: 0, right: 0))
        _ = lblCikis2.anchor(top: imgDelete.bottomAnchor, bottom: nil, leading: viewAlert.leadingAnchor, trailing: viewAlert.trailingAnchor,padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        _ = btnEvet.anchor(top: nil, bottom: viewAlert.bottomAnchor, leading: nil, trailing: viewAlert.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 10))
     
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
                         lpgr.minimumPressDuration = 0.5
                         lpgr.delaysTouchesBegan = true
                         lpgr.delegate = self
                         self.collectionView.addGestureRecognizer(lpgr)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //layout.itemSize = CGSize(width: 330, height: 150)
            layout.itemSize = CGSize(width: view.frame.width, height: 150)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
        }

        
    }
    
    func getaldiklarim(){
           
           let userRef = Database.database().reference().child("BuyItem")
           let userID = Auth.auth().currentUser?.uid
           
           userRef.observe(.value, with: { (snapshot) in
               
               self.buyitemlist.removeAll(keepingCapacity: false)
               
               for child in snapshot.children {
                   
                   let snap = child as! DataSnapshot //get first snapshot
                   let value = snap.value as? NSDictionary //get second snapshot
                   
                   let buyer = value!["buyer"] as? String ?? ""
                _ = value!["seller"] as? String ?? ""
                  
                   if buyer == userID {
                       self.buyitemlist.append(value!)
                   }
                   
       
               }
               self.buyitemlist = self.buyitemlist.reversed()
               
               self.collectionView.reloadData()
           })
           
       }
    
    
    @objc func evetAction() {
        print("evet")
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
           
           if gestureReconizer.state != UIGestureRecognizer.State.ended {
               //When lognpress is start or running
               
           }
           else {
               //When lognpress is finish
                let p = gestureReconizer.location(in: self.collectionView)
                          
                          if let indexPath = self.collectionView.indexPathForItem(at: p) {
                              // get the cell at indexPath (the one you long pressed)
                            _ = self.collectionView.cellForItem(at: indexPath)
                              
                              let value2 = self.buyitemlist[indexPath.row]
                              
                              let buyitemid = value2["buyitemid"] as? String ?? ""
                              
                              let refreshAlert = UIAlertController(title: "Silme", message: "Silmek istediğinizden eminmisiniz ? .", preferredStyle: UIAlertController.Style.alert)
                              
                              refreshAlert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { (action: UIAlertAction!) in
                                  let ref = Database.database().reference().child("BuyItem").child(buyitemid)
                                  ref.removeValue()
                              }))
                              
                              refreshAlert.addAction(UIAlertAction(title: "Hayır", style: .cancel, handler: { (action: UIAlertAction!) in
                                  print("Handle Cancel Logic here")
                              }))
                              
                              present(refreshAlert, animated: true, completion: nil)
                              
                              
                              
                              // do stuff with the cell
                          } else {
                              print("couldn't find index path")
                          }
               
               
           }
       }
       
       @objc func popLeftAction() {
              UIView.animate(withDuration: 0.5, animations: {
                            self.visualEffectView.alpha = 0
                            self.viewAlert.alpha = 0
                  self.btnLeftPop.alpha = 0
                                self.viewAlert.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                   self.btnLeftPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        }) { (_) in
                            self.viewAlert.removeFromSuperview()
                          self.btnLeftPop.removeFromSuperview()

                        }
              
          }
       
    
    
  

}

extension Aldiklarim : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buyitemlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AldiklarimCell", for: indexPath) as! AldiklarimCell

        let value2 = self.buyitemlist[indexPath.row]

        let startdate = value2["startdate"] as? String ?? ""
        let enddate   = value2["enddate"] as? String ?? ""
        let totalprice   = value2["totalprice"] as? String ?? ""
        let itemid   = value2["itemid"] as? String ?? ""
        let status   = value2["status"] as? String ?? ""
        
        cell.lblFiyat.text = "\(totalprice) TL"
        cell.lblTarih1.text = startdate
        cell.lblTarih2.text = enddate
        
        switch status {
        case "waitforminus":
            cell.lblUrunDurumu.text = "Durum: Satıcının eksikleri girmesi bekleniyor..."
            break
        case "waitforbuyerconfirm":
            cell.lblUrunDurumu.text = "Durum: Alıcının ürünü almasını onaylaması bekleniyor..."
            break
        case "waitforsellerconfirm":
            cell.lblUrunDurumu.text = "Durum: Satıcının ürünü geri alması bekleniyor..."
            break
        case "wait for rating":
            cell.lblUrunDurumu.text = "Durum: Değerlendirmenin bitmesi bekleniyor..."
            break
        case "complete":
            cell.lblUrunDurumu.text = "Durum: Tamamlandı."
            break
        default:
            break
        }
        
        let itemRef = Database.database().reference().child("items").child(itemid)
        
        itemRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let photo0 = value?["photo0"] as? String ?? ""
            let title = value?["title"] as? String ?? ""
            
            cell.imgUrun.sd_setImage(with: URL(string: "\(photo0)"))
            cell.lblUrunIsmi.text = title
            
        }) { (error) in
            print(error.localizedDescription)
        }

        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
       let value2 = self.buyitemlist[indexPath.row]
       let buyitemid = value2["buyitemid"] as? String ?? ""
        
       let uruneklson = UrunDurumu()
       uruneklson.modalPresentationStyle = .fullScreen
       uruneklson.buyitemid = buyitemid
       present(uruneklson, animated: true, completion: nil)
        
    }
    

    
    
    
}
