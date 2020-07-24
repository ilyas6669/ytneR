//
//  Test123.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/22/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class KategoriyeGoreUrun: UIViewController {
    
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemlist : [NSDictionary] = []
    
    var itemcategory = ""

    
    var dizi = ["otaq","qara","rengdedi"]
    
    let btnSirala : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "swap"), for: .normal)
        btn.setTitle("Sırala", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.rgb(red: 201, green: 213, blue: 51).cgColor
        btn.addTarget(self, action: #selector(btnSiralaAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        return btn
    }()
    
    let btnFiltrele : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "adjust"), for: .normal)
        btn.setTitle(" Filtrele", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.rgb(red: 201, green: 213, blue: 51).cgColor
        btn.addTarget(self, action: #selector(btnFiltireleAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutDuzenle()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BanaOzelCell",bundle: nil), forCellWithReuseIdentifier: "BanaOzelCell")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 167, height: 220)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
        }
        getitemfromDB()
        
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "left1"), style: .done, target: self, action: #selector(urunEkleAction))
        self.navigationItem.leftBarButtonItem = rightBarButtonItem
        
        let logo = UIImage(named: "Kamp2")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 0, green: 90, blue: 63)
        navigationController?.navigationBar.isTranslucent = false
        
        print("Deneme123:\(itemcategory)")
    }
    
    
    func layoutDuzenle() {
        view.addSubview(btnSirala)
        view.addSubview(btnFiltrele)
        
        
        
        
        _ = btnSirala.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 15, left: 50, bottom: 0, right: 0))
        _ = btnFiltrele.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 15, left: 0, bottom: 0, right: 50))
        
        
    }
    

   

    
    @objc func urunEkleAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func btnSiralaAction() {
        print("sirala")
    }
       
       
    @objc func btnFiltireleAction() {
        print("filtriele")
    }
}


extension KategoriyeGoreUrun : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.itemlist.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanaOzelCell", for: indexPath) as! BanaOzelCell
      
        
        
        //itemleri collection viewda gosterme
               let value2 = self.itemlist[indexPath.row]

               let kind1 = value2["kind1"] as? String ?? ""
               let kind2 = value2["kind2"] as? String ?? ""
               let price = value2["pricestr"] as? String ?? ""
               let photo0 = value2["photo0"] as? String ?? ""

               
               //cell.funcColor(color: data3[1])
               
               
               //set first category
               cell.lblUrunAdi.text = kind1
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
               
               return cell
           }
           
           func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              //
               
           }
    func getitemfromDB(){
           
        let userRef = Database.database().reference().child("denemeitems")
        
        userRef.observe(.value, with: { (snapshot) in
           
        self.itemlist.removeAll(keepingCapacity: false)
               
        for child in snapshot.children {
                   
            let snap = child as! DataSnapshot //get first snapshot
            let value = snap.value as? NSDictionary //get second snapshot
            let category = value!["category"] as? String ?? ""
            
            print("test2:\(self.itemcategory)")
            print("test2:\(category)")
                        

            if self.itemcategory == category{//kategoriye gore alma
                self.itemlist.append(value!)
              }
                //print("test1\(self.itemcategory)")
                //print("test2\(category)")
                
                //self.itemlist.append(value!)
               }

               self.collectionView.reloadData()
               
              
               
           })
        
           
       }
    
    
    
    
    
    
    }
    
    
    
    
   

