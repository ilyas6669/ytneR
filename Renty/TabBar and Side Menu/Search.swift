//
//  AramaYap2.swift
//  Renty
//
//  Created by Nicat Talibli on 4/9/20.
//  Copyright © 2020 Nicat Talibli. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class Search: UIViewController,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchWord : String? = nil
    
    
    
    let btnAramaYap: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("test", for: .normal)
        btn.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        btn.contentHorizontalAlignment = .center
        btn.layer.borderColor = UIColor.rgb(red: 201, green: 213, blue: 51).cgColor
        btn.layer.borderWidth = 2
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(btnAramaYapAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    
    
    let imgSearch : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "searchh"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblSonuc : UILabel = {
        let lbl = UILabel()
        lbl.text = "0 Sonuç"
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 13)
        return lbl
    }()
    
    let view1 : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 4, green: 140, blue: 99)
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    
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
    
    @IBOutlet weak var btnFIltirelee: UIButton!
    
    
    
    let siralaPopp: SiralaPop = {
        let view = SiralaPop()
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
    
    let btnEnYenilerr: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("En Yeniler", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(enyenilerrAction), for: .touchUpInside)
        return btn
    }()
    
    let btnYuksekFiyat: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("Yüksek Fiyat", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(yuksekFiyatAction), for: .touchUpInside)
        return btn
    }()
    
    let btnDusukFiyat: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("Düşük Fiyat", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(dusukFiyatAction), for: .touchUpInside)
        return btn
    }()
    
    let btnYuksekPuan: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("Yüksek Puan", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(yuksekPuanAction), for: .touchUpInside)
        return btn
    }()
    
    let btnYakindanUzaga: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("Yakından Uzağa", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(yakindanUzagaAction), for: .touchUpInside)
        return btn
    }()
    
    let btnUzakdanYakina: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("Uzaktan Yakına", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(uzakdanYakinaAction), for: .touchUpInside)
        return btn
    }()
    
    var itemlist : [Items] = []
    var itemcategory = ""
    
    
    ///Filtreleme ve Siralama
    var sortkeyword = "none"
    var filtrelekeyword = "none"
    
    var minprice = "none"
    var maxprice = "none"
    var cesit1 = "none"
    var cesit2 = "none"
    var cesit3 = "none"
    var firstdate = "none"
    var enddate = "none"
    
    var locationManager: CLLocationManager = CLLocationManager()
    var latitude : String = ""
    var longutide : String = ""
    var itemid : String = ""
    
    let leftButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "left1"), for: .normal)
        btn.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutDuzenle()
        
        
        
    }
    
    func layoutDuzenle() {
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
                let logo = UIImage(named: "ic_asset_logo-1")
                let imageView = UIImageView(image:logo)
                imageView.widthAnchor.constraint(equalToConstant: 85).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
                self.navigationItem.titleView = imageView
                imageView.isUserInteractionEnabled = true
//                let gesture = UITapGestureRecognizer(target: self, action: #selector(anaSayfaAction))
//                imageView.addGestureRecognizer(gesture)
        
        
        
        view.addSubview(btnAramaYap)
        _ = btnAramaYap.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        btnAramaYap.addSubview(imgSearch)
        imgSearch.centerYAnchor.constraint(equalTo: btnAramaYap.centerYAnchor).isActive = true
        imgSearch.leftAnchor.constraint(equalTo: btnAramaYap.leftAnchor,constant: 10).isActive = true
        
        view.addSubview(lblSonuc)
        _ = lblSonuc.anchor(top: btnAramaYap.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        
        view.addSubview(view1)
        _ = view1.anchor(top: lblSonuc.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        let btnSV = UIStackView(arrangedSubviews: [btnSirala,btnFIltirelee])
        btnSV.axis = .horizontal
        btnSV.spacing = 20
        btnSV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnSV)
        btnSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnSV.topAnchor.constraint(equalTo: view1.bottomAnchor,constant: 10).isActive = true
        
        //view.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BanaOzelCell",bundle: nil), forCellWithReuseIdentifier: "BanaOzelCell")
        
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 167, height: 249)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
            
        }
        collectionView.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 240).isActive = true
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
      
        
        
        let btnlarSV = UIStackView(arrangedSubviews: [btnEnYenilerr,btnYuksekFiyat,btnDusukFiyat,btnYuksekPuan,btnYakindanUzaga,btnUzakdanYakina])
        btnlarSV.axis = .vertical
        btnlarSV.spacing = 5
        btnlarSV.translatesAutoresizingMaskIntoConstraints = false
        
        
        siralaPopp.addSubview(btnlarSV)
        
        btnlarSV.centerXAnchor.constraint(equalTo: siralaPopp.centerXAnchor).isActive = true
        btnlarSV.centerYAnchor.constraint(equalTo: siralaPopp.centerYAnchor,constant: 30).isActive = true
        
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        
        
        btnFIltirelee.setImage(UIImage(named: "adjust"), for: .normal)
        btnFIltirelee.setTitle(" Filtrele", for: .normal)
        btnFIltirelee.setTitleColor(.white, for: .normal)
        btnFIltirelee.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        btnFIltirelee.clipsToBounds = true
        btnFIltirelee.layer.cornerRadius = 20
        btnFIltirelee.layer.borderWidth = 3
        btnFIltirelee.layer.borderColor = UIColor.rgb(red: 201, green: 213, blue: 51).cgColor
        //btnFIltirelee.addTarget(self, action: #selector(btnFiltireleAction), for: .touchUpInside)
        btnFIltirelee.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnFIltirelee.widthAnchor.constraint(equalToConstant: 120).isActive = true
                
    }
    
    
    @IBAction func leftActionn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func enyenilerrAction() {
        sortkeyword = "enyeniler"
        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        handleDismissal()
    }
    
    @objc func yuksekFiyatAction() {
        sortkeyword = "yuksekfiyat"
        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        handleDismissal()
    }
    
    @objc func dusukFiyatAction() {
        sortkeyword = "dusukfiyat"
        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        handleDismissal()
    }
    
    @objc func yuksekPuanAction() {
        sortkeyword = "yuksekpuan"
        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        handleDismissal()
    }
    
    @objc func yakindanUzagaAction() {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let lastLocation : CLLocation = locations[locations.count-1]
            print("Latitude\(String(format: "%.6f",lastLocation.coordinate.latitude))")
            print("Longitude\(String(format: "%.6f",lastLocation.coordinate.longitude))")
        }
        
        //        sortkeyword = "yakindanuzaga"
        //        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        
        
        handleDismissal()
    }
    
    @objc func uzakdanYakinaAction() {
        sortkeyword = "uzaktanyakina"
        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        handleDismissal()
    }
    
    
    
    @objc func anaSayfaAction() {
        let arama = AramaYap()
        present(arama, animated: true, completion: nil)
    }
    
    
    @objc func btnAramaYapAction() {
        print("AramaYap")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let aramaYap = storyboard.instantiateViewController(withIdentifier: "AramaYap") as! AramaYap

        aramaYap.modalPresentationStyle = .fullScreen
        self.present(aramaYap, animated: true, completion: nil)
        
    }
    
    @objc func btnSiralaAction() {
        view.addSubview(siralaPopp)
        siralaPopp.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        siralaPopp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        siralaPopp.heightAnchor.constraint(equalToConstant: 300).isActive = true
        siralaPopp.widthAnchor.constraint(equalToConstant: 250).isActive = true
        view.addSubview(leftButton)
        leftButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        leftButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        
        siralaPopp.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        siralaPopp.alpha = 0
        leftButton.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.siralaPopp.alpha = 1
            self.siralaPopp.transform = CGAffineTransform.identity
            self.leftButton.alpha = 1
            self.leftButton.transform = CGAffineTransform.identity
        }
        
        
    }
    
    @objc func leftButtonAction() {
           UIView.animate(withDuration: 0.5, animations: {
                      self.visualEffectView.alpha = 0
                      self.siralaPopp.alpha = 0
               self.leftButton.alpha = 0
                          self.siralaPopp.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
               self.leftButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                  }) { (_) in
                      self.siralaPopp.removeFromSuperview()
                    self.leftButton.removeFromSuperview()

                  }
       }
    
    
    
    
    @objc func btnFiltireleAction() {
                
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var _ : Filtrele2 = segue.destination as! Filtrele2
        
        
    }
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.3, animations: {
            self.siralaPopp.alpha = 0
            self.visualEffectView.alpha = 0
            self.siralaPopp.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.siralaPopp.removeFromSuperview()
        }
    }
    
    
    func getitemfromDB(siralama:String,filterkeyword:String){
        
        let userRef = Database.database().reference().child("items")
        
        
        userRef.observe(.value, with: { (snapshot) in
            
            self.itemlist.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                let category = value!["category"] as? String ?? ""
                let itempublish = value!["itempublish"] as? Bool ?? false
                let pricestrrint = value!["pricesrtrint"] as? Int ?? 0
                let kind1 = value!["kind1"] as? String ?? ""
                let kind2 = value!["kind2"] as? String ?? ""
                let kind3 = value!["kind3"] as? String ?? ""
                let itempublishtime = value!["itempublishtime"] as? Int ?? 0
                let title = value!["title"] as? String ?? ""
                let pricestr = value!["pricestr"] as? String ?? ""
                _ = value!["description"] as? String ?? ""
                let photo0 = value!["photo0"] as? String ?? ""
                let itemrate = value!["itemrate"] as? String ?? ""
                let latitude = value!["latitude"] as? Double ?? 0.0
                let longitude = value!["longitude"] as? Double ?? 0.0
                let itemid = value!["itemid"] as? String ?? ""
            
                //bura? he
                
                
                let itemobject = Items.init(
                    category: category,
                    itempublish: itempublish,
                    pricestrrint: pricestrrint,
                    kind1: kind1,
                    kind2: kind2,
                    kind3: kind3,
                    itempublishtime:itempublishtime,
                    pricestr: pricestr,
                    photo0: photo0,
                    itemrate: itemrate,
                    longitude: longitude,
                    latitude: latitude,
                    itemid: itemid,
                    title: title
                    )
                let sehir = value!["sehir"] as? String ?? ""
                 let publisher = value!["publisher"] as? String ?? ""
                              if sehir == Cache.usersehir && publisher != Auth.auth().currentUser?.uid {
                if itempublish { /// urun silinmeyibse
                    
                        
                        ///TODO 2 if ekle sehir kontrol ve publisher ben degilim ise
                    
                        ///arama anahtari
                    let utf8keyword  = self.searchWord!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    let utf8kind1    = kind1.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    let utf8kind2    = kind2.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    let utf8kind3    = kind3.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    let utf8category = category.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    let utf8title    =  title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                                                
                        if utf8kind1.contains(utf8keyword)    ||
                           utf8kind2.contains(utf8keyword)    ||
                           utf8kind3.contains(utf8keyword)    ||
                           utf8category.contains(utf8keyword) ||
                           utf8title.contains(utf8keyword) {
                        
                        /// filtreleme var ise
                        if filterkeyword != "none"{
                            
                            var itemaddcontrol = true
                            
                            let lastminprice = (Int(Double(self.minprice)!))
                            let lastmaxprice = (Int(Double(self.maxprice)!))
                            
                            /// fiyat control
                            if self.minprice != "none" && self.maxprice != "none" {
                                if pricestrrint > lastminprice && pricestrrint < lastmaxprice{
                                }else{
                                    itemaddcontrol = false
                                }
                            }
                            
                            /// cesit1 control
                            if self.cesit1 != "none"{
                                if kind1 != self.cesit1 {
                                    itemaddcontrol = false
                                }
                            }
                            /// cesit2 control
                            if self.cesit2 != "none"{
                                if kind2 != self.cesit2 {
                                    itemaddcontrol = false
                                }
                            }
                            /// cesit3 control
                            if self.cesit3 != "none"{
                                if kind3 != self.cesit3 {
                                    itemaddcontrol = false
                                }
                            }
                            /// ilk gun kontrol
                            if self.firstdate != "none" {
                                let currentfirstday = (Int(self.firstdate)!)
                                if currentfirstday > itempublishtime {
                                    itemaddcontrol = false
                                }
                            }
                            /// son gun kontrol
                            if self.enddate != "none" {
                                
                                let currentendday = (Int(self.enddate)!)
                                if currentendday < itempublishtime {
                                    itemaddcontrol = false
                                }
                                
                            }
                            
                            if itemaddcontrol{
                                self.itemlist.append(itemobject)
                            }
                            
                        }else{ /// filtreleme yok ise
                            self.itemlist.append(itemobject)
                        }
                        
                    }
                 
                
                /// set actionbar title and image
                //self.titleDeyis()
                    
                }
                }
              
            }
            
            if self.sortkeyword != "none" { //siralama
                self.itemlistsirala(itemlist: self.itemlist)
            }else{
                self.itemlist = self.itemlist.reversed()
            }
            
            
            self.collectionView.reloadData()
            
        })
        
        
    }
    
    
    class Items {
        
        let category: String
        let itempublish: Bool
        let pricestrrint: Int
        let pricestr : String
        let kind1: String
        let kind2: String
        let kind3: String
        let itempublishtime: Int
        let photo0 : String
        let itemrate : String
        let longitude : Double
        let latitude : Double
        let itemid : String
        let title : String
        
        var location: CLLocation {
            return CLLocation(latitude: self.latitude, longitude: self.longitude)
        }
        
        func distance(to location: CLLocation) -> CLLocationDistance {
            return location.distance(from: self.location)
        }
        
        
        init(category:String,itempublish:Bool,pricestrrint: Int,kind1: String,kind2: String,kind3: String,itempublishtime: Int,pricestr:String,photo0:String, itemrate:String, longitude:Double,latitude:Double,itemid:String,title:String)
        {
            self.category = category
            self.itempublish = itempublish
            self.pricestrrint = pricestrrint
            self.kind1 = kind1
            self.kind2 = kind2
            self.kind3 = kind3
            self.itempublishtime = itempublishtime
            self.pricestr = pricestr
            self.photo0 = photo0
            self.itemrate = itemrate
            self.longitude = longitude
            self.latitude = latitude
            self.itemid = itemid
            self.title = title
          
            
        }
        
    }
    
    
    func itemlistsirala(itemlist:[Items]){
        switch self.sortkeyword {
        case "enyeniler":
            self.itemlist.sort{$1.itempublishtime < $0.itempublishtime}
            break
        case "yuksekfiyat":
            self.itemlist.sort{$1.pricestrrint < $0.pricestrrint}
            break
        case "dusukfiyat":
            self.itemlist.sort{$0.pricestrrint < $1.pricestrrint}
            break
        case "yuksekpuan":
            self.itemlist.sort{$1.itemrate < $0.itemrate}
            break
        case "yakindanuzaga":
            //            self.itemlist.sort(by: { $0.distance(to: lastLocation!) < $1.distance(to: lastLocation!) })
            break
        case "uzaktanyakina":
            
            break
        default:
            break
        }
        
    }
    
}


extension Search : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.itemlist.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanaOzelCell", for: indexPath) as! BanaOzelCell
        
        //itemleri collection viewda gosterme
        let value2 = self.itemlist[indexPath.row]
        
        let kind1 = value2.kind1
        let kind2 = value2.kind2
        let price = value2.pricestr
        let photo0 = value2.photo0
        _ = value2.itemid
        
        //cell.funcColor(color: data3[1])
        
      
        let title = value2.title
            
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
        
        return cell
    }
    
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("test")
       let value2 = self.itemlist[indexPath.row]
    let itemid = value2.itemid
        
       let uruneklson = UrunSayfasi()
       uruneklson.modalPresentationStyle = .fullScreen
       uruneklson.itemid = itemid
       navigationController?.pushViewController(uruneklson, animated: true)

    }
    
}


extension KategoriyeGoreUrun : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresentig = true
        return transiton
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresentig = false
        return transiton
    }
    
}


