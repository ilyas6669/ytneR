//
//  UrunEkleSon.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/7/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class UrunEkleSon: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var activt = UIActivityIndicatorView()
    
    var test : Any = ""
    var anchor : AnchorConstraintss!
    
    //String
    var usersehir = ""
    var userlatitude = 0.0
    var userlongitude = 0.0
    
    
    //PickerView
    var pickerView = UIPickerView() //Category1
    var pickerView2 = UIPickerView() //Category2
    var pickerView3 = UIPickerView() //Category3
    
    //Array
    var firstcategory : [String] = []
    var secondcategory : [String] = []
    var thirdcategory : [String] = []
    
    // Bundle
    var imageArray : [UIImage] = []
    var itemcategory = ""
    
    var firebaseitemmap = [String : Any]()
    
    //Int
    var photocounterI = 0

    //String
    var selectedcategory1 = ""
    var selectedcategory2 = ""
    
    let kamp = ["Çadır","Hamak","Lamba","Tulum","Sandalye","Masa","Mat","Şişme Yatak","Mangal","Termos","Diğer"]
    let sismeYatakKacKisilik = ["Tek","Çift Kişilik","Diğer"]
    
    let kutuOyunları = ["Monopoly","Tabu","Scrabble","Twister","Trivial Pursuit","Risk","Catan","Cranium","Diğer"]
    
    let elektronik = ["Laptop","Tablet","Cep Telefonu","Hoparlör","Projeksiyon","Drone","Televizyon","Playstation","Joystick","Diğer"]
    let cepTelefonu = ["Tuşlu","Akıllı"]
    
    let spor = ["Kaleci Eldiveni","Basketbol Topu","Tenis Topu","Tenis Raketi","Voleybol Topu","Fitness Topu","Atlama İpi","Yoga Matı","Masa Tenis Raketi","Pinpon Topu","Ağırlık"]
    
    let enstruman = ["Gitar","Yaylılar","Üflemeliler","Diğer"]
    let gitarModel = ["Elektro","Bas","Klasik","Akustik","Ukulele"]
    let yaylilar = ["Keman","Viyola","Çello"]
    let uflemeliler = ["Yan flüt","Trompet","Trombon","Mızıka","Klarnet"]
    
    let tamir = ["Matkap","Çekiç","Pense","Tornavida","İngiliz Anahtarı","Boru Anahtarı","Silikon Tabancası","Diğer"]
    
    let kiyafet = ["Abiye","Elbise","Takım Elbise","Etek","Ceket","Ayakkabı","Diğer"]
    
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
     lazy var contentViewSize2 = CGSize(width: self.view.frame.width, height: self.view.frame.height+350)
    
    lazy var scrolView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        view.frame.size = contentViewSize
        return view
    }()
    
    let imgFotorafekle = UIImageView(image: #imageLiteral(resourceName: "lineurunekle3"))
    
    let lblFotorafEkle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Bilgi Ekle"
        lbl.textColor = .white
        return lbl
    }()
    
    let urunField : UITextField = {
        
        let cityField = UITextField()
        cityField.attributedPlaceholder = NSAttributedString(string: "Hangi Çeşit?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        cityField.textColor = .black
        cityField.textAlignment = .center
        cityField.backgroundColor = .white
        cityField.layer.cornerRadius = 15
        cityField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return cityField
    }()
    
    let urunField2 : UITextField = {
        
        let cityField = UITextField()
        cityField.placeholder = ""
        cityField.textColor = .black
        cityField.textAlignment = .center
        cityField.backgroundColor = .white
        cityField.layer.cornerRadius = 15
        cityField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        //cityField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return cityField
    }()
    
    let urunField3 : UITextField = {
        let cityField = UITextField()
        cityField.placeholder = ""
        cityField.textColor = .black
        cityField.textAlignment = .center
        cityField.backgroundColor = .white
        cityField.layer.cornerRadius = 15
        cityField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return cityField
    }()
    
    
    let imgDown = UIImageView(image: #imageLiteral(resourceName: "down-arrow-4"))
    
    
    //MARK: imgler
    let imgCesit:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "ic_ekle_white"))
        image.heightAnchor.constraint(equalToConstant: 32).isActive = true
        image.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return image
    }()
    
    let imgCesit2:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "ic_ekle_white"))
        image.heightAnchor.constraint(equalToConstant: 32).isActive = true
        image.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return image
    }()
    
    let imgCesit3:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "ic_ekle_white"))
        image.heightAnchor.constraint(equalToConstant: 32).isActive = true
        image.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return image
    }()
    
    //MARK: Labeller
    let lblCesit: UILabel = {
        let lbl = UILabel()
        lbl.text = "Çeşit"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblKacKisilik: UILabel = {
        let lbl = UILabel()
        lbl.text = " Kaç Kişilik:"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblKisiSayisi: UILabel = {
        let lbl = UILabel()
        lbl.text = " Kişi Sayısı:"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblModel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Model:"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblBeden: UILabel = {
        let lbl = UILabel()
        lbl.text = "Beden"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblCinsiyyet1: UILabel = {
        let lbl = UILabel()
        lbl.text = "Cinsiyyet"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblNumara: UILabel = {
        let lbl = UILabel()
        lbl.text = "Numara"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblCinsiyyet2: UILabel = {
        let lbl = UILabel()
        lbl.text = "Cinsiyyet"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    
    let viewYasil1: UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.layer.cornerRadius = 26
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let lblBaslik : UILabel = {
        let lbl = UILabel()
        lbl.text = "*Başlık"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let imgPen: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "pen"))
        return img
    }()
    
    
    let txtView1:UITextView = {
        let text = UITextView()
        text.heightAnchor.constraint(equalToConstant: 90).isActive = true
        text.layer.cornerRadius = 26
        text.textColor = .black
        text.backgroundColor = .white
        text.font = UIFont.systemFont(ofSize: 19)
        return text
    }()
    
    let viewYasil2: UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.layer.cornerRadius = 26
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    let lblAciklama : UILabel = {
        let lbl = UILabel()
        lbl.text = "*Açıklama"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let imgPress: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "press"))
        return img
    }()
    
    let txtView2:UITextView = {
        let text = UITextView()
        text.heightAnchor.constraint(equalToConstant: 130).isActive = true
        text.layer.cornerRadius = 26
        text.font = UIFont.systemFont(ofSize: 19)
        text.textColor = .black
        text.backgroundColor = .white
        return text
    }()
    let viewYasil3:UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.layer.cornerRadius = 26
        view.heightAnchor.constraint(equalToConstant: 110).isActive = true
        return view
    }()
    
    let imgLira: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "ic_lira_white"))
        return img
        
    }()
    
    let lblFiyat : UILabel = {
        let lbl = UILabel()
        lbl.text = "Fiyat:"
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.textColor = .white
        return lbl
    }()
    
    let txtLineFiyat : SkyFloatingLabelTextField = {
        let txt = SkyFloatingLabelTextField()
        txt.placeholder = "1 günlük kiralama fiyatı"
        txt.keyboardType = UIKeyboardType.decimalPad
        txt.tintColor = .lightGray
        txt.selectedTitleColor = .rgb(red: 0, green: 38, blue: 26)
        txt.textColor = .white
        txt.lineHeight = 1.0
        txt.selectedLineHeight = 2.0
        txt.heightAnchor.constraint(equalToConstant: 45).isActive = true
        txt.widthAnchor.constraint(equalToConstant: 220).isActive = true
        return txt
    }()
    
    let txtViewAciklama : UILabel = {
        let txt = UILabel()
        txt.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        txt.text = "Tavsiye edilen 1 günlük kiralama fiyatı ürünün sıfır ücretinin 1/20'si ve 1/30'u arasında olmalıdır"
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.numberOfLines = 4
        txt.textColor = .lightGray
        txt.heightAnchor.constraint(equalToConstant: 55).isActive = true
        txt.widthAnchor.constraint(equalToConstant: 230).isActive = true
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        pickerView.tag = 0
        pickerView2.tag = 1
        pickerView3.tag = 2
        
        getuserdata()
        
        switch itemcategory {
        case "kampmalzemeleri":
            firstcategory = kamp
            urunField.isHidden = false
            imgCesit.isHidden = false
            break
        case "kutuoyunlari":
            firstcategory = kutuOyunları
            urunField.isHidden = false
            imgCesit.isHidden = false
            break
        case "elektronik" :
            firstcategory = elektronik
            urunField.isHidden = false
            imgCesit.isHidden = false
            break
        case "sporekipmani" :
            firstcategory = spor
            urunField.isHidden = false
            imgCesit.isHidden = false
            break
        case "tamiraletleri" :
            firstcategory = tamir
            urunField.isHidden = false
            imgCesit.isHidden = false
            break
        case "kiyafet" :
            firstcategory = kiyafet
            urunField.isHidden = false
            imgCesit.isHidden = false
            break
        case "enstruman" :
            firstcategory = enstruman
            urunField.isHidden = false
            imgCesit.isHidden = false
        case "diger":
            urunField.isHidden = true
            imgCesit.isHidden = true
            //
            break
        case "kitap":
            //
            urunField.isHidden = true
            imgCesit.isHidden = true
            break
        default:
            firstcategory = []
            break
        }
        //MARK: ishidden
        urunField2.isHidden = true
        urunField3.isHidden = true
        imgCesit2.isHidden = true
        lblKisiSayisi.isHidden = true
        lblKacKisilik.isHidden = true
        lblModel.isHidden = true
        lblBeden.isHidden = true
        lblCinsiyyet1.isHidden = true
        imgCesit3.isHidden = true
        lblNumara.isHidden = true
        lblCinsiyyet2.isHidden = true
        
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        //urunlerEkle()
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(pickerViewGizle))
        view.addGestureRecognizer(gestureREcongizer)
        
        
        layoutDuzenle()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        urunField.inputView = pickerView
        urunField2.inputView = pickerView2
        urunField3.inputView = pickerView3
        
        
        
        navigationController?.navigationBar.barTintColor = UIColor.customGreen()
        navigationController?.navigationBar.isTranslucent = false
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "tick-2"), style: .done, target: self, action: #selector(urunEkleAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "left1"), style: .done, target: self, action: #selector(leftAction))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        
        
        
        let logo = UIImage(named: "UrunEkle7")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        scrolView.contentSize = contentViewSize2
        print("show")
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrolView.contentSize = contentViewSize
        print("hide")
    }
    
    
    
    
    func layoutDuzenle() {
        
        let urunfieldSV = UIStackView(arrangedSubviews: [urunField,urunField2,urunField3])
        
        urunfieldSV.spacing = 5
        urunfieldSV.axis = .vertical
        
        activt.style = .large
        activt.color = .black
        
        viewYasil2.addSubview(activt)
        activt.hidesWhenStopped = true
        
        
        //MARK: addsubview
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        containerView.addSubview(imgFotorafekle)
        containerView.addSubview(lblFotorafEkle)
        containerView.addSubview(urunfieldSV)
        //containerView.addSubview(urunField2)
        //containerView.addSubview(urunField3)
        containerView.addSubview(imgDown)
        
        
        containerView.addSubview(imgCesit)
        //        containerView.addSubview(imgCesit2)
        //        containerView.addSubview(imgCesit3)
        //containerView.addSubview(imgCesit3)
        
        
        containerView.addSubview(lblCesit)
        containerView.addSubview(lblKacKisilik)
        containerView.addSubview(lblKisiSayisi)
        containerView.addSubview(lblModel)
        containerView.addSubview(lblBeden)
        containerView.addSubview(lblCinsiyyet1)
        containerView.addSubview(lblNumara)
        containerView.addSubview(lblCinsiyyet2)
        
        
        containerView.addSubview(viewYasil1)
        viewYasil1.addSubview(lblBaslik)
        viewYasil1.addSubview(imgPen)
        containerView.addSubview(txtView1)
        containerView.addSubview(viewYasil2)
        viewYasil2.addSubview(lblAciklama)
        viewYasil2.addSubview(imgPress)
        containerView.addSubview(txtView2)
        containerView.addSubview(viewYasil3)
        viewYasil3.addSubview(imgLira)
        viewYasil3.addSubview(lblFiyat)
        viewYasil3.addSubview(txtLineFiyat)
        viewYasil3.addSubview(txtViewAciklama)
        
        
        //MARK: Constraint
        
        
        imgFotorafekle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        _ = imgFotorafekle.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        _ = lblFotorafEkle.anchor(top: imgFotorafekle.bottomAnchor, bottom: nil, leading: nil, trailing: containerView.trailingAnchor,padding: .init(top: 7, left: 0, bottom: 0, right: 0),boyut: .init(width: 90, height: 22))
        _ = urunfieldSV.anchor(top: lblFotorafEkle.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 30, left: 100, bottom: 0, right: 20))
        //_ = urunField2.anchor(top: urunField.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 10, left: 135, bottom: 10, right: 20),boyut: .init(width: 0, height: 45))
        //_ = urunField3.anchor(top: urunField2.bottomAnchor, bottom: viewYasil1.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 10, left: 135, bottom: 10, right: 20))
        _ = imgDown.anchor(top: urunField.topAnchor, bottom: urunField.bottomAnchor, leading: nil, trailing: containerView.trailingAnchor,padding: .init(top: 15, left: 0, bottom: 15, right: 30))
        
        
        _ = imgCesit.anchor(top: containerView.topAnchor, bottom: nil, leading: nil, trailing: lblCesit.leadingAnchor,padding: .init(top: 113, left: 0, bottom: 0, right: 5))
        
        _ = lblCesit.anchor(top: containerView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil,padding: .init(top: 120, left: 52, bottom: 0, right: 0))
        
        
        _ = lblKacKisilik.anchor(top: lblCesit.bottomAnchor, bottom: nil, leading: nil, trailing: urunField2.leadingAnchor,padding: .init(top: 23, left: 0, bottom: 0, right: 5))
        _ = lblKisiSayisi.anchor(top: lblCesit.bottomAnchor, bottom: nil, leading: nil, trailing: urunField2.leadingAnchor,padding: .init(top: 23, left: 0, bottom: 0, right: 5))
        _ = lblModel.anchor(top: lblCesit.bottomAnchor, bottom: nil, leading: nil, trailing: urunField2.leadingAnchor,padding: .init(top: 23, left: 0, bottom: 0, right: 5))
        _ = lblBeden.anchor(top: lblCesit.bottomAnchor, bottom: nil, leading: nil, trailing: urunField2.leadingAnchor,padding: .init(top: 23, left: 0, bottom: 0, right: 5))
        _ = lblCinsiyyet1.anchor(top: lblCesit.bottomAnchor, bottom: nil, leading: nil, trailing: urunField2.leadingAnchor,padding: .init(top: 23, left: 0, bottom: 0, right: 5))
        _ = lblNumara.anchor(top: urunField2.bottomAnchor, bottom: nil, leading: nil, trailing: urunField3.leadingAnchor,padding: .init(top: 23, left: 0, bottom: 0, right: 5))
        _ = lblCinsiyyet2.anchor(top: urunField2.bottomAnchor, bottom: nil, leading: nil, trailing: urunField3.leadingAnchor,padding: .init(top: 18, left: 0, bottom: 0, right: 5))
        
        
        //_ = imgCesit2.anchor(top: imgCesit.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil,padding: .init(top: 20, left: 13, bottom: 0, right: 0))
        //_ = imgCesit3.anchor(top: imgCesit2.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil,padding: .init(top: 20, left: 15, bottom: 0, right: 0))
        
        
        anchor = viewYasil1.anchor(top: urunfieldSV.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 5, left: 7, bottom: 0, right: 7))
        //anchor = viewYasil1.anchor(top: urunField.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 80, left: 7, bottom: 0, right: 7))
        //anchor = viewYasil1.anchor(top: urunField.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 120, left: 7, bottom: 0, right: 7))
        
        _ = txtView1.anchor(top: viewYasil1.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        _ = viewYasil2.anchor(top: txtView1.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 17, left: 7, bottom: 0, right: 7))
        _ = txtView2.anchor(top: viewYasil2.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        _ = viewYasil3.anchor(top: txtView2.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 17, left: 5, bottom: 0, right: 5))
        _ = imgLira.anchor(top: viewYasil3.topAnchor, bottom: nil, leading: viewYasil3.leadingAnchor, trailing: nil,padding: .init(top: 7, left: 10, bottom: 0, right: 0))
        _ = lblFiyat.anchor(top: viewYasil3.topAnchor, bottom: nil, leading: imgLira.trailingAnchor, trailing: nil,padding: .init(top: 15, left: 5, bottom: 0, right: 0))
        _ = txtLineFiyat.anchor(top: viewYasil3.topAnchor, bottom: nil, leading: lblFiyat.trailingAnchor, trailing: nil,padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        _ = txtViewAciklama.anchor(top: txtLineFiyat.bottomAnchor, bottom: nil, leading: nil, trailing: viewYasil3.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 5))
        
        lblBaslik.centerXAnchor.constraint(equalTo: viewYasil1.centerXAnchor).isActive = true
        lblBaslik.centerYAnchor.constraint(equalTo: viewYasil1.centerYAnchor).isActive = true
        _ = imgPen.anchor(top: viewYasil1.topAnchor, bottom: nil, leading: nil, trailing: lblBaslik.leadingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 5))
        lblAciklama.centerXAnchor.constraint(equalTo: viewYasil2.centerXAnchor).isActive = true
        lblAciklama.centerYAnchor.constraint(equalTo: viewYasil2.centerYAnchor).isActive = true
        _ = imgPress.anchor(top: viewYasil2.topAnchor, bottom: nil, leading: nil, trailing:
            lblAciklama.leadingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 5))
        
        _ = activt.anchor(top: nil, bottom: txtView1.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 5, left: 40, bottom: 0, right: 40))
        
    }
    
    
    
    @objc func pickerViewGizle() {
        view.endEditing(true)
    }
    
    
    @objc func urunEkleAction() {
        
        let urun1 = urunField.text
        let urun2 = urunField2.text
        let urun3 = urunField3.text
        
        let hashmapbaslik = txtView1.text
        let hashmapaciklama = txtView2.text
        let hashmapfiyat = txtLineFiyat.text
        
        
        if hashmapbaslik == "" || hashmapaciklama == "" || hashmapfiyat == ""
            
        {
            makeAlert(tittle: "Hata", message: "Lutfen tum alanlari doldurunuz.")
            return
        }
        
        if hashmapbaslik!.count > 40 || hashmapaciklama!.count > 500 {
            makeAlert(tittle: "Hata", message: "Baslik harif sayisi 40 dan cok olmamali")
        }
        
        if urunField.isHidden == false{
            if urun1 == "" {
                makeAlert(tittle: "Hata", message: "Lutfen tum alanlari doldurunuz.")
                return
            }
        }
        if urunField2.isHidden == false{
            if urun2 == "" {
                makeAlert(tittle: "Hata", message: "Lutfen tum alanlari doldurunuz.")
                return
            }
        }
        if urunField3.isHidden == false{
            if urun3 == "" {
                makeAlert(tittle: "Hata", message: "Lutfen tum alanlari doldurunuz.")
                return
            }
        }
         
        //Save Image
        saveimage()
        
        
    }
    func saveimage(){
        
        activt.startAnimating()
        //database kayit etme
        let itemid = Database.database().reference().child("item").childByAutoId().key
        
        firebaseitemmap["itemid"] = itemid
        
        //list photo control
        switch imageArray.count {
        case 1:
            firebaseitemmap["photo1"] = "empty"
            firebaseitemmap["photo2"] = "empty"
            firebaseitemmap["photo3"] = "empty"
            break
        case 2:
            firebaseitemmap["photo2"] = "empty"
            firebaseitemmap["photo3"] = "empty"
            break
        case 3:
            firebaseitemmap["photo3"] = "empty"
            break
        case 4:
            break
        default:
            break
        }
        print("Nicatalibli:\(imageArray.count)")
        //save photo and find last photo
//        for i in 0..<imageArray.count {
            
            if photocounterI == imageArray.count-1{ // sonuncu fotograf
                print("Nicatalibli:\(photocounterI)")
                savelastimagetodb(itemid: itemid!,photocounter: "photo\(photocounterI)",photouri:imageArray[photocounterI])
            }else{
                print("Nicatalibli:\(photocounterI)")
                saveimagetodb(itemid: itemid!,photocounter: "photo\(photocounterI)",photouri:imageArray[photocounterI])
            }
            
//        }
        
    }
    func saveimagetodb(itemid:String,photocounter:String,photouri:UIImage){
        
        print("Nicatalibli:Counter:\(photocounter)")
        
        let imagename = "images/\(itemid)/\(photocounter).jpg"
        
        let storageRef = Storage.storage().reference().child("Items").child(imagename)
        
        if let uploadData = photouri.pngData() {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    print("Nicatalibli:Counter:\(photocounter) Error")
                } else { //succesfully
                    storageRef.downloadURL(completion: { (url, error) in
                        
                        let photourl = url?.absoluteString
                        
                        self.firebaseitemmap["\(photocounter)"] = photourl
                        
                        self.photocounterI = self.photocounterI + 1
                        
                        if self.photocounterI == self.imageArray.count-1{ // sonuncu fotograf
                            print("Nicatalibli:\(self.photocounterI)")
                            self.savelastimagetodb(itemid: itemid,photocounter: "photo\(self.photocounterI)",photouri:self.imageArray[self.photocounterI])
                        }else{
                            print("Nicatalibli:\(self.photocounterI)")
                            self.saveimagetodb(itemid: itemid,photocounter: "photo\(self.photocounterI)",photouri:self.imageArray[self.photocounterI])
                        }
                        
                        print("Nicatalibli:Counter:\(photocounter) Success")
                    })
                }
            }
        }
    }
    
    //mence bunun basin buraxmax lazmdi netden tapmax lazmdi niye bu cox uzun uzadida ona gore  bele olurda xiyar netd:eD  axtardim bidene belencinesi cixmadi hec o bilsen niyedi bu sekil saxranit oldu olmadi onlarida kontrol elemesen buda balaca oalcag way amina ala baxdimdalrdada olurduda neyse bratttttt sef baxmisan :D bu qoy ismizi goreyde maurhni xauranurann urann yeni mahni cixarb ona uqlax asram sikimekimi mene ne gijdillag isivqi ugor :D :D  uran deiemm ha dimdixxx uran sikime deyil uran sikdir :D
    func savelastimagetodb(itemid:String,photocounter:String,photouri:UIImage){
        print("Nicatalibli:Counter:\(photocounter)")

        let imagename = "images/\(itemid)/\(photocounter).jpg"
        
        let storageRef = Storage.storage().reference().child("Items").child(imagename)
        
        if let uploadData = photouri.pngData() {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    self.activt.stopAnimating()
                } else { //succesfully
                    self.activt.stopAnimating()
                    storageRef.downloadURL(completion: { (url, error) in
                        
                        let photourl = url?.absoluteString
                        
                        self.firebaseitemmap["\(photocounter)"] = photourl
                        
                        //get data for hashmap
                        let hashmapbaslik   = self.txtView1.text
                        let hashmapaciklama = self.txtView2.text
                        let hashmapfiyat    = self.txtLineFiyat.text
                        
                        let urun1 = self.urunField.text
                        let urun2 = self.urunField2.text
                        let urun3 = self.urunField3.text
                        
                        var kind1 = "empty"; //get first category
                        if(self.urunField.isHidden == false){
                            kind1 = urun1!
                        }
                        
                        var kind2 = "empty"; //get second category
                        if(self.urunField2.isHidden == false){
                            kind2 = urun2!
                        }
                        
                        var kind3 = "empty"; //get thirt category
                        if(self.urunField3.isHidden == false){
                            kind3 = urun3!
                        }
                        
                        let userID = Auth.auth().currentUser?.uid
                        
                        self.firebaseitemmap["publisher"] = userID
                        self.firebaseitemmap["sehir"] = self.usersehir
                        self.firebaseitemmap["category"] = self.itemcategory
                        self.firebaseitemmap["title"] = hashmapbaslik
                        self.firebaseitemmap["description"] = hashmapaciklama
                        self.firebaseitemmap["kind1"] = kind1
                        self.firebaseitemmap["kind2"] = kind2
                        self.firebaseitemmap["kind3"] = kind3
                        self.firebaseitemmap["pricestr"] = hashmapfiyat
                        self.firebaseitemmap["pricesrtrint"] = Int(hashmapfiyat!)!
                        self.firebaseitemmap["itempublishtime"] = self.signupdateint()
                        self.firebaseitemmap["itempublish"] = true
                        self.firebaseitemmap["itemrate"] = "0.0"
                        self.firebaseitemmap["latitude"] = Double(self.userlatitude)
                        self.firebaseitemmap["longitude"] = Double(self.userlongitude)
                        
                        //database kayit etme
                        let ref = Database.database().reference()
                        ref.child("items").child(itemid).setValue(self.firebaseitemmap)
                        { (err, resp) in
                            guard err == nil else {
                                print("Posting failed : ")
                                //self.actIndicator.hidesWhenStopped = true
                                self.activt.stopAnimating()
                                return
                            }
                            //MARK: gonder
                            //                    self.dismiss(animated: true, completion: nil)
                            //sayfani temizle
                            
                            self.urunField.text = ""
                            self.urunField2.text = ""
                            self.urunField3.text = ""
                            self.txtView1.text = ""
                            self.txtView2.text = ""
                            self.txtLineFiyat.text = ""
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
                            vc.selectedIndex = 2
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                            self.activt.stopAnimating()
                              self.makeAlertt(tittle: "Başarılı", message: "Ürününüz sepete eklendi")
                        }
                        
                        
                        
                    })
                }
            }
        }
    }
    
    func makeAlert(tittle: String, message : String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func leftAction() {
        //MARK: gerii
        //        print("test")
        //
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "segue") as! FotorafEkle1
        //        let navi = UINavigationController(rootViewController: vc)
        //        //navi.modalPresentationStyle = .fullScreen
        //        self.present(navi, animated: true, completion: nil)
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
//        vc.selectedIndex = 2
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    func signupdateint() -> Int {
        //    20200101
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let result = formatter.string(from: date)
        return Int(result)!
    }
    
    //Category Function
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1{
            return secondcategory.count
        }else if pickerView.tag == 2{
            return thirdcategory.count
        }else{
            return firstcategory.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1{
            return secondcategory[row]
        }else if pickerView.tag == 2{
            return thirdcategory[row]
        }else{
            return firstcategory[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if pickerView.tag == 1{ //category 2
            urunField2.text = secondcategory[row]
            urunField2.resignFirstResponder()
            
            selectedcategory2 = secondcategory[row]
            getcategory3()
            
        }else if pickerView.tag == 2{
            urunField3.text = thirdcategory[row]
            urunField3.resignFirstResponder()
        }
        else{ //category 1
            urunField.text = firstcategory[row]
            urunField.resignFirstResponder()
            
            selectedcategory1 = firstcategory[row]
            getcategory2() //set category2
            
        }
        
        
    }
    //MARK: Controller
    func getcategory3(){
        
        switch selectedcategory1 {
        case "Ceket":
            
            switch selectedcategory2 {
            case "Xsmall":
                urunField3.isHidden = false
                thirdcategory = ["Erkek","Kadın"]
                lblCinsiyyet2.isHidden = false
                imgCesit3.isHidden = false
                lblNumara.isHidden = true
                break
            case "Small":
                urunField3.isHidden = false
                thirdcategory = ["Erkek","Kadın"]
                lblCinsiyyet2.isHidden = false
                imgCesit3.isHidden = false
                lblNumara.isHidden = true
                break
            case "Medium":
                urunField3.isHidden = false
                thirdcategory = ["Erkek","Kadın"]
                lblCinsiyyet2.isHidden = false
                imgCesit3.isHidden = false
                lblNumara.isHidden = true
                break
            case "Large":
                urunField3.isHidden = false
                thirdcategory = ["Erkek","Kadın"]
                lblCinsiyyet2.isHidden = false
                imgCesit3.isHidden = false
                lblNumara.isHidden = true
                break
            case "Ceket":
                urunField3.isHidden = false
                thirdcategory = ["Erkek","Kadın"]
                lblCinsiyyet2.isHidden = false
                imgCesit3.isHidden = false
                lblNumara.isHidden = true
                break
            case "Xlarge":
                urunField3.isHidden = false
                thirdcategory = ["Erkek","Kadın"]
                lblCinsiyyet2.isHidden = false
                imgCesit3.isHidden = false
                lblNumara.isHidden = true
                break
            default:
                urunField3.isHidden = true
                thirdcategory = [""]
                urunField3.text = ""
                lblCinsiyyet2.isHidden = true
                imgCesit3.isHidden = true
                lblNumara.isHidden = true
                break
            }
            
            break
        case "Ayakkabı":
            
            switch selectedcategory2 {
            case "Erkek":
                urunField3.isHidden = false
                thirdcategory = ["35","36","37","38","39","40","41","42","43","44","45","46","47"]
                lblNumara.isHidden = false
                imgCesit3.isHidden = false
                lblCinsiyyet2.isHidden = true
                break
            case "Kadın":
                urunField3.isHidden = false
                thirdcategory = ["35","36","37","38","39","40","41","42","43","44","45","46","47"]
                lblNumara.isHidden = false
                imgCesit3.isHidden = false
                lblCinsiyyet2.isHidden = true
                break
            default:
                urunField3.isHidden = true
                thirdcategory = [""]
                urunField3.text = ""
                imgCesit3.isHidden = true
                lblNumara.isHidden = true
                lblCinsiyyet2.isHidden = true
                break
            }
            
            break
        default:
            urunField3.isHidden = true
            thirdcategory = [""]
            urunField3.text = ""
            imgCesit3.isHidden = true
            lblNumara.isHidden = true
            lblCinsiyyet2.isHidden = true
            break
        }
        
    }
    
    func getuserdata(){
        
        let userID = Auth.auth().currentUser?.uid
        
        let userRef = Database.database().reference().child("user").child(userID!)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            self.usersehir = value?["sehir"] as? String ?? ""
            self.userlatitude = value?["latitude"] as? Double ?? 0.0
            self.userlongitude = value?["latitude"] as? Double ?? 0.0
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
        
    }
    
    //MARK:Kontroler Baslanqic
    func getcategory2(){
        
        switch itemcategory {
        case "kampmalzemeleri":
            
            switch selectedcategory1 {
            case "Çadır":
                secondcategory = ["Tek Kişilik","Çift Kişilik","Üç Kişilik","Diğer"]
                urunField2.isHidden = false
                imgCesit2.isHidden = false
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = false
                
                break
            case "Hamak" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = true
                
                break
            case "Lamba":
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = true
                
                break
            case "Tulum" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = true
                
                break
            case "Sandalye" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = true
                
                break
            case "Masa" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = true
                
                break
            case "Mat" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = true
                
                break
            case "Şişme Yatak" :
                secondcategory = ["Tek","Çift Kişilik","Diğer"]
                urunField2.isHidden = false
                imgCesit2.isHidden = false
                lblKisiSayisi.isHidden = false
                lblKacKisilik.isHidden = true
                
                break
            case "Mangal" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = true
                
                break
            case "Termos" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = true
                
                break
            case "Diğer" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblKisiSayisi.isHidden = true
                lblKacKisilik.isHidden = true
                
                break
            default:
                
                break
            }
            break
        case "kutuoyunlari":
            switch selectedcategory1 {
            case "Monopoly":
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Tabu" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Scrabble" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Twister":
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Trivial Pursuit":
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Risk" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Catan" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Cranium":
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Diğer" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            default:
                urunField2.isHidden = true
                urunField2.text = ""
                break
            }
            break
        case "elektronik" :
            switch selectedcategory1 {
            case "Laptop":
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblModel.isHidden = true
                break
            case "Tablet" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblModel.isHidden = true
                break
            case "Cep Telefonu" :
                secondcategory = ["Tuşlu","Akıllı"]
                urunField2.isHidden = false
                imgCesit2.isHidden = false
                lblModel.isHidden = false
                break
            case "Hoparlör":
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblModel.isHidden = true
                break
            case "Projeksiyon" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblModel.isHidden = true
                break
            case "Drone" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblModel.isHidden = true
                break
            case "Televizyon" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblModel.isHidden = true
                break
            case "Playstation" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblModel.isHidden = true
                break
            case "Joystick" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblModel.isHidden = true
                break
            case "Diğer" :
                urunField2.isHidden = true
                urunField2.text = ""
                imgCesit2.isHidden = true
                lblModel.isHidden = true
                break
            default:
                break
            }
            break
        case "sporekipmani" :
            switch selectedcategory1 {
            case "Kaleci Eldiveni":
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Basketbol Topu" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Tenis Topu" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Tenis Raketi" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Voleybol Topu" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Fitness Topu" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Atlama İpi" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Yoga Matı":
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Masa Tenis Raketi" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Pinpon Topu" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Ağırlık" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            default:
                break
            }
            break
        case "tamiraletleri" :
            switch selectedcategory1 {
            case "Matkap":
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Çekiç" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Pense" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Tornavida" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "İngiliz Anahtarı" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Boru Anahtarı" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Silikon Tabancası":
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Masa Tenis Raketi" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            case "Diğer" :
                urunField2.isHidden = true
                urunField2.text = ""
                break
            default:
                break
            }
            break
        //MARK: control kiyafet
        case "kiyafet" :
            switch selectedcategory1 {
            case "Abiye":
                secondcategory = ["Xsmall","Small","Medium","Large","Ceket","Xlarge"]
                urunField2.isHidden = false
                urunField3.isHidden = true
                urunField3.text = ""
                lblBeden.isHidden = false
                imgCesit2.isHidden = false
                lblCinsiyyet1.isHidden = true
                imgCesit3.isHidden = true
                lblCinsiyyet2.isHidden = true
                lblNumara.isHidden = true
                break
            case "Elbise" :
                secondcategory = ["Xsmall","Small","Medium","Large","Ceket","Xlarge"]
                urunField2.isHidden = false
                urunField3.isHidden = true
                urunField3.text = ""
                lblBeden.isHidden = false
                imgCesit2.isHidden = false
                lblCinsiyyet1.isHidden = true
                imgCesit3.isHidden = true
                lblCinsiyyet2.isHidden = true
                lblNumara.isHidden = true
                break
            case "Takım Elbise":
                secondcategory = ["Xsmall","Small","Medium","Large","Ceket","Xlarge"]
                urunField2.isHidden = false
                urunField3.isHidden = true
                urunField3.text = ""
                lblBeden.isHidden = false
                imgCesit2.isHidden = false
                lblCinsiyyet1.isHidden = true
                imgCesit3.isHidden = true
                lblCinsiyyet2.isHidden = true
                lblNumara.isHidden = true
                break
            case "Etek" :
                secondcategory = ["Xsmall","Small","Medium","Large","Ceket","Xlarge"]
                urunField2.isHidden = false
                urunField3.isHidden = true
                urunField3.text = ""
                lblBeden.isHidden = false
                imgCesit2.isHidden = false
                lblCinsiyyet1.isHidden = true
                imgCesit3.isHidden = true
                lblCinsiyyet2.isHidden = true
                lblNumara.isHidden = true
                break
            case "Ceket" :
                secondcategory = ["Xsmall","Small","Medium","Large","Ceket","Xlarge"]
                urunField2.isHidden = false
                urunField3.isHidden = true
                urunField3.text = ""
                lblBeden.isHidden = false
                imgCesit2.isHidden = false
                lblCinsiyyet1.isHidden = true
                imgCesit3.isHidden = true
                lblCinsiyyet2.isHidden = true
                lblNumara.isHidden = true
                break
            case "Ayakkabı" :
                secondcategory = ["Erkek","Kadın"]
                urunField2.isHidden = false
                urunField3.isHidden = true
                urunField3.text = ""
                lblBeden.isHidden = true
                imgCesit2.isHidden = false
                lblCinsiyyet1.isHidden = false
                imgCesit3.isHidden = true
                lblCinsiyyet2.isHidden = true
                lblNumara.isHidden = true
                break
            case "Diğer" :
                urunField2.isHidden = true
                urunField2.text = ""
                urunField3.isHidden = true
                urunField3.text = ""
                lblBeden.isHidden = true
                imgCesit2.isHidden = true
                lblCinsiyyet1.isHidden = true
                imgCesit3.isHidden = true
                lblCinsiyyet2.isHidden = true
                lblNumara.isHidden = true
                break
            default:
                break
            }
            break
        case "enstruman" :
            switch selectedcategory1 {
            case "Gitar":
                secondcategory = ["Elektro","Bas","Klasik","Akustik","Ukulele"]
                urunField2.isHidden = false
                lblModel.isHidden = false
                imgCesit2.isHidden = false
                break
            case "Yaylılar":
                secondcategory = ["Keman","Viyola","Çello"]
                urunField2.isHidden = false
                lblModel.isHidden = false
                imgCesit2.isHidden = false
                break
            case "Üflemeliler":
                secondcategory = ["Yan flüt","Trompet","Trombon","Mızıka","Klarnet"]
                urunField2.isHidden = false
                lblModel.isHidden = false
                imgCesit2.isHidden = false
                break
            case "Diğer":
                urunField2.isHidden = true
                urunField2.text = ""
                lblModel.isHidden = true
                imgCesit2.isHidden = true
                break
            default:
                break
            }
            break
        default:
            break
        }
        
    }
    
}



