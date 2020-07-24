//
//  KisiProfilsayfasi.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/29/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Cosmos
import Firebase
import MessageUI

class KisiProfilsayfasi: UIViewController, MFMailComposeViewControllerDelegate {
    
    let btnLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "left1"), for: .normal)
        btn.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let cover = UIImageView(image: #imageLiteral(resourceName: "cover"))
    
    let btnPopMenu: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setImage(UIImage(named: "icmenu"), for: .normal)
        btn.addTarget(self, action: #selector(btnPopClicked), for: .touchUpInside)
        return btn
    }()
    
    
    
    let profilImage : UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        img.image = UIImage(named: "user1")
        img.heightAnchor.constraint(equalToConstant: 120).isActive = true
        img.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        img.contentMode = .scaleAspectFill
        img.layer.borderWidth = 4
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.rgb(red: 0, green: 90, blue: 63).cgColor
        img.layer.cornerRadius = img.frame.size.height / 2
        img.clipsToBounds = true
        img.backgroundColor = .white
        
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let btnUrunEkle : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Urunmesaj"), for: .normal)
        btn.layer.cornerRadius = 0.5 * btn.bounds.size.width
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(kecurunEkle), for: .touchUpInside)
        return btn
    }()
    
    let lblIsim : UILabel =  {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 19)
        return lbl
        
    }()
    
    let cosmos : CosmosView = {
        let cosmos = CosmosView()
        cosmos.rating = 0
        cosmos.settings.updateOnTouch = false
        cosmos.settings.emptyBorderColor = UIColor.rgb(red: 0, green: 38, blue: 26)
        cosmos.settings.filledColor = UIColor.yellow
        
        cosmos.settings.starMargin = 0
        
        return cosmos
    }()
    
    
    let popUpWindow: PopUpWindow = {
        let view = PopUpWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 37
        return view
    }()
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var userid = ""
    var itemlist : [NSDictionary] = []
    
    let lblUrunler : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.text = "Ürünler"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let altView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    
    fileprivate let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        //cv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        cv.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        return cv
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        self.navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 0, green: 38, blue: 26)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left1"), style: .done, target: self, action: #selector(leftAction))
        
        
        view.addSubview(cover)
        view.addSubview(profilImage)
        view.addSubview(lblIsim)
        view.addSubview(btnPopMenu)
        
        
        view.addSubview(btnUrunEkle)
        view.addSubview(cosmos)
        view.addSubview(visualEffectView)
        view.addSubview(lblUrunler)
        view.addSubview(altView)
        view.addSubview(collectionView)
        
        
        
        
        
        _ = cosmos.anchor(top: lblIsim.bottomAnchor, bottom: nil, leading: profilImage.trailingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 0, right: 0))
        _ = profilImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 30, left: 20, bottom: 0, right: 0))
        
        cover.heightAnchor.constraint(equalToConstant: 80).isActive = true
        _ = cover.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = lblIsim.anchor(top: cover.bottomAnchor, bottom: nil, leading: profilImage.trailingAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 7, right: 0),boyut: .init(width: 100, height: 20))
        _ = btnPopMenu.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 20))
        
        _ = btnUrunEkle.anchor(top: cover.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 10))
        lblUrunler.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _ = lblUrunler.anchor(top: profilImage.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        _ = altView.anchor(top: lblUrunler.bottomAnchor, bottom: nil, leading: lblUrunler.leadingAnchor, trailing: lblUrunler.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        _ = collectionView.anchor(top: altView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        
        popUpWindow.btnAyarlar.addTarget(self, action: #selector(getAyaralara), for: .touchUpInside)
        popUpWindow.btnAyarlar.setTitle("  ENGELLE", for: .normal)
        popUpWindow.btnRaporEt.addTarget(self, action: #selector(btnRaporEtAction), for: .touchUpInside)
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
        getuserveri()
        controluser()
        getitemfromDB()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BanaOzelCell",bundle: nil), forCellWithReuseIdentifier: "BanaOzelCell")
        
        
        
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 167, height: 249)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        }
        
        
        
    }
    
    @objc func leftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func btnPopClicked() {
        view.addSubview(popUpWindow)
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpWindow.heightAnchor.constraint(equalToConstant: 200).isActive = true
        popUpWindow.widthAnchor.constraint(equalToConstant: 250).isActive = true
        view.addSubview(btnLeft)
        btnLeft.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        btnLeft.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
            self.btnLeft.alpha = 1
            self.btnLeft.transform = CGAffineTransform.identity
        }
        
    }
    
    @objc func btnRaporEtAction() {
        guard MFMailComposeViewController.canSendMail() else {
            makeAlertt(tittle: "Geri Bildirim", message: "Bu eylemi hiç bir uyuhgulama gerçekleştiremez")
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["test@gmail.com"])
        composer.setSubject("Hata")
        
        present(composer, animated: true, completion: nil)
    }
    
    
    @objc func kecurunEkle() {
        
    }
    
    @objc func getAyaralara() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func leftButtonAction() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.btnLeft.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.btnLeft.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            self.btnLeft.removeFromSuperview()
            
        }
    }
    
    
    
    
    
    func getuserveri(){
        
        
        let userRef = Database.database().reference().child("user").child(userid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let namesurname = value?["namesurname"] as? String ?? ""
            let profilepicture = value?["profilepicture"] as? String ?? ""
            let userrate = value?["userrate"] as? String ?? ""
            
            self.lblIsim.text = namesurname
            self.cosmos.rating = Double(userrate)!
            
            if(profilepicture != ""){
                self.profilImage.sd_setImage(with: URL(string: "\(profilepicture)"))
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    
    
    
}




extension KisiProfilsayfasi : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
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
        print("test")
        
        let value2 = self.itemlist[indexPath.row]
        let itemid = value2["itemid"] as? String ?? ""
        
        print("nicatalibli:\(itemid)")
        
        let uruneklson = UrunSayfasi()
        uruneklson.modalPresentationStyle = .fullScreen
        uruneklson.itemid = itemid
        //present(uruneklson, animated: true, completion: nil)
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
    
}


