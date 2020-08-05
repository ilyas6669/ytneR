//
//  KayitOlmadanGirisYap.swift
//  Renty
//
//  Created by İlyas Abiyev on 5/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class KayitOlmadanGirisYap: UIViewController {
    
    var itemlist : [NSDictionary] = []
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 4, green: 140, blue: 99)
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    let uyariView : UIView = {
       let view = UIView()
        view.backgroundColor = .rgb(red: 201, green: 213, blue: 51)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 320).isActive = true
        view.heightAnchor.constraint(equalToConstant: 130).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    let uyariImage : UIImageView = {
       let image = UIImageView(image: #imageLiteral(resourceName: "imgPop"))
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let uyariLbl : UILabel = {
       let lbl = UILabel()
        lbl.text = "Kayıt olmadan giriş yapdığınız zaman yalnız belirli sayda ürünleri göre bilirsiniz. Uygulamanın tüm özelliklerine erişmek için lütfen kayıt olunuz."
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 10
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    fileprivate let urunlerCollectionView : UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
           return cv
       }()
    
    var activityIndicator : UIActivityIndicatorView = {
           var indicator = UIActivityIndicatorView()
           indicator.hidesWhenStopped = true
           indicator.style = .medium
           indicator.color = .white
           indicator.translatesAutoresizingMaskIntoConstraints = false
           return indicator
       }()
    
    let btnGirisYap : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.setTitle(" Kayıt Ol", for: .normal)
        btn.addTarget(self, action: #selector(girisYapAction), for: .touchUpInside)
        btn.backgroundColor = .clear
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let estimateWidth = 160.0
    var cellMarginSize = 16.0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        addSubview()
        addConstraint()
        collectionViewDuzenle()
        getitemfromDB()
//        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
//        view.addGestureRecognizer(gestureREcongizer)
        
        
    }
    
    
    func addSubview() {
        view.addSubview(ustView)
        uyariView.addSubview(uyariImage)
        uyariView.addSubview(uyariLbl)
        view.addSubview(urunlerCollectionView)
        //view.addSubview(uyariView)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        ustView.addSubview(btnGirisYap)
       
    }
    
    func addConstraint() {
        _ = ustView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        //uyariView.merkezKonumlamdirmaSuperView()
        uyariImage.merkezYSuperView()
        uyariImage.leadingAnchor.constraint(equalTo: uyariView.leadingAnchor,constant: 5).isActive = true
        _ = uyariLbl.anchor(top: uyariView.topAnchor, bottom: nil, leading: uyariImage.trailingAnchor, trailing: uyariView.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        _ = urunlerCollectionView.anchor(top: ustView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        activityIndicator.merkezKonumlamdirmaSuperView()
       
        btnGirisYap.leadingAnchor.constraint(equalTo: ustView.leadingAnchor,constant: 5).isActive = true
        btnGirisYap.bottomAnchor.constraint(equalTo: ustView.bottomAnchor,constant: -5).isActive = true
    }
    
    func collectionViewDuzenle() {
        self.urunlerCollectionView.delegate = self
        self.urunlerCollectionView.dataSource = self
        self.urunlerCollectionView.register(UINib(nibName: "BanaOzelCell",bundle: nil), forCellWithReuseIdentifier: "BanaOzelCell")
        
        
        if let layout = urunlerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //layout.itemSize = CGSize(width: 167, height: 249)
            
            layout.minimumLineSpacing = 10
            //            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        }
        
    }
    
    @objc func handleDismissal() {
            UIView.animate(withDuration: 0.3, animations: {
                self.uyariView.alpha = 0
                    self.uyariView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { (_) in
                self.uyariView.removeFromSuperview()
            }
        }
    
    @objc func girisYapAction() {
        let girisYap = SignUp()
        girisYap.modalPresentationStyle = .fullScreen
        self.present(girisYap, animated: true, completion: nil)
    }
    
    


}


extension KayitOlmadanGirisYap : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanaOzelCell", for: indexPath) as! BanaOzelCell
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
        
        activityIndicator.stopAnimating()
//
        //set favorite button
        
        return cell
    }
    
  
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        makeAlertt(tittle: "UYARI", message: "Kayıt olmadan giriş yapdığınız zaman yalnız belirli sayda ürünleri göre bilirsiniz. Uygulamanın tüm özelliklerine erişmek için lütfen kayıt olunuz.")

    }
    
    func getitemfromDB(){
        
        let userRef = Database.database().reference().child("items")

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
            self.urunlerCollectionView.reloadData()
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



