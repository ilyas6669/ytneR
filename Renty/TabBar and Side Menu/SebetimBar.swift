//
//  SebetimBar.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/29/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import TTGSnackbar

class SebetimBar: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UIGestureRecognizerDelegate{
    
    let viewAlert : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return view
    }()
    
    let imgDelete : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "ic_check_green"))
        img.heightAnchor.constraint(equalToConstant: 32).isActive = true
        img.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return img
    }()
    
    let lblCikis : UILabel = {
        let lbl = UILabel()
        lbl.text = "Sepeti Onayla"
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
        lbl.text = "Sepeti onaylamak istediğinizden eminmisiniz?"
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
    
    
    let img : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "ic_tag_white"))
        img.heightAnchor.constraint(equalToConstant: 24).isActive = true
        img.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return img
    }()
    
    let lblToplam : UILabel = {
        let lbl = UILabel()
        lbl.text = "Toplam:"
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.textColor = .white
        return lbl
    }()
    
    let lblFiyat : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.textColor = .white
        return lbl
    }()
    
    
    let btnOnayla: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("SEPETİ ONAYLA", for: .normal)
        btn.backgroundColor = .rgb(red: 13, green: 165, blue: 72)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(onaylaAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 140).isActive = true
        return btn}()
    
    
    
    
    @IBOutlet weak var collectionView1: UICollectionView!
    
    @IBOutlet weak var collectionView2: UICollectionView!
    var dataArray = ["Cadir","Decatlon","projeksiyon"]
    
    var fiyatArray = ["5TL","10TL","20TL"]
    
    var sepetitemlist : [NSDictionary] = []
    var similaritemlist : [NSDictionary] = []
    
    
    let viewBenzerUrun : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 112, green: 182, blue: 44)
        return view
    }()
    
    let lblBenzerUrun : UILabel = {
        let lbl = UILabel()
        lbl.text = "Benzer Ürünler"
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var itemid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "sepetim")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        collectionView1.dataSource = self
        collectionView1.delegate = self
        collectionView2.dataSource = self
        collectionView2.delegate = self
        self.collectionView2.isHidden = true
        self.viewBenzerUrun.isHidden = true
        self.lblBenzerUrun.isHidden = true
        self.btnOnayla.isHidden = true
        self.lblToplam.isHidden = true
        self.lblFiyat.isHidden = true
        
        
        
        let fiyatSV = UIStackView(arrangedSubviews: [img,lblToplam,lblFiyat])
        fiyatSV.axis = .horizontal
        fiyatSV.spacing = 5
        
        
        
        getsepetitem()
        
        view.addSubview(btnOnayla)
        view.addSubview(fiyatSV)
        view.addSubview(viewBenzerUrun)
        viewBenzerUrun.addSubview(lblBenzerUrun)
        
        
        
        
        _ = btnOnayla.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 10))
        _ = fiyatSV.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 10, right: 0))
        _ = viewBenzerUrun.anchor(top: collectionView1.bottomAnchor, bottom: collectionView2.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        lblBenzerUrun.centerYAnchor.constraint(equalTo: viewBenzerUrun.centerYAnchor).isActive = true
        lblBenzerUrun.leftAnchor.constraint(equalTo: viewBenzerUrun.leftAnchor,constant: 10).isActive = true
        
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
        self.collectionView1.addGestureRecognizer(lpgr)
        
        
        if let layout = collectionView1.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 150)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        
        if let layout = collectionView2.collectionViewLayout as? UICollectionViewFlowLayout {
                  
                   layout.minimumLineSpacing = 10
                   layout.minimumInteritemSpacing = 5
                   layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
               }
        
        
        
        
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            //When lognpress is start or running
            
        }
        else {
            //When lognpress is finish
            let p = gestureReconizer.location(in: self.collectionView1)
            
            let snackbar = TTGSnackbar(message: "Ürünü sepetinizden kaldırmak istermisiniz?", duration: .long)
            
            // Action 1
            snackbar.actionText = "EVET"
            snackbar.actionTextColor = UIColor.green
            snackbar.actionBlock = { (snackbar) in
                NSLog("Click Yes !")
                
                
                if let indexPath = self.collectionView1.indexPathForItem(at: p) {
                    // get the cell at indexPath (the one you long pressed)
                    _ = self.collectionView1.cellForItem(at: indexPath)
                    
                    let value2 = self.sepetitemlist[indexPath.row]
                    
                    let userID = Auth.auth().currentUser!.uid
                    
                    let itemid = value2["itemid"] as? String ?? ""
                    
                    
                    let ref = Database.database().reference().child("Sepet").child(userID).child(itemid)
                    ref.removeValue()
                    
                    
                    
                    // do stuff with the cell
                } else {
                    print("couldn't find index path")
                }
                
                
            }
            
            // Action 2
            snackbar.secondActionText = "HAYIR"
            snackbar.secondActionTextColor = UIColor.yellow
            snackbar.secondActionBlock = { (snackbar) in NSLog("Click No !") }
            
            snackbar.show()
            
        }
    }
    
    func getsepetitem(){
        
        let userID = Auth.auth().currentUser?.uid
        
        let sepetRef = Database.database().reference().child("Sepet").child(userID!)
        
        sepetRef.observe(.value, with: { (snapshot) in
            
            self.sepetitemlist.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                _ = value!["itempublish"] as? Bool ?? false
                
                self.sepetitemlist.append(value!)
                
            }
            self.setsepetprice()
            
            if self.sepetitemlist.count != 0 {
                self.lblFiyat.isHidden  = false
                self.lblToplam.isHidden = false
                self.collectionView2.isHidden = false
                self.viewBenzerUrun.isHidden = false
                self.lblBenzerUrun.isHidden = false
                self.btnOnayla.isHidden = false
                self.lblToplam.text = "Toplam:"
                
                ///benzer urunleri al
                let value5 = self.sepetitemlist[0]
                let itemid5 = value5["itemid"] as? String ?? "0"
                
                let itemref = Database.database().reference().child("items").child(itemid5)
                
                itemref.observeSingleEvent(of: .value, with: { (snapshot5) in
                    
                    let value = snapshot5.value as? NSDictionary
                    self.getbenzeritem(item: value!)
                    
                    
                })
                
            }else{
                self.lblFiyat.isHidden  = true
                self.lblToplam.isHidden = false
                self.lblToplam.text = "Sepetiniz boş"
                self.collectionView2.isHidden = true
                self.viewBenzerUrun.isHidden = true
                self.lblBenzerUrun.isHidden = true
                self.btnOnayla.isHidden = true
            }
            
            
            
            self.sepetitemlist = self.sepetitemlist.reversed()
            
            self.collectionView1.reloadData()
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    func getbenzeritem(item:NSDictionary){
        
        let currentcategory = item["category"] as? String ?? ""
        let currentkind1 = item["kind1"] as? String ?? ""
        let currentitemid = item["itemid"] as? String ?? ""
        
        
        let itemRef = Database.database().reference().child("items")
        
        itemRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.similaritemlist.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot
                let value = snap.value as? NSDictionary
                
                let itempublish = value!["itempublish"] as? Bool ?? false
                let category = value!["category"] as? String ?? ""
                let kind1 = value!["kind1"] as? String ?? ""
                let itemid = value!["itemid"] as? String ?? ""
                
                //yoxluyum prosta bunu bilenmiyecem neyse isdiyer isyeq ini isdiyecey yoxalma ne qaldi indi ? oz urunumuzu gormememeh kecen defe ikisin birden elemeishdine he oyda basdan deyerdine bide eyni yerlere gedeciy indi yene bir bir urun alinan yerere get bide searchbarada da var
                let sehir = value!["sehir"] as? String ?? ""
                 let publisher = value!["publisher"] as? String ?? ""
                
                if sehir == Cache.usersehir && publisher != Auth.auth().currentUser?.uid  {
                
                if itempublish {
                    if currentcategory == category &&
                        currentkind1   == kind1 &&
                        currentitemid  != itemid {
                        self.similaritemlist.append(value!)
                    }
                }
                }
                
            }
            
            print("Similar:\(self.similaritemlist.count)")
            if self.similaritemlist.count == 0 {
                
                for child in snapshot.children {
                    
                    let snap = child as! DataSnapshot
                    let value = snap.value as? NSDictionary
                    
                    let itempublish = value!["itempublish"] as? Bool ?? false
                    let category = value!["category"] as? String ?? ""
                    _ = value!["kind1"] as? String ?? ""
                    let itemid = value!["itemid"] as? String ?? ""
                    
                    if itempublish {
                        if currentcategory == category &&
                            currentitemid  != itemid {
                            self.similaritemlist.append(value!)
                        }
                    }
                    
                }
                
            }
            print("Similar:\(self.similaritemlist.count)")
            ///urun sepet listesinde var ise
            if self.similaritemlist.count != 0 {
                
                for i in 0..<self.similaritemlist.count {
                    
                    for j in 0..<self.sepetitemlist.count{
                        
                        let value = self.similaritemlist[i]
                        let value2 = self.sepetitemlist[j]
                        
                        let itemid = value["itemid"] as? String ?? ""
                        let itemid2 = value2["itemid"] as? String ?? ""
                        
                        if itemid == itemid2 {
                            self.similaritemlist.remove(at: i)
                            break
                        }
                        
                    }
                    
                }
                
            }
            print("Similar:\(self.similaritemlist.count)")
            if self.similaritemlist.count == 0 {
                self.collectionView2.isHidden = true
                self.viewBenzerUrun.isHidden = true
                self.lblBenzerUrun.isHidden = true
            }else{
                self.collectionView2.isHidden = false
                self.viewBenzerUrun.isHidden = false
                self.lblBenzerUrun.isHidden = false
            }
            
            self.similaritemlist = self.similaritemlist.reversed()
            
            self.collectionView2.reloadData()
        })
        
    }
    
    
    func setsepetprice(){
        var toplamprice = 0
        switch sepetitemlist.count {
        case 0:
            break
        default:
            for i in 0..<sepetitemlist.count {
                
                let value = self.sepetitemlist[i]
                
                let itemprice = value["itemprice"] as? String ?? "0"
                
                toplamprice = toplamprice + Int(itemprice)!
                
            }
            lblFiyat.text = "\(toplamprice) TL"
            
            break
        }
    }
    
    @objc func onaylaAction() {
        print("test")
//        view.addSubview(viewAlert)
//        viewAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        viewAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        viewAlert.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//        viewAlert.alpha = 0
//        UIView.animate(withDuration: 0.5) {
//            self.visualEffectView.alpha = 1
//            self.viewAlert.alpha = 1
//            self.viewAlert.transform = CGAffineTransform.identity
        //        }
        
        let refreshAlert = UIAlertController(title: "Sepet", message: "Sepeti onaylamak istediğinizden eminmisiniz ? ", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { (action: UIAlertAction!) in
            self.evetAction()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Hayır", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
    }
    

    
    @objc func evetAction() {
        print("evet")
        for i in 0..<sepetitemlist.count {
            
            //database buy item kayit etme
            var buyitemhashmap = [String : Any]()
            
            let value = self.sepetitemlist[i]
            let itemid = value["itemid"] as? String ?? ""
            let buyer = value["buyer"] as? String ?? ""
            let seller = value["seller"] as? String ?? ""
            let itemprice = value["itemprice"] as? String ?? ""
            let startdate = value["startdate"] as? String ?? ""
            let enddate = value["enddate"] as? String ?? ""
            let daycounter = value["daycounter"] as? String ?? ""
            
            let buyitemid = Database.database().reference().child("BuyItem").childByAutoId().key
            
            buyitemhashmap["buyitemid"] = buyitemid
            buyitemhashmap["itemid"] = itemid
            buyitemhashmap["status"] = "waitforminus"
            buyitemhashmap["buyer"] = buyer
            buyitemhashmap["seller"] = seller
            buyitemhashmap["totalprice"] = itemprice
            buyitemhashmap["startdate"] = startdate
            buyitemhashmap["enddate"] = enddate
            buyitemhashmap["daycounter"] = daycounter
            buyitemhashmap["eksikler"] = ""
            buyitemhashmap["buyerrate"] = ""
            buyitemhashmap["sellerrate"] = ""
            buyitemhashmap["buyercomment"] = ""
            buyitemhashmap["sellercomment"] = ""
            
            let buyitemref = Database.database().reference().child("BuyItem").child(buyitemid!)
            buyitemref.setValue(buyitemhashmap)
            
            ///Save notification
            var notificationhashnap = [String : Any]()
            
            let notificationid = Database.database().reference().child("Notification").child(seller).childByAutoId().key
            
            notificationhashnap["notiid"] = notificationid
            notificationhashnap["notitype"] = "itembuyed"
            notificationhashnap["time"] = gettime()
            notificationhashnap["date"] = getdate()
            notificationhashnap["extradata"] = buyitemid
            notificationhashnap["extradata2"] = itemid
            
            let notiref = Database.database().reference().child("Notification").child(seller).child(notificationid!)
            notiref.setValue(notificationhashnap)
            
            ///send device notification
            let sellerref = Database.database().reference().child("user").child(seller)
            sellerref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                let namesurname = value?["namesurname"] as? String ?? ""
                
                self.sendnotification(userid: seller, title: "Yeni Sipariş", body: "\(namesurname) tarafından yeni siparişiniz var")
                
            }) { (error) in print(error.localizedDescription) }
            
            
            ///remove sepetItemlist
            if i == sepetitemlist.count-1 {
                
                let userID = Auth.auth().currentUser!.uid
                
                let sepetremoveref = Database.database().reference().child("Sepet").child(userID)
                sepetremoveref.removeValue()
                    { (err, resp) in
                        guard err == nil else {
                            print("Posting failed : ")
                            //                        self.activityIndicator.stopAnimating()
                            return
                        }
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "SideMenuAldiklarim") as! SideMenuAldiklarim
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                }
                
                
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
    
    func sendnotification(userid:String,title:String,body:String){
        
        let tokenRef = Database.database().reference().child("Tokens").child(userid)
        tokenRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            let token = value?["token"] as? String ?? ""
            
            let sender = PushNotificationSender()
            sender.sendPushNotification(to: token,title: title,body: body)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    func getdate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    func gettime() -> String{
        var time = ""
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        time = "\(hour):\(minutes)"
        
        return time
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView1 {
            return sepetitemlist.count
        }
        
        return similaritemlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView1 {
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! SebetimCell
            //itemleri collection viewda gosterme
            let value2 = self.sepetitemlist[indexPath.row]
            
            let startdate = value2["startdate"] as? String ?? ""
            let enddate   = value2["enddate"] as? String ?? ""
            let itemprice = value2["itemprice"] as? String ?? ""
            let itemid = value2["itemid"] as? String ?? ""
            
            
            cell1.lblFiyat.text = "\(itemprice) TL"
            cell1.lblTarih1.text = startdate
            cell1.lblTarih2.text = enddate
            
            
            let itemRef = Database.database().reference().child("items").child(itemid)
            
            itemRef.observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                
                let photo0 = value?["photo0"] as? String ?? ""
                let itemtitle = value?["title"] as? String ?? ""
                
                cell1.imgUrun.sd_setImage(with: URL(string: "\(photo0)"))
                cell1.lblUrunIsmi.text = itemtitle
                if itemtitle != "empty"{
                    cell1.lblUrunIsmi.text = itemtitle
                    cell1.lblUrunIsmi.isHidden = false
                }else{
                    cell1.lblUrunIsmi.text = ""
                    cell1.lblUrunIsmi.isHidden = true
                }
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
            
            
            return cell1
        }else{
            let cell2 = collectionView2.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! BenzerUrunlerCell
            let value2 = self.similaritemlist[indexPath.row]
            
            let photo0 = value2["photo0"] as? String ?? ""
            _ = value2["itemid"] as? String ?? ""
            let kind1 = value2["kind1"] as? String ?? ""
            _ = value2["kind2"] as? String ?? ""
            let price = value2["pricestr"] as? String ?? ""
            
            let title = value2["title"] as? String ?? ""
                
            if title != "" {
                
                cell2.lblUrunAdi.text = title
                cell2.lblUrunAdi.isHidden = false
               
                
            }else {
                
                //set first category
                    if kind1 != "empty"{
                        cell2.lblUrunAdi.text = kind1
                        cell2.lblUrunAdi.isHidden = false
                    }else{
                        cell2.lblUrunAdi.text = ""
                        cell2.lblUrunAdi.isHidden = true
                    }
                    
                    //set second category
                    
                
            }
            
            
            cell2.urunImg.sd_setImage(with: URL(string: "\(photo0)"))
            cell2.fiyatLbl.text = "\(price) TL"
            
            cell2.urunImg.contentMode = .scaleAspectFill
            return cell2
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView1 {
            let value2 = self.sepetitemlist[indexPath.row]
            let itemid = value2["itemid"] as? String ?? ""
            
            let uruneklson = UrunSayfasi()
            uruneklson.modalPresentationStyle = .fullScreen
            uruneklson.itemid = itemid
            navigationController?.pushViewController(uruneklson, animated: true)
            
        }else {
            let value2 = self.similaritemlist[indexPath.row]
            let itemid = value2["itemid"] as? String ?? ""
            
            let uruneklson = UrunSayfasi()
            uruneklson.modalPresentationStyle = .fullScreen
            uruneklson.itemid = itemid
            navigationController?.pushViewController(uruneklson, animated: true)
        }
        
        
        
    }
    
    
}










