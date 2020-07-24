//
//  BildirimBar.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/29/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class BildirimBar: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let testArray = ["test1","test2","test3","test4","tes5"]
    var notificationList : [NSDictionary] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getnotification()
        
        let logo = UIImage(named: "ic_asset_logo-1")
        let imageView = UIImageView(image:logo)
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        self.navigationItem.titleView = imageView
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(anaSayfaAction))
        imageView.addGestureRecognizer(gesture)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BildirimCell", bundle: nil), forCellWithReuseIdentifier: "BildirimCell")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //layout.itemSize = CGSize(width: 330, height: 150)
            layout.itemSize = CGSize(width: 350, height: 120)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
        }
        
        
        
        
        
    }
    
    func getnotification(){
        
        let userID = Auth.auth().currentUser?.uid
        
        let notificationRef = Database.database().reference().child("Notification").child(userID!)
        
       notificationRef.observe(.value, with: { (snapshot) in
            
            self.notificationList.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                self.notificationList.append(value!)
                
            }
            
            self.notificationList = self.notificationList.reversed()
            self.collectionView.reloadData()
        })
        
    }
    
    @objc func anaSayfaAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
}


extension BildirimBar : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.notificationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BildirimCell", for: indexPath) as! BildirimCell
        
        //itemleri collection viewda gosterme
        let value = self.notificationList[indexPath.row]
        
        let time     = value["time"] as? String ?? ""
        let date     = value["date"] as? String ?? ""
        let notitype = value["notitype"] as? String ?? ""
        
        cell.lblSaat.text = time
        cell.lblTarih.text = date
        
        switch notitype {
        case "itembuyed":
            cell.lblBildirim.text = "Yeni ürün siparişiniz var ! Hemen kontrol et."
            break
        case "itemupdateeksikler":
            cell.lblBildirim.text = "Satıcı eksikleri tamamladı ! Hemen kontrol et."
            break
        case "itemurunaldim":
            cell.lblBildirim.text = "Alıcı ürünü aldığını onayladı !"
            break
        case "itemurungerialdim":
            cell.lblBildirim.text = "Satıcı ürünü geri aldığını onayladı! Satıcını değerlendirebilirsin."
            break
        case "itemfinishreview":
            cell.lblBildirim.text = "Değerlendirmeler yapıldı ! Ürün sayfasından değerlendirmenizi görebilirsiniz."
            break
        default:
            break
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = collectionView.dequeueReusableCell(withReuseIdentifier: "BildirimCell", for: indexPath) as! BildirimCell
        
        //itemleri collection viewda gosterme
        let value = self.notificationList[indexPath.row]
        
        let notitype = value["notitype"] as? String ?? ""
        let extradata = value["extradata"] as? String ?? ""
        let extradata2 = value["extradata2"] as? String ?? ""
        
        print("nicatalibli:\(notitype)")
        //isdiyir yetis
        
        switch notitype {
        case "itembuyed":
            //sattiklarim
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SideMenuSatdiklarim") as! SideMenuSatdiklarim
            vc.modalPresentationStyle = .fullScreen
            vc.backcontrol = 1
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "itemupdateeksikler":
            //teklifler
            // itemid - extradata2
            // buyitemid - extradata
            
            let teklifler = UrunDurumu()
            teklifler.modalPresentationStyle = .fullScreen
            teklifler.buyitemid = extradata
            present(teklifler, animated: true, completion: nil)
            break
        case "itemurunaldim":
            //teklifler
            // itemid - extradata2
            // buyitemid - extradata
            let teklifler = UrunDurumu()
            teklifler.modalPresentationStyle = .fullScreen
            teklifler.buyitemid = extradata
             present(teklifler, animated: true, completion: nil)
            break
        case "itemurungerialdim":
            //teklifler
            // itemid - extradata2
            // buyitemid - extradata
            let teklifler = UrunDurumu()
            teklifler.modalPresentationStyle = .fullScreen
            teklifler.buyitemid = extradata
             present(teklifler, animated: true, completion: nil)
            break
        case "itemfinishreview":
            //urun sayfasi
            //itemid - extradata2
            let urunsayfasi = UrunSayfasi()
            urunsayfasi.modalPresentationStyle = .fullScreen
            urunsayfasi.itemid = extradata2
            self.navigationController?.pushViewController(urunsayfasi, animated: true)
            break
        default:
            break
        }
    }
    
}


