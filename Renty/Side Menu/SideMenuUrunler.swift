//
//  SideMenuUrunler.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/16/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class SideMenuUrunler: UIViewController, UIGestureRecognizerDelegate {
    
    let estimateWidth = 160.0
    var cellMarginSize = 16.0
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var secilenIndex = 0
    var selectedcategoryname = ""
    
    let array = ["kamp","kiyafet","spor","kitab"]
    
    var userid = ""
    
    var itemlist : [NSDictionary] = []
    
    
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
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controluser()
         layoutDuzenle()
         getitemfromDB()
         
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "UrunlerimCell", bundle: nil), forCellWithReuseIdentifier: "UrunlerimCell")
        
        
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
         
         let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
         gestureREcongizer.cancelsTouchesInView = false
         view.addGestureRecognizer(gestureREcongizer)

        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
                   lpgr.minimumPressDuration = 0.5
                   lpgr.delaysTouchesBegan = true
                   lpgr.delegate = self
                   self.collectionView.addGestureRecognizer(lpgr)
         
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
         //                          layout.itemSize = CGSize(width: 167, height: 200)
                                   layout.minimumLineSpacing = 10
         //                          layout.minimumInteritemSpacing = 5
                               }
        
       
 }
    
    func layoutDuzenle() {
           let logo = UIImage(named: "SideUrunlerim")
           let imageView = UIImageView(image:logo)
           self.navigationItem.titleView = imageView
           
 
}
    
    @IBAction func btnLeft(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
}
    
    @objc func evetAction() {
        
      

        
        
        
      }
      
      @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
          
          if gestureReconizer.state != UIGestureRecognizer.State.ended {
              //When lognpress is start or running
              
          }
          else {

              
            let p = gestureReconizer.location(in: self.collectionView)
            
            if let indexPath = self.collectionView.indexPathForItem(at: p) {
                // get the cell at indexPath (the one you long pressed)
                _ = self.collectionView.cellForItem(at: indexPath)
                
                let value2 = self.itemlist[indexPath.row]
                
                let itemid = value2["itemid"] as? String ?? ""
                _ = value2["pricestr"] as? String ?? ""
                
                let refreshAlert = UIAlertController(title: "Ürün Durumu", message: "Ürününü silmek istediğinizden eminmisiniz ?", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { (action: UIAlertAction!) in
                    var firebaseusermap = [String : Any]()
                    firebaseusermap["itempublish"] = false
                      
                    let ref = Database.database().reference().child("items").child(itemid)
                    ref.updateChildValues(firebaseusermap)
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
      
      
      
      @objc func handleDismissal() {
          UIView.animate(withDuration: 0.3, animations: {
              self.viewAlert.alpha = 0
              self.visualEffectView.alpha = 0
              self.viewAlert.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
          }) { (_) in
              self.viewAlert.removeFromSuperview()
          }
      }
    
    
}



extension SideMenuUrunler : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UrunlerimCell", for: indexPath) as! UrunlerimCell
         
         //itemleri collection viewda gosterme
         let value2 = self.itemlist[indexPath.row]

         let kind1 = value2["kind1"] as? String ?? ""
         let kind2 = value2["kind2"] as? String ?? ""
         let price = value2["pricestr"] as? String ?? ""
         let photo0 = value2["photo0"] as? String ?? ""
        _ = value2["itemid"] as? String ?? ""
    
        
         
         
         //set first category
         
        if kind1 != "empty"{
            cell.lblUrunIsmi.text = kind1
            cell.lblUrunIsmi.isHidden = false
        }else{
            cell.lblUrunIsmi.text = ""
            cell.lblUrunIsmi.isHidden = true
        }
         //set second category
         if kind2 == "empty"{
             cell.lblUrunAciklama.text = ""
             cell.lblUrunAciklama.isHidden = true
         }else{
             cell.lblUrunAciklama.text = kind2
             cell.lblUrunAciklama.isHidden = false
         }
        
         cell.lblUrunFIyati.text = "\(price) TL"
         cell.imgUrunn.sd_setImage(with: URL(string: "\(photo0)"))
        
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
         
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
          let value2 = self.itemlist[indexPath.row]
          let itemid = value2["itemid"] as? String ?? ""
           
          let uruneklson = UrunSayfasi()
          uruneklson.modalPresentationStyle = .fullScreen
          uruneklson.itemid = itemid
          navigationController?.pushViewController(uruneklson, animated: true)

       }
    
    
    
    func controluser() {
           if userid == ""{
               let userID = Auth.auth().currentUser?.uid

               userid = userID!
           }
       }
    
    func getitemfromDB(){
           
           let userRef = Database.database().reference().child("items")

           userRef.observe(.value, with: { (snapshot) in
           
               self.itemlist.removeAll(keepingCapacity: false)
               
               for child in snapshot.children {
                                
                   let snap = child as! DataSnapshot //get first snapshot
                   let value = snap.value as? NSDictionary //get second snapshot
                
                   let publisher = value!["publisher"] as? String ?? ""
                   let itempublish = value!["itempublish"] as? Bool ?? false

                   if publisher == self.userid{
                    if itempublish{
                        self.itemlist.append(value!)
                    }
                    }

               }

               self.itemlist = self.itemlist.reversed()
               self.collectionView.reloadData()
                              
           })
           
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              let width = self.calculateWith()
              return CGSize(width: width, height: 200)
          }
          
          func calculateWith() -> CGFloat {
              let estimadeWidth = CGFloat(estimateWidth)
              let cellCount = floor(CGFloat(self.view.frame.size.width / estimadeWidth))
              let margin = CGFloat(cellMarginSize * 2)
              let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
              return width
          }
    
    
}
