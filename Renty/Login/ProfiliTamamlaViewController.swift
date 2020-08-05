//
//  ProfiliTamamlaViewController.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/19/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseCore
import FirebaseAuth


class ProfiliTamamlaViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,CLLocationManagerDelegate {
    
    
//    var txtSehir : UITextField = {
//       let txt = UITextField()
//        txt.backgroundColor = .white
//        txt.attributedPlaceholder = NSAttributedString(string: "Hangi ilde yaşıyorsunuz?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
//        txt.layer.masksToBounds = true
//        txt.layer.borderWidth = 2
//        txt.layer.borderColor = UIColor.rgb(red: 0, green: 90, blue: 63).cgColor
//        txt.clipsToBounds = true
//        txt.layer.cornerRadius = 10
//        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        return txt
//
//    }()
    
    
   lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    lazy var contentViewSize2 = CGSize(width: self.view.frame.width, height: self.view.frame.height+400)
    
    lazy var scrolView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
       var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let pickerView = UIPickerView()
    var countries = [Country]()
    var city = ""
    var country = ""
    var locationManager: CLLocationManager = CLLocationManager()
    var latitude : String = ""
    var longutide : String = ""
    var locationcontrol = false
    var numbercontrol = false
    var phoneNumberControl = 0
    
    
    let imgTamamla : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "tamamla"))
        return img
    }()
    
    let lblTamamla : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "Profili tamamla"
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
        
    let lblKonum : UILabel = {
           let lbl = UILabel()
           lbl.textAlignment = .center
           lbl.text = "Konum"
           lbl.textColor = .rgb(red: 0, green: 38, blue: 26)
           lbl.font = UIFont.boldSystemFont(ofSize: 15)
           return lbl
       }()
    
    let lblMesaj : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "*Ürünleriniz olduğunuz konuma işaretlenecekdir"
        lbl.textColor = .darkGray
        lbl.font = UIFont.boldSystemFont(ofSize: 10)
        return lbl
    }()
    
   let lbldogrulama : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "Telefon numarası doğrulama"
        lbl.textColor = .rgb(red: 0, green: 38, blue: 26)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
      }()
    
    let btnKonumBelirle : UIButton = {
        let btn = UIButton(type: .system)
        let icon = UIImage(named: "location")!
        btn.setImage(icon, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        btn.setTitle("KONUMUNU BELIRLE", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .rgb(red: 4, green: 140, blue: 99)
        btn.layer.cornerRadius = 23
        btn.addTarget(self, action: #selector(btnKonumBelirlee), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    
    let btnDogrula : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Onay kodunu gonder", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .rgb(red: 4, green: 140, blue: 99)
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(btnDogrulaa), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        btn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return btn
       }()
    
    let btnTamamla : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("TAMAMLA", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .rgb(red: 201, green: 213, blue: 51)
        btn.layer.cornerRadius = 23
        btn.addTarget(self, action: #selector(btnTamamlaa), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    
    let lineTextField1 : UITextField = {
        let text = UITextField()
        text.adjustsFontSizeToFitWidth = true
        text.minimumFontSize = 10
        text.addLine(position: .LINE_POSITION_BOTTOM, color: .darkGray, width: 3)
        text.textColor = .black
         text.attributedPlaceholder = NSAttributedString(string: "Açık adresinizi giriniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        text.keyboardType = .emailAddress
        text.setLeftPaddingPoints(10)
        return text
       }()
    
    
    
    let lineTextField : UITextField = {
        let text = UITextField()
        text.adjustsFontSizeToFitWidth = true
        text.minimumFontSize = 10
        text.textColor = .black
        let image = UIImage(named: "phonee")
        text.loginIcon(image!)
        text.addLine(position: .LINE_POSITION_BOTTOM, color: .rgb(red: 0, green: 38, blue: 26), width: 3)
        text.attributedPlaceholder = NSAttributedString(string: "Telefon numaranızı giriniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        text.keyboardType = .numbersAndPunctuation
        return text
    }()
    

    let btnCikisYap : UIButton = {
        let btn = UIButton(type: .system)
        //        btn.setTitle("CIKIS YAp", for: .normal)
        //        btn.setTitleColor(.white, for: .normal)
        //        btn.backgroundColor = .rgb(red: 4, green: 140, blue: 99)
        //        btn.layer.cornerRadius = 23
        btn.setImage(UIImage(named: "return"), for: .normal)
        btn.addTarget(self, action: #selector(buttonCikYap), for: .touchUpInside)
        //        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        //        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    
   
   
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //pickerView.setValue(UIColor.yellow, forKey: "test")
        
        numberControl()
        super.viewDidLoad()
        layoutDuzunle()
        countriesAppend()
        
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureREcongizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        scrolView.contentSize = contentViewSize2
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrolView.contentSize = contentViewSize
    }
    
    //MARK: layouDuzenle
    func layoutDuzunle() {
        
        view.backgroundColor = .white

        
        let yesilView = UIView()
        yesilView.clipsToBounds = true
        yesilView.layer.cornerRadius = 25
        yesilView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        yesilView.backgroundColor = .rgb(red: 4, green: 140, blue: 99)
        yesilView.heightAnchor.constraint(equalToConstant: 60).isActive = true
              
        let beyazView1 = UIView()
        beyazView1.backgroundColor = .lightText
        beyazView1.heightAnchor.constraint(equalToConstant: 350).isActive = true
              
        let beyazView2 = UIView()
        beyazView2.backgroundColor = .lightText
        beyazView2.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        let dogrulSV = UIStackView(arrangedSubviews: [lineTextField1,btnDogrula,btnTamamla])
        dogrulSV.spacing = 7
        dogrulSV.axis = .vertical
        
        
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        yesilView.addSubview(imgTamamla)
        yesilView.addSubview(lblTamamla)
        containerView.addSubview(yesilView)
        containerView.addSubview(beyazView1)
        containerView.addSubview(beyazView2)
        beyazView1.addSubview(lblKonum)
        beyazView2.addSubview(lbldogrulama)
        beyazView2.addSubview(lineTextField)
        beyazView2.addSubview(btnDogrula)
        beyazView2.addSubview(btnTamamla)
        beyazView1.addSubview(lblMesaj)
        beyazView1.addSubview(btnKonumBelirle)
        beyazView1.addSubview(lineTextField1)
        beyazView1.addSubview(pickerView)
        
       
        
        _ = yesilView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        _ = lblTamamla.anchor(top: yesilView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 15, left: 80, bottom: 0, right: 30))
        _ = imgTamamla.anchor(top: yesilView.topAnchor, bottom: yesilView.bottomAnchor, leading: yesilView.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 60, bottom: 0, right: 0))
        _ = beyazView1.anchor(top: yesilView.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        _ = beyazView2.anchor(top: beyazView1.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 7, left: 0, bottom: 0, right: 0))
        _ = lblKonum.anchor(top: beyazView1.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        _ = lbldogrulama.anchor(top: beyazView2.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        _ = lineTextField.anchor(top: lbldogrulama.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 27, left: 5, bottom: 0, right: 5))
        _ = btnDogrula.anchor(top: lineTextField.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 15, left: 10, bottom: 0, right: 10))
        _ = btnTamamla.anchor(top: btnDogrula.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 10, left: 40, bottom: 0, right: 40))
        _ = lblMesaj.anchor(top: nil, bottom: beyazView1.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 40, bottom: 15, right: 40))
        _ = btnKonumBelirle.anchor(top: nil, bottom: lblMesaj.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 40, bottom: 5, right: 40))
        _ = lineTextField1.anchor(top: nil, bottom: btnKonumBelirle.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        _ = pickerView.anchor(top: nil , bottom: lineTextField1.topAnchor , leading: beyazView1.leadingAnchor, trailing: beyazView1.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        //_ = txtSehir.anchor(top: lblKonum.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 15, left: 15, bottom: 0, right: 16))
       
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(btnCikisYap)
        _ = btnCikisYap.anchor(top: btnTamamla.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 10, left: 100, bottom: 0, right: 100))
    
    }
    
    
   
    
    func countriesAppend() {
        countries.append(Country(country: "İstanbul", cities: ["Adalar", "Bakırköy", "Beşiktaş", "Beykoz", "Beyoğlu", "Çatalca", "Eyüp", "Fatih", "Gaziosmanpaşa", "Kadıköy", "Kartal", "Sarıyer", "Silivri", "Şile", "Şişli", "Üsküdar", "Zeytinburnu", "Büyükçekmece", "Kağıthane", "Küçükçekmece", "Pendik", "Ümraniye", "Bayrampaşa", "Avcılar", "Bağcılar", "Bahçelievler", "Güngören", "Maltepe", "Sultanbeyli", "Tuzla", "Esenler", "Arnavutköy", "Ataşehir", "Başakşehir", "Beylikdüzü", "Çekmeköy", "Esenyurt", "Sancaktepe", "Sultangazi"]))
        countries.append(Country(country: "Ankara", cities: ["Altındağ", "Ayaş", "Bala", "Beypazarı", "Çamlıdere", "Çankaya", "Çubuk", "Elmadağ", "Güdül", "Haymana", "Kalecik", "Kızılcahamam", "Nallıhan", "Polatlı", "Şereflikoçhisar", "Yenimahalle", "Gölbaşı", "Keçiören", "Mamak", "Sincan", "Kazan", "Akyurt", "Etimesgut", "Evren", "Pursaklar"]))
        countries.append(Country(country: "İzmir", cities: ["Aliağa", "Bayındır", "Bergama", "Bornova", "Çeşme", "Dikili", "Foça", "Karaburun", "Karşıyaka", "Kemalpaşa", "Kınık", "Kiraz", "Menemen", "Ödemiş", "Seferihisar", "Selçuk", "Tire", "Torbalı", "Urla", "Beydağ", "Buca", "Konak", "Menderes", "Balçova", "Çiğli", "Gaziemir", "Narlıdere", "Güzelbahçe", "Bayraklı", "Karabağlar"]))
        countries.append(Country(country: "Adana", cities: ["Aladağ", "Ceyhan", "Çukurova", "Feke", "İmamoğlu", "Karaisalı", "Karataş", "Kozan", "Pozantı", "Saimbeyli", "Sarıçam", "Seyhan", "Tufanbeyli", "Yumurtalık", "Yüreğir"]))
        countries.append(Country(country:  "Adıyaman", cities: ["Besni", "Çelikhan", "Gerger", "Gölbaşı", "Kahta", "Merkez", "Samsat", "Sincik", "Tut"]))
        countries.append(Country(country: "Afyonkarahisar", cities: ["Başmakçı", "Bayat", "Bolvadin", "Çay", "Çobanlar", "Dazkırı", "Dinar", "Emirdağ", "Evciler", "Hocalar", "İhsaniye", "İscehisar", "Kızılören", "Merkez", "Sandıklı", "Sinanpaşa", "Sultandağı", "Şuhut"]))
        countries.append(Country(country: "Ağrı", cities: ["Diyadin", "Doğubayazıt", "Eleşkirt", "Hamur", "Merkez", "Patnos", "Taşlıçay", "Tutak"]))
        countries.append(Country(country: "Aksaray", cities:  ["Ağaçören", "Eskil", "Gülağaç", "Güzelyurt", "Merkez", "Ortaköy", "Sarıyahşi"]))
        countries.append(Country(country: "Amasya", cities: ["Göynücek", "Gümüşhacıköy", "Hamamözü", "Merkez", "Merzifon", "Suluova", "Taşova"]))
        countries.append(Country(country: "Antalya", cities: ["Akseki", "Alanya", "Elmalı", "Finike", "Gazipaşa", "Gündoğmuş", "Kaş", "Korkuteli", "Kumluca", "Manavgat", "Serik", "Demre", "İbradı", "Kemer", "Aksu", "Döşemealtı", "Kepez", "Konyaaltı", "Muratpaşa"]))
        countries.append(Country(country: "Ardahan", cities: ["Merkez", "Çıldır", "Göle", "Hanak", "Posof", "Damal"]))
        countries.append(Country(country: "Artvin", cities: ["Ardanuç", "Arhavi", "Merkez", "Borçka", "Hopa", "Şavşat", "Yusufeli", "Murgul"]))
        countries.append(Country(country: "Aydın", cities: ["Merkez", "Bozdoğan", "Efeler", "Çine", "Germencik", "Karacasu", "Koçarlı", "Kuşadası", "Kuyucak", "Nazilli", "Söke", "Sultanhisar", "Yenipazar", "Buharkent", "İncirliova", "Karpuzlu", "Köşk", "Didim"]))
        countries.append(Country(country: "Balıkesir", cities: ["Altıeylül", "Ayvalık", "Merkez", "Balya", "Bandırma", "Bigadiç", "Burhaniye", "Dursunbey", "Edremit", "Erdek", "Gönen", "Havran", "İvrindi", "Karesi", "Kepsut", "Manyas", "Savaştepe", "Sındırgı", "Gömeç", "Susurluk", "Marmara"]))
        countries.append(Country(country: "Bartın", cities: ["Merkez", "Kurucaşile", "Ulus", "Amasra"]))
        countries.append(Country(country: "Batman", cities: ["Merkez", "Beşiri", "Gercüş", "Kozluk", "Sason", "Hasankeyf"]))
        countries.append(Country(country: "Bayburt", cities: ["Merkez", "Aydıntepe", "Demirözü"]))
        countries.append(Country(country: "Bilecik", cities: ["Merkez", "Bozüyük", "Gölpazarı", "Osmaneli", "Pazaryeri", "Söğüt", "Yenipazar", "İnhisar"]))
        countries.append(Country(country:  "Bingöl", cities: ["Merkez", "Genç", "Karlıova", "Kiğı", "Solhan", "Adaklı", "Yayladere", "Yedisu"]))
        countries.append(Country(country: "Bitlis", cities: ["Adilcevaz", "Ahlat", "Merkez", "Hizan", "Mutki", "Tatvan", "Güroymak"]))
        countries.append(Country(country: "Bolu", cities: ["Merkez", "Gerede", "Göynük", "Kıbrıscık", "Mengen", "Mudurnu", "Seben", "Dörtdivan", "Yeniçağa"]))
        countries.append(Country(country: "Burdur", cities: ["Ağlasun", "Bucak", "Merkez", "Gölhisar", "Tefenni", "Yeşilova", "Karamanlı", "Kemer", "Altınyayla", "Çavdır", "Çeltikçi"]))
        countries.append(Country(country: "Bursa", cities: ["Gemlik", "İnegöl", "İznik", "Karacabey", "Keles", "Mudanya", "Mustafakemalpaşa", "Orhaneli", "Orhangazi", "Yenişehir", "Büyükorhan", "Harmancık", "Nilüfer", "Osmangazi", "Yıldırım", "Gürsu", "Kestel"]))
        countries.append(Country(country: "Çanakkale", cities: ["Ayvacık", "Bayramiç", "Biga", "Bozcaada", "Çan", "Merkez", "Eceabat", "Ezine", "Gelibolu", "Gökçeada", "Lapseki", "Yenice"]))
        countries.append(Country(country: "Çankırı", cities: ["Merkez", "Çerkeş", "Eldivan", "Ilgaz", "Kurşunlu", "Orta", "Şabanözü", "Yapraklı", "Atkaracalar", "Kızılırmak", "Bayramören", "Korgun"]))
        countries.append(Country(country:  "Çorum", cities: ["Alaca", "Bayat", "Merkez", "İskilip", "Kargı", "Mecitözü", "Ortaköy", "Osmancık", "Sungurlu", "Boğazkale", "Uğurludağ", "Dodurga", "Laçin", "Oğuzlar"]))
        countries.append(Country(country: "Denizli", cities: ["Acıpayam", "Buldan", "Çal", "Çameli", "Çardak", "Çivril", "Merkez", "Merkezefendi", "Pamukkale", "Güney", "Kale", "Sarayköy", "Tavas", "Babadağ", "Bekilli", "Honaz", "Serinhisar", "Baklan", "Beyağaç", "Bozkurt"]))
        countries.append(Country(country: "Diyarbakır", cities: ["Kocaköy", "Çermik", "Çınar", "Çüngüş", "Dicle", "Ergani", "Hani", "Hazro", "Kulp", "Lice", "Silvan", "Eğil", "Bağlar", "Kayapınar", "Sur", "Yenişehir", "Bismil"]))
        countries.append(Country(country: "Düzce", cities: ["Akçakoca", "Merkez", "Yığılca", "Cumayeri", "Gölyaka", "Çilimli", "Gümüşova", "Kaynaşlı"]))
        countries.append(Country(country: "Edirne", cities: ["Merkez", "Enez", "Havsa", "İpsala", "Keşan", "Lalapaşa", "Meriç", "Uzunköprü", "Süloğlu"]))
        countries.append(Country(country: "Elazığ", cities: ["Ağın", "Baskil", "Merkez", "Karakoçan", "Keban", "Maden", "Palu", "Sivrice", "Arıcak", "Kovancılar", "Alacakaya"]))
        countries.append(Country(country: "Erzincan", cities: ["Çayırlı", "Merkez", "İliç", "Kemah", "Kemaliye", "Refahiye", "Tercan", "Üzümlü", "Otlukbeli"]))
        countries.append(Country(country: "Erzurum", cities: ["Aşkale", "Çat", "Hınıs", "Horasan", "İspir", "Karayazı", "Narman", "Oltu", "Olur", "Pasinler", "Şenkaya", "Tekman", "Tortum", "Karaçoban", "Uzundere", "Pazaryolu", "Köprüköy", "Palandöken", "Yakutiye", "Aziziye"]))
        countries.append(Country(country: "Eskişehir", cities: ["Çifteler", "Mahmudiye", "Mihalıççık", "Sarıcakaya", "Seyitgazi", "Sivrihisar", "Alpu", "Beylikova", "İnönü", "Günyüzü", "Han", "Mihalgazi", "Odunpazarı", "Tepebaşı"]))
        countries.append(Country(country: "Gaziantep", cities: ["Araban", "İslahiye", "Nizip", "Oğuzeli", "Yavuzeli", "Şahinbey", "Şehitkamil", "Karkamış", "Nurdağı"]))
        countries.append(Country(country: "Giresun", cities: ["Alucra", "Bulancak", "Dereli", "Espiye", "Eynesil", "Merkez", "Görele", "Keşap", "Şebinkarahisar", "Tirebolu", "Piraziz", "Yağlıdere", "Çamoluk", "Çanakçı", "Doğankent", "Güce"]))
        countries.append(Country(country: "Gümüşhane", cities: ["Merkez", "Kelkit", "Şiran", "Torul", "Köse", "Kürtün"]))
        countries.append(Country(country: "Hakkari", cities: ["Çukurca", "Merkez", "Şemdinli", "Yüksekova"]))
        countries.append(Country(country: "Hatay", cities: ["Altınözü", "Arsuz", "Defne", "Dörtyol", "Hassa", "Antakya", "İskenderun", "Kırıkhan", "Payas", "Reyhanlı", "Samandağ", "Yayladağı", "Erzin", "Belen", "Kumlu"]))
        countries.append(Country(country: "Iğdır", cities: ["Aralık", "Merkez", "Tuzluca", "Karakoyunlu"]))
        countries.append(Country(country: "Isparta", cities: ["Atabey", "Eğirdir", "Gelendost", "Merkez", "Keçiborlu", "Senirkent", "Sütçüler", "Şarkikaraağaç", "Uluborlu", "Yalvaç", "Aksu", "Gönen", "Yenişarbademli"]))
        countries.append(Country(country: "Kahramanmaraş", cities: ["Afşin", "Andırın", "Dulkadiroğlu", "Onikişubat", "Elbistan", "Göksun", "Merkez", "Pazarcık", "Türkoğlu", "Çağlayancerit", "Ekinözü", "Nurhak"]))
        countries.append(Country(country: "Karabük", cities: ["Eflani", "Eskipazar", "Merkez", "Ovacık", "Safranbolu", "Yenice"]))
        countries.append(Country(country: "Karaman", cities: ["Ermenek", "Merkez", "Ayrancı", "Kazımkarabekir", "Başyayla", "Sarıveliler"]))
        countries.append(Country(country: "Kars", cities: ["Arpaçay", "Digor", "Kağızman", "Merkez", "Sarıkamış", "Selim", "Susuz", "Akyaka"]))
        countries.append(Country(country: "Kastamonu", cities: ["Abana", "Araç", "Azdavay", "Bozkurt", "Cide", "Çatalzeytin", "Daday", "Devrekani", "İnebolu", "Merkez", "Küre", "Taşköprü", "Tosya", "İhsangazi", "Pınarbaşı", "Şenpazar", "Ağlı", "Doğanyurt", "Hanönü", "Seydiler"]))
        countries.append(Country(country: "Kayseri", cities: ["Bünyan", "Develi", "Felahiye", "İncesu", "Pınarbaşı", "Sarıoğlan", "Sarız", "Tomarza", "Yahyalı", "Yeşilhisar", "Akkışla", "Talas", "Kocasinan", "Melikgazi", "Hacılar", "Özvatan"]))
        countries.append(Country(country: "Kırıkkale", cities: [ "Delice", "Keskin", "Merkez", "Sulakyurt", "Bahşili", "Balışeyh", "Çelebi", "Karakeçili", "Yahşihan"]))
        countries.append(Country(country: "Kırklareli", cities: [  "Babaeski", "Demirköy", "Merkez", "Kofçaz", "Lüleburgaz", "Pehlivanköy", "Pınarhisar", "Vize"]))
        countries.append(Country(country: "Kırşehir", cities: ["Çiçekdağı", "Kaman", "Merkez", "Mucur", "Akpınar", "Akçakent", "Boztepe"]))
        countries.append(Country(country: "Kilis", cities: ["Merkez", "Elbeyli", "Musabeyli", "Polateli"]))
        countries.append(Country(country:  "Kocaeli", cities: ["Gebze", "Gölcük", "Kandıra", "Karamürsel", "Körfez", "Derince", "Başiskele", "Çayırova", "Darıca", "Dilovası", "İzmit", "Kartepe"]))
        countries.append(Country(country: "Konya", cities: ["Akşehir", "Beyşehir", "Bozkır", "Cihanbeyli", "Çumra", "Doğanhisar", "Ereğli", "Hadim", "Ilgın", "Kadınhanı", "Karapınar", "Kulu", "Sarayönü", "Seydişehir", "Yunak", "Akören", "Altınekin", "Derebucak", "Hüyük", "Karatay", "Meram", "Selçuklu", "Taşkent", "Ahırlı", "Çeltik", "Derbent", "Emirgazi", "Güneysınır", "Halkapınar", "Tuzlukçu", "Yalıhüyük"]))
        countries.append(Country(country: "Malatya", cities: ["Altıntaş", "Domaniç", "Emet", "Gediz", "Merkez", "Simav", "Tavşanlı", "Aslanapa", "Dumlupınar", "Hisarcık", "Şaphane", "Çavdarhisar", "Pazarlar"]))
        countries.append(Country(country: "Manisa", cities: ["Akhisar", "Alaşehir", "Demirci", "Gördes", "Kırkağaç", "Kula", "Merkez", "Salihli", "Sarıgöl", "Saruhanlı", "Selendi", "Soma", "Şehzadeler", "Yunusemre", "Turgutlu", "Ahmetli", "Gölmarmara", "Köprübaşı"]))
        countries.append(Country(country: "Mardin", cities: ["Derik", "Kızıltepe", "Artuklu", "Merkez", "Mazıdağı", "Midyat", "Nusaybin", "Ömerli", "Savur", "Dargeçit", "Yeşilli"]))
        countries.append(Country(country: "Mersin", cities: ["Anamur", "Erdemli", "Gülnar", "Mut", "Silifke", "Tarsus", "Aydıncık", "Bozyazı", "Çamlıyayla", "Akdeniz", "Mezitli", "Toroslar", "Yenişehir"]))
        countries.append(Country(country: "Muğla", cities: ["Bodrum", "Datça", "Fethiye", "Köyceğiz", "Marmaris", "Menteşe", "Milas", "Ula", "Yatağan", "Dalaman", "Seydikemer", "Ortaca", "Kavaklıdere"]))
        countries.append(Country(country: "Muş", cities: ["Bulanık", "Malazgirt", "Merkez", "Varto", "Hasköy", "Korkut"]))
        countries.append(Country(country: "Nevşehir", cities: ["Avanos", "Derinkuyu", "Gülşehir", "Hacıbektaş", "Kozaklı", "Merkez", "Ürgüp", "Acıgöl"]))
        countries.append(Country(country: "Niğde", cities: ["Bor", "Çamardı", "Merkez", "Ulukışla", "Altunhisar", "Çiftlik"]))
        countries.append(Country(country: "Ordu", cities: ["Akkuş", "Altınordu", "Aybastı", "Fatsa", "Gölköy", "Korgan", "Kumru", "Mesudiye", "Perşembe", "Ulubey", "Ünye", "Gülyalı", "Gürgentepe", "Çamaş", "Çatalpınar", "Çaybaşı", "İkizce", "Kabadüz", "Kabataş"]))
        countries.append(Country(country: "Osmaniye", cities: ["Bahçe", "Kadirli", "Merkez", "Düziçi", "Hasanbeyli", "Sumbas", "Toprakkale"]))
        countries.append(Country(country: "Rize", cities: ["Ardeşen", "Çamlıhemşin", "Çayeli", "Fındıklı", "İkizdere", "Kalkandere", "Pazar", "Merkez", "Güneysu", "Derepazarı", "Hemşin", "İyidere"]))
        countries.append(Country(country: "Sakarya", cities: ["Akyazı", "Geyve", "Hendek", "Karasu", "Kaynarca", "Sapanca", "Kocaali", "Pamukova", "Taraklı", "Ferizli", "Karapürçek", "Söğütlü", "Adapazarı", "Arifiye", "Erenler", "Serdivan"]))
        countries.append(Country(country: "Samsun", cities: ["Alaçam", "Bafra", "Çarşamba", "Havza", "Kavak", "Ladik", "Terme", "Vezirköprü", "Asarcık", "Ondokuzmayıs", "Salıpazarı", "Tekkeköy", "Ayvacık", "Yakakent", "Atakum", "Canik", "İlkadım"]))
        countries.append(Country(country: "Siirt", cities: ["Baykan", "Eruh", "Kurtalan", "Pervari", "Merkez", "Şirvan", "Tillo"]))
        countries.append(Country(country: "Sinop", cities: ["Ayancık", "Boyabat", "Durağan", "Erfelek", "Gerze", "Merkez", "Türkeli", "Dikmen", "Saraydüzü"]))
        countries.append(Country(country: "Sivas", cities: ["Divriği", "Gemerek", "Gürün", "Hafik", "İmranlı", "Kangal", "Koyulhisar", "Merkez", "Suşehri", "Şarkışla", "Yıldızeli", "Zara", "Akıncılar", "Altınyayla", "Doğanşar", "Gölova", "Ulaş"]))
        countries.append(Country(country: "Şırnak", cities: ["Beytüşşebap", "Cizre", "İdil", "Silopi", "Merkez", "Uludere", "Güçlükonak"]))
        countries.append(Country(country: "Tekirdağ", cities: [ "Çerkezköy", "Çorlu", "Ergene", "Hayrabolu", "Malkara", "Muratlı", "Saray", "Süleymanpaşa", "Kapaklı", "Şarköy", "Marmaraereğlisi"]))
        countries.append(Country(country: "Tokat", cities: [ "Almus", "Artova", "Erbaa", "Niksar", "Reşadiye", "Merkez", "Turhal", "Zile", "Pazar", "Yeşilyurt", "Başçiftlik", "Sulusaray"]))
        countries.append(Country(country: "Trabzon", cities: ["Akçaabat", "Araklı", "Arsin", "Çaykara", "Maçka", "Of", "Ortahisar", "Sürmene", "Tonya", "Vakfıkebir", "Yomra", "Beşikdüzü", "Şalpazarı", "Çarşıbaşı", "Dernekpazarı", "Düzköy", "Hayrat", "Köprübaşı"]))
        countries.append(Country(country: "Tunceli", cities: ["Çemişgezek", "Hozat", "Mazgirt", "Nazımiye", "Ovacık", "Pertek", "Pülümür", "Merkez"]))
        countries.append(Country(country: "Şanlıurfa", cities: ["Akçakale", "Birecik", "Bozova", "Ceylanpınar", "Eyyübiye", "Halfeti", "Haliliye", "Hilvan", "Karaköprü", "Siverek", "Suruç", "Viranşehir", "Harran"]))
        countries.append(Country(country: "Uşak", cities: ["Banaz", "Eşme", "Karahallı", "Sivaslı", "Ulubey", "Merkez"]))
        countries.append(Country(country:  "Van", cities: ["Başkale", "Çatak", "Erciş", "Gevaş", "Gürpınar", "İpekyolu", "Muradiye", "Özalp", "Tuşba", "Bahçesaray", "Çaldıran", "Edremit", "Saray"]))
        countries.append(Country(country: "Yalova", cities: [ "Merkez", "Altınova", "Armutlu", "Çınarcık", "Çiftlikköy", "Termal"]))
        countries.append(Country(country: "Yozgat", cities: ["Akdağmadeni", "Boğazlıyan", "Çayıralan", "Çekerek", "Sarıkaya", "Sorgun", "Şefaatli", "Yerköy", "Merkez", "Aydıncık", "Çandır", "Kadışehri", "Saraykent", "Yenifakılı"]))
        countries.append(Country(country:  "Zonguldak", cities: ["Çaycuma", "Devrek", "Ereğli", "Merkez", "Alaplı", "Gökçebey"]))
    }
    
    
    
        
    var verification_id : String? = nil
    var currentphonenumber = ""
    
    //MARK: DataBase button dogrula kontroller
    @objc func btnDogrulaa() {
        self.activityIndicator.startAnimating()
        if phoneNumberControl == 0{ //numara giliriyor
            
            if(self.lineTextField.text == ""){
                self.makeAlert(tittle: "Error", message: "Lütfen numaranizi giriniz")
                self.activityIndicator.stopAnimating()
                return
            }
            
            currentphonenumber = "+90\(String(lineTextField.text!))"
            
            Auth.auth().settings?.isAppVerificationDisabledForTesting = false
            PhoneAuthProvider.provider().verifyPhoneNumber(
                currentphonenumber,
                uiDelegate: nil,
                completion: {verificationID,error in
            if(error != nil){
                //kod gelmedi ise
                self.activityIndicator.stopAnimating()
                self.phoneNumberControl = 0
                //self.makeAlert(tittle: "Error", message: "Onay kodu gonderilemedi")
                self.makeAlert(tittle: "Error", message: error?.localizedDescription ?? "")
                return
            }else{
                //kod geldi ise
                self.activityIndicator.stopAnimating()
                self.phoneNumberControl = 1
                self.btnDogrula.setTitle("Doğrula", for: UIControl.State.normal) //button basligini degistir
                self.lineTextField.placeholder = "onay kodunu giriniz" //line text chance
                self.lineTextField.text = "" //line text girilen texti sil
                self.verification_id = verificationID //onay kodunu al
                self.makeAlert(tittle: "Error", message: "Lütfen gonderdiğimiz onay kodunu giriniz")
            }
            })
            
        }else if phoneNumberControl == 1{ //onay kodu giriliyor
            
            if(self.lineTextField.text == ""){                          self.makeAlert(tittle: "Error", message: "Lutfen dogrulama kodunu giriniz")
               return
            }

            let currentverificationid = String(lineTextField.text!)
            
            if(verification_id != nil) {
                
                        
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification_id!, verificationCode: currentverificationid)
                
                Auth.auth().currentUser!.link(with: credential,completion: {authData, error in
                    if(error != nil){ //kod dogru degil ise
                        self.activityIndicator.stopAnimating()
                        self.makeAlert(tittle: "Error", message: "Onaylanma zamani hata olustu:\(error.debugDescription)")
                    }else{ //kod dogru ise
                        self.activityIndicator.stopAnimating()
                        self.makeAlert(tittle: "Basarili", message: "Onaylanma basarili")
                        
                        self.savenumbertoDB()
                    }
                    
                })
                
            }else{
                self.activityIndicator.stopAnimating()
                self.makeAlert(tittle: "Error", message: "Onay kodunu alinamadi")
            }
            
        }
        
        
    }
        
    func savenumbertoDB() {
        
        //database kullanici kayit guncellenme
               var firebaseusermap = [String : Any]()
                     
               let userID = Auth.auth().currentUser!.uid

               firebaseusermap["phonenumber"] = currentphonenumber
               
        //database kayit etme
        let ref = Database.database().reference()
        ref.child("user").child(userID).updateChildValues(firebaseusermap)
                             { (err, resp) in
                                 guard err == nil else {
                                     print("Posting failed : ")
                                     return
                                     }

                                self.numberControl()
                                
                                
               
               }
        
    }
    
//MARK: DataBase tamamla kontroller
    @objc func btnTamamlaa() {
        
        self.activityIndicator.startAnimating()
        let acikadres = lineTextField1.text
        
        
        if(acikadres == ""){
            makeAlert(tittle: "Error", message: "Lutfen acik adresinizi giriniz")
            self.activityIndicator.stopAnimating()
            return
        }
        if(city == ""){
            makeAlert(tittle: "Error", message: "Lutfen il seciniz")
            self.activityIndicator.stopAnimating()
            return
        }
        if(country == ""){
            makeAlert(tittle: "Error", message: "Lutfen ilce seciniz")
            self.activityIndicator.stopAnimating()
            return
        }
        if(locationcontrol == false){
           makeAlert(tittle: "Error", message: "Lutfen konumunuzu belirleyin")
            self.activityIndicator.stopAnimating()
           return
        }
        if(numbercontrol == false){
           makeAlert(tittle: "Error", message: "Lutfen telefon numaranizi dogrulayin")
            self.activityIndicator.stopAnimating()
           return
        }
        
    
        //database kullanici kayit guncellenme
        var firebaseusermap = [String : Any]()
              
        let userID = Auth.auth().currentUser!.uid

        firebaseusermap["accountcomplete"] = "true"
        firebaseusermap["sehir"] = "\(country)"
        firebaseusermap["il"] = "\(city)"
        firebaseusermap["acikadres"] = "\(acikadres!)"
        firebaseusermap["latitude"] = Double(latitude)!
        firebaseusermap["longitude"] = Double(longutide)!
        //HE FSYO BASAG YAYINLAMAGA BUNUDA SWINIDE heresinde duzeldeceyim bir ikisi qisa sey var olurai duzeldim atiram bi r bir YAXSI YETIM BABAT ISDEDIY BUGUN SENOL :D :D he gorashdi gotum yapibse bura ala bide ne edeyeceydim ses ataram YAXSI MENDE FIRLANAN STOL AVR QAQAN KAYFDADI ala menim kod yazdigim veziiyeti goresen evde ograshdi icin sikimde :D :D MEN SENE SEKIL ATACAM INDI QAQA`N DIVIJ VEZIYET QURUP BURDA DAVAYDA YETIM MACI CIXIRAM MEN YAYINLIYGAG TEZ ABZA opeyremmm
        //database kayit etme
        let ref = Database.database().reference()
        ref.child("user").child(userID).updateChildValues(firebaseusermap)
                      { (err, resp) in
                          guard err == nil else {
                              print("Posting failed : ")
                              return
                              }
            
                          
        let splash = SplahView()
        self.present(splash, animated: true, completion: nil)
                        self.activityIndicator.stopAnimating()
        
        }

        
    }
    
    @objc func hideKeyboard() {
           view.endEditing(true)
       }
    
    @objc func btnKonumBelirlee() {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let lastLocation : CLLocation = locations[locations.count-1]
           print("Latitude\(String(format: "%.6f",lastLocation.coordinate.latitude))")
            print("Longitude\(String(format: "%.6f",lastLocation.coordinate.longitude))")
          }
          locationcontrol = true
        btnKonumBelirle.setTitle("Konum belirlendi",for: UIControl.State.normal)
        
        

    }
    
    @objc func buttonCikYap() {
        print("cikis")
        do {
                   try Auth.auth().signOut()
                   let login = Login()
                   login.modalPresentationStyle = .fullScreen
                   UIApplication.topViewController()?.present(login, animated: true, completion: nil)
                   
                   
               } catch {
                   print("error")
               }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return countries.count
        }else{
            let selectedCountry = pickerView.selectedRow(inComponent: 0)
            return countries[selectedCountry].cities.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return countries[row].country
        }else{
            let selectedCountry = pickerView.selectedRow(inComponent: 0)
            return countries[selectedCountry].cities[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
        
        let selectedConutry = pickerView.selectedRow(inComponent: 0)
        let selectedCity = pickerView.selectedRow(inComponent: 1)
        country = countries[selectedConutry].country
        city = countries[selectedConutry].cities[selectedCity]
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        
        if component == 0 {
            attributedString = NSAttributedString(string: countries[row].country, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            
        }else{
            let selectedCountry = pickerView.selectedRow(inComponent: 0)
            attributedString = NSAttributedString(string: countries[selectedCountry].cities[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            
            
        }
        
        return attributedString
    }
    
    
        
    
    
    
   
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               let lastLocation : CLLocation = locations[locations.count-1]
              latitude = String(format: "%.6f",lastLocation.coordinate.latitude)
        longutide = String(format: "%.6f",lastLocation.coordinate.longitude)
             }
    
  func makeAlert(tittle: String, message : String) {
         let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
         let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
         alert.addAction(okButton)
         self.present(alert, animated: true, completion: nil)
         
     }
        
        
    func numberControl(){
     
        let userID = Auth.auth().currentUser?.uid
           
        let userRef = Database.database().reference().child("user").child(userID!)
                       
               userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                 // Get user value
                 let value = snapshot.value as? NSDictionary
                 let phonenumber = value?["phonenumber"] as? String ?? ""
                       
                if(phonenumber == ""){ //numara dogrulanmamaissa
                    self.lineTextField.isHidden = false
                    self.btnDogrula.isHidden = false
                    self.lbldogrulama.text = "Telefon numarasi dogrulama"
                    self.numbercontrol = false
                    
                }else{ //numara dogrulanmissa
                    self.lineTextField.isHidden = true
                    self.btnDogrula.isHidden = true
                    self.lbldogrulama.text = "Telefon numarasi dogrulandi"
                    self.numbercontrol = true
                    
                   
                }
                 
                                   
                 }) { (error) in
                   print(error.localizedDescription)
               }
               
        
    }
    

}


