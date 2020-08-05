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
import CoreLocation


class KategoriyeGoreUrun: UIViewController,CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    let estimateWidth = 160.0
    var cellMarginSize = 16.0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    let transiton = SildeInTransition()
    
    
    
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
    
    
    @IBOutlet weak var btnFiltirelee: UIButton!
    
    //    let view6 : UIView = {
    //        let view = UIView()
    //        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
    //        view.layer.cornerRadius = 37
    //        view.heightAnchor.constraint(equalToConstant: 232).isActive = true
    //        view.widthAnchor.constraint(equalToConstant: 250).isActive = true
    //        return view
    //    }()
    
    
    private var tap: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        btnFiltirelee.setImage(UIImage(named: "adjust"), for: .normal)
        btnFiltirelee.setTitle(" Filtrele", for: .normal)
        btnFiltirelee.setTitleColor(.white, for: .normal)
        btnFiltirelee.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        btnFiltirelee.clipsToBounds = true
        btnFiltirelee.layer.cornerRadius = 20
        btnFiltirelee.layer.borderWidth = 3
        btnFiltirelee.layer.borderColor = UIColor.rgb(red: 201, green: 213, blue: 51).cgColor
        btnFiltirelee.addTarget(self, action: #selector(btnFiltireleAction), for: .touchUpInside)
        btnFiltirelee.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnFiltirelee.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        
        
        
        
        
        
        print(itemcategory)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        layoutDuzenle()
        
        print("Data:minprice:\(minprice),maxprice:\(maxprice),cesit1:\(cesit1),cesit2:\(cesit2),cesit3:\(cesit3),firstdate:\(firstdate),enddate:\(enddate)")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BanaOzelCell",bundle: nil), forCellWithReuseIdentifier: "BanaOzelCell")
        
       if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    //layout.itemSize = CGSize(width: 167, height: 249)
                    
                   layout.minimumLineSpacing = 10
        //            layout.minimumInteritemSpacing = 5
                }
        
        /// Get item from db
        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "left1"), style: .done, target: self, action: #selector(urunEkleAction))
        self.navigationItem.leftBarButtonItem = rightBarButtonItem
        
        
        
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 0, green: 90, blue: 63)
        navigationController?.navigationBar.isTranslucent = false
        
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
           if touch.view?.isDescendant(of: self.collectionView) == true {
               return false
           }
           return true
       }
    

    
    
    
    
    func layoutDuzenle() {
        
        
        
        
        let btnlarSV = UIStackView(arrangedSubviews: [btnEnYenilerr,btnYuksekFiyat,btnDusukFiyat,btnYuksekPuan,btnYakindanUzaga,btnUzakdanYakina])
        btnlarSV.axis = .vertical
        btnlarSV.spacing = 5
        btnlarSV.translatesAutoresizingMaskIntoConstraints = false
        
        //siralaPopp.addSubview(view6)
        //        siralaPopp.addSubview(btnEnYenilerr)
        //        siralaPopp.addSubview(btnYuksekPuan)
        //        siralaPopp.addSubview(btnDusukFiyat)
        //        siralaPopp.addSubview(btnYuksekPuan)
        //        siralaPopp.addSubview(btnYakindanUzaga)
        //        siralaPopp.addSubview(btnUzakdanYakina)
        
        
        
        
        view.addSubview(btnSirala)
        //view.addSubview(btnFiltrele)
        view.addSubview(visualEffectView)
        siralaPopp.addSubview(btnlarSV)
        
        btnlarSV.centerXAnchor.constraint(equalTo: siralaPopp.centerXAnchor).isActive = true
        btnlarSV.centerYAnchor.constraint(equalTo: siralaPopp.centerYAnchor,constant: 30).isActive = true
        
        
        
        
        //_ = view6.anchor(top: siralaPopp.topAnchor, bottom: siralaPopp.bottomAnchor, leading: siralaPopp.leadingAnchor, trailing: siralaPopp.trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        //        _ = btnEnYenilerr.anchor(top: siralaPopp.topAnchor, bottom: nil, leading: siralaPopp.leadingAnchor, trailing: siralaPopp.trailingAnchor,padding: .init(top: 10, left: 40, bottom: 20, right: 40))
        //
        //        _ = btnYuksekPuan.anchor(top: btnEnYenilerr.bottomAnchor, bottom: nil, leading: siralaPopp.leadingAnchor, trailing: siralaPopp.trailingAnchor,padding: .init(top: 0, left: 40, bottom: 0, right: 40))
        //        _ = btnDusukFiyat.anchor(top: btnYuksekPuan.bottomAnchor, bottom: nil, leading: siralaPopp.leadingAnchor, trailing: siralaPopp.trailingAnchor,padding: .init(top: 0, left: 40, bottom: 0, right: 40))
        //        _ = btnYuksekPuan.anchor(top: btnDusukFiyat.bottomAnchor, bottom: nil, leading: siralaPopp.leadingAnchor, trailing: siralaPopp.trailingAnchor,padding: .init(top: 0, left: 40, bottom: 0, right: 40))
        //        _ = btnYakindanUzaga.anchor(top: btnYuksekPuan.bottomAnchor, bottom: nil, leading: siralaPopp.leadingAnchor, trailing: siralaPopp.trailingAnchor,padding: .init(top: 0, left: 40, bottom: 0, right: 40))
        //        _ = btnUzakdanYakina.anchor(top: btnYakindanUzaga.bottomAnchor, bottom: nil, leading: siralaPopp.leadingAnchor, trailing: siralaPopp.trailingAnchor,padding: .init(top: 0, left: 40, bottom: 0, right: 40))
        
        
        
        _ = btnSirala.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 15, left: 50, bottom: 0, right: 0))
        _ = btnFiltirelee.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 15, left: 0, bottom: 0, right: 50))
        
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
               visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
               visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
               visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
               visualEffectView.alpha = 0
        
        
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
        
        //sen bulari diyirsende?
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
        

        
        sortkeyword = "yakindanuzaga"
        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        handleDismissal()
    }
    
    @objc func uzakdanYakinaAction() {
        sortkeyword = "uzaktanyakina"
        getitemfromDB(siralama: sortkeyword, filterkeyword: filtrelekeyword)
        handleDismissal()
        
        
    }
    
  
    
    
    //MARK: problem
    @objc func urunEkleAction() {
        //        dismiss(animated: true, completion: nil)
        //
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
        //
        //        vc.selectedIndex = 0
        //        vc.modalPresentationStyle = .fullScreen
        //        self.present(vc, animated: true, completion: nil)
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
   
    
    
    
    @objc func btnSiralaAction() {
        view.addSubview(siralaPopp)
        siralaPopp.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        siralaPopp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        siralaPopp.heightAnchor.constraint(equalToConstant: 300).isActive = true
        siralaPopp.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        siralaPopp.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        siralaPopp.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.siralaPopp.alpha = 1
            self.siralaPopp.transform = CGAffineTransform.identity
        }
        
    }
    
    
    
    @objc func btnFiltireleAction() {
        
        let uruneklson = Filtrele()
        uruneklson.modalPresentationStyle = .pageSheet
        present(uruneklson, animated: true, completion: nil)
       
        //        uruneklson.itemcategory = itemcategory
        //        navigationController?.pushViewController(uruneklson, animated: true)
        
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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let filtirele : Filtrele = segue.destination as! Filtrele
        
        filtirele.itemcategory = itemcategory
        
        
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
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                let lastLocation : CLLocation = locations[locations.count-1]
                                
                self.itemlist.sort(by: { $0.distance(to: lastLocation) < $1.distance(to: CLLocation(latitude: $1.latitude, longitude: $1.longitude)) })
    
            }
            break
        case "uzaktanyakina":
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                let lastLocation : CLLocation = locations[locations.count-1]
                
                self.itemlist.sort(by: { $0.distance(to: lastLocation) < $1.distance(to: CLLocation(latitude: $1.latitude, longitude: $1.longitude)) })
                self.itemlist.reverse()
                
            }
            break
        default:
            break
        }
        
        
    }
    
    func titleDeyis() {
        switch self.itemcategory {
        case "kampmalzemeleri" :
            let logo = UIImage(named: "kamp2-1")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            break
        case "kutuoyunlari":
            let logo = UIImage(named: "kutu1")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            break
        case "elektronik":
            let logo = UIImage(named: "elektronik1")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            break
        case "sporekipmani":
            let logo = UIImage(named: "spor1")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            break
        case "tamiraletleri":
            let logo = UIImage(named: "tamir2")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            break
        case "kiyafet":
            let logo = UIImage(named: "kiyafet1")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            break
        case "enstruman":
            let logo = UIImage(named: "enstruman2")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            break
        case "diger":
            let logo = UIImage(named: "diger1")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            break
        case "kitap":
            let logo = UIImage(named: "kurtuphane1")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            break
        default:
            break
            
        }
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
        
        
        let kind1 = value2.kind1
        let kind2 = value2.kind2
        let price = value2.pricestr
        let photo0 = value2.photo0
        
        
        //cell.funcColor(color: data3[1])
        
        
        //set first category
        
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
                  let pricestr = value!["pricestr"] as? String ?? ""
                  let photo0 = value!["photo0"] as? String ?? ""
                  let itemrate = value!["itemrate"] as? String ?? ""
                  let latitude = value!["latitude"] as? Double ?? 0.0
                  let longitude = value!["longitude"] as? Double ?? 0.0
                   let itemid = value!["itemid"] as? String ?? ""
                let title = value!["title"] as? String ?? ""
                
                            

                  
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
                              title: title)

                  let sehir = value!["sehir"] as? String ?? ""
                 let publisher = value!["publisher"] as? String ?? ""
                  if sehir == Cache.usersehir && publisher != Auth.auth().currentUser?.uid {
                      //yoxla isdiyir he bawa hara var goren hec yer sende acan kimi mene bildirim gelir onu yigisdirarsan mendede sene getmelidi  yaxsi gozde baxim bide bezner urunleri kontrol elemeliyik
                  if itempublish { /// urun silinmeyibse
                      
                      if self.itemcategory == category{ /// kategoriye kontrol
                          
                          ///TODO 2 if ekle sehir kontrol ve publisher ben degilim ise
                          
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
                    }
                  }
                
                if self.itemlist.count == 0 {
                    self.makeAlertt(tittle: "UYARI", message: "Renty de ürünler seçdiğiniz şehirlere göre listeleniyor.Seçdiğiniz şehirde hiç bir ürün bulunamadı.Diğer ürünleri görmek için AYARLAR kısmından şehirinizi değiştire bilirsiniz")
                }else{
                    
                }
                  
                  /// set actionbar title and image
                  self.titleDeyis()
                  
              }
                          
              if self.sortkeyword != "none" { //siralama
                  self.itemlistsirala(itemlist: self.itemlist)
              }else{
                  self.itemlist = self.itemlist.reversed()
              }
              
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


 



//extension KategoriyeGoreUrun : UIViewControllerTransitioningDelegate{
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transiton.isPresentig = true
//        return transiton
//    }
//
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transiton.isPresentig = false
//        return transiton
//    }
//
//
//
//}
//

class Place {
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0

    var location: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }

    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
}
