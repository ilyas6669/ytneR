//
//  Filtrele.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/25/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import RangeSeekSlider
import Firebase

class Filtrele: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource  {
    
    
    
    let data = ["data","data1","data2"]
    
    var firstdate = ""
    var enddate = ""
    
    let btnLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "left1"), for: .normal)
        btn.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        return btn
    }()
    
    @IBOutlet weak var btnOkeyy: UIButton!
    
   
    
    let imgFiltirele : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "adjust"))
        return img
    }()
    
    
    let lblFiltrirele : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.text = "Filtrele"
        return lbl
        
    }()
    
    let imgFiyatAraligi : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "ic_tag_white"))
        img.heightAnchor.constraint(equalToConstant: 24).isActive = true
        img.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return img
    }()
    
    let lblFiyatAraligi : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.text = "Fiyat Aralığı"
        return lbl
    }()
    
    
    //MARK: imgCesit
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
    
    //MARK: labeller
    let lblCesit: UILabel = {
        let lbl = UILabel()
        lbl.text = "Çeşit:"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblKacKisilik: UILabel = {
        let lbl = UILabel()
        lbl.text = "Kaç Kişilik:"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblKisiSayisi: UILabel = {
        let lbl = UILabel()
        lbl.text = "Kişi Sayısı:"
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
        lbl.text = "Beden:"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblCinsiyyet1: UILabel = {
        let lbl = UILabel()
        lbl.text = "Cinsiyyet:"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblNumara: UILabel = {
        let lbl = UILabel()
        lbl.text = "Numara:"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let lblCinsiyyet2: UILabel = {
        let lbl = UILabel()
        lbl.text = "Cinsiyet:"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    
    //urunField
    let urunField : UITextField = {
        
        let cityField = UITextField()
        cityField.attributedPlaceholder = NSAttributedString(string: "Hangi Çeşit?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        cityField.textColor = .black
        cityField.textAlignment = .center
        cityField.backgroundColor = .white
        cityField.layer.cornerRadius = 10
        cityField.translatesAutoresizingMaskIntoConstraints = false
        cityField.heightAnchor.constraint(equalToConstant: 38).isActive = true
        cityField.widthAnchor.constraint(equalToConstant: 230).isActive = true
        return cityField
    }()
    
    let urunField2 : UITextField = {
        
        let cityField = UITextField()
        cityField.attributedPlaceholder = NSAttributedString(string: "Hangi Çeşit?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        cityField.textColor = .black
        cityField.textAlignment = .center
        cityField.backgroundColor = .white
        cityField.layer.cornerRadius = 10
        cityField.heightAnchor.constraint(equalToConstant: 38).isActive = true
        cityField.widthAnchor.constraint(equalToConstant: 230).isActive = true
        return cityField
    }()
    
    let urunField3 : UITextField = {
        let cityField = UITextField()
        cityField.attributedPlaceholder = NSAttributedString(string:"Cinsiyet?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        cityField.textColor = .black
        cityField.textAlignment = .center
        cityField.backgroundColor = .white
        cityField.layer.cornerRadius = 10
        cityField.heightAnchor.constraint(equalToConstant: 38).isActive = true
        cityField.widthAnchor.constraint(equalToConstant: 230).isActive = true
        return cityField
    }()
    
    
    //MARK:imgDown
    let imgDown1 = UIImageView(image: #imageLiteral(resourceName: "down-arrow-4"))
    let imgDown2 = UIImageView(image: #imageLiteral(resourceName: "down-arrow-4"))
    let imgDown3 = UIImageView(image: #imageLiteral(resourceName: "down-arrow-4"))
    
    //MARK: pickerVieww
    var pickerView = UIPickerView()
    var pickerView2 = UIPickerView()
    var pickerView3 = UIPickerView()
    
    
    //Array
    var firstcategory : [String] = []
    var secondcategory : [String] = []
    var thirdcategory : [String] = []
    
    // Bundle
    var imageArray : [UIImage] = []
    var itemcategory = ""
    
    var firebaseitemmap = [String : Any]()
    
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
    
    let seekSlider : RangeSeekSlider = {
        let seek = RangeSeekSlider()
        seek.colorBetweenHandles = .rgb(red: 201, green: 213, blue: 51)
        seek.minLabelColor = .white
        seek.maxLabelColor = .white
        seek.maxValue = 200
        seek.selectedMaxValue = 200
        seek.lineHeight = 5
        seek.handleColor = .rgb(red: 201, green: 213, blue: 51)
        seek.handleDiameter = 30
        seek.tintColor = .white
        seek.enableStep = true
        seek.step = 1
        seek.numberFormatter.positiveSuffix = " TL"
        
        return seek
    }()
    
    let imgDate : UIImageView = {
        let date = UIImageView(image: #imageLiteral(resourceName: "calendar1"))
        date.heightAnchor.constraint(equalToConstant: 32).isActive = true
        date.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return date
    }()
    
    let lblDate : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.text = "Tarih Aralığı"
        return lbl
    }()
    
    let txtDate1 : UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string: "--/--/----", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        txt.textColor = .black
        txt.textAlignment = .center
        txt.backgroundColor = .white
        txt.layer.cornerRadius = 10
        txt.heightAnchor.constraint(equalToConstant: 38).isActive = true
        txt.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return txt
    }()
    
    
    let txtDate2 : UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string: "--/--/----", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        txt.textColor = .black
        txt.textAlignment = .center
        txt.backgroundColor = .white
        txt.layer.cornerRadius = 10
        txt.heightAnchor.constraint(equalToConstant: 38).isActive = true
        txt.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return txt
    }()
    
    let dataPicker = UIDatePicker()
    let dataPicker2 = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnOkeyy.setImage(UIImage(named: "tick-2"), for: .normal)
        
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Something Else", style: .plain, target: nil, action: nil)
        print(itemcategory)
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(pickerViewGizle))
        view.addGestureRecognizer(gestureREcongizer)
        
        
        
        dataPicker.datePickerMode = .date
        dataPicker2.datePickerMode = .date
        let localeID = Locale.preferredLanguages.first
        dataPicker.locale = Locale(identifier: localeID!)
        dataPicker2.locale = Locale(identifier: localeID!)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "TAMAM", style: .done, target: self, action: #selector(doneAction))
        
        toolbar.setItems([button], animated: true)
        txtDate1.inputAccessoryView = toolbar
        
        let toolBar2 = UIToolbar()
        toolBar2.sizeToFit()
        let button2 = UIBarButtonItem(title: "TAMAM", style: .done, target: self, action: #selector(doneAction2))
        
        toolBar2.setItems([button2], animated: true)
        txtDate2.inputAccessoryView = toolBar2
        
        //        let kategoriyegoreurun = KategoriyeGoreUrun()
        //        print("YADDAS:\(itemcategory)")
        
        
        
        switch itemcategory {
        case "kampmalzemeleri":
            firstcategory = kamp
            break
        case "kutuoyunlari":
            firstcategory = kutuOyunları
            break
        case "elektronik" :
            firstcategory = elektronik
            break
        case "sporekipmani" :
            firstcategory = spor
            break
        case "tamiraletleri" :
            firstcategory = tamir
            break
        case "kiyafet" :
            firstcategory = kiyafet
            break
        case "enstruman" :
            firstcategory = enstruman
        default:
            firstcategory = []
            break
        }
        
        //MARK: delegate and dataSource
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        //MARK:input View
        urunField.inputView = pickerView
        urunField2.inputView = pickerView2
        urunField3.inputView = pickerView3
        txtDate1.inputView = dataPicker
        txtDate2.inputView = dataPicker2
        
        //MARK: pickerview tag
        pickerView.tag = 0
        pickerView2.tag = 1
        pickerView3.tag = 2
        
        
        
        
        //MARK: Stack View
        let filtreleSV = UIStackView(arrangedSubviews: [imgFiltirele,lblFiltrirele])
        filtreleSV.axis = .horizontal
        filtreleSV.spacing = 5
        filtreleSV.translatesAutoresizingMaskIntoConstraints = false
        
        let fiyatAraligiSV = UIStackView(arrangedSubviews: [imgFiyatAraligi,lblFiyatAraligi])
        fiyatAraligiSV.axis = .horizontal
        fiyatAraligiSV.spacing = 5
        fiyatAraligiSV.translatesAutoresizingMaskIntoConstraints = false
        
        let urunfieldSV = UIStackView(arrangedSubviews: [urunField,urunField2,urunField3])
        
        urunfieldSV.spacing = 5
        urunfieldSV.axis = .vertical
        
        let tarihSV = UIStackView(arrangedSubviews: [imgDate,lblDate])
        tarihSV.axis = .horizontal
        tarihSV.spacing = 5
        
        let txtTarixSV = UIStackView(arrangedSubviews: [txtDate1,txtDate2])
        txtTarixSV.axis = .horizontal
        txtTarixSV.spacing = 15
        txtTarixSV.translatesAutoresizingMaskIntoConstraints = false
        
        
        //MARK: addSubview
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.addSubview(btnLeft)
        
        
        //MARK:addSubview StacView
        view.addSubview(filtreleSV)
        view.addSubview(fiyatAraligiSV)
        //view.addSubview(imgcesitSV)
        view.addSubview(urunfieldSV)
        
        //MARK: imgCesit
        view.addSubview(imgCesit)
        view.addSubview(imgCesit2)
        view.addSubview(imgCesit3)
        
        //MARK:addSubview labeller
        view.addSubview(lblCesit)
        view.addSubview(lblKisiSayisi)
        view.addSubview(lblKacKisilik)
        view.addSubview(lblModel)
        view.addSubview(lblBeden)
        view.addSubview(lblCinsiyyet1)
        view.addSubview(lblNumara)
        view.addSubview(lblCinsiyyet2)
        
        //MARK:addSubview imgDown
        view.addSubview(imgDown1)
        view.addSubview(imgDown2)
        view.addSubview(imgDown3)
        
        //MARK:isHidden
        urunField2.isHidden = true
        urunField3.isHidden = true
        imgCesit2.isHidden = true
        imgCesit3.isHidden = true
        imgDown2.isHidden = true
        imgDown3.isHidden = true
        lblKisiSayisi.isHidden = true
        lblCinsiyyet2.isHidden = true
        lblKacKisilik.isHidden = true
        lblModel.isHidden = true
        lblBeden.isHidden = true
        lblCinsiyyet1.isHidden = true
        lblNumara.isHidden = true
        
        view.addSubview(seekSlider)
        view.addSubview(tarihSV)
        view.addSubview(txtTarixSV)
        
        
        _ = seekSlider.anchor(top: fiyatAraligiSV.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        
        _ = tarihSV.anchor(top: urunfieldSV.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 30, left: 20, bottom: 0, right: 0))
        
        txtTarixSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        txtTarixSV.topAnchor.constraint(equalTo: tarihSV.bottomAnchor,constant: 20).isActive = true
        
        
        
        //MARK:constraint buttonlar
        _ = btnLeft.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 15, left: 10, bottom: 0, right: 0))
        _ = btnOkeyy.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 15, left: 0, bottom: 0, right: 10))
        
        //MARK: cosntraint stack view
        filtreleSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        filtreleSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        _ = fiyatAraligiSV.anchor(top: btnLeft.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 15, left: 20, bottom: 0, right: 0))
        //_ = imgcesitSV.anchor(top: fiyatAraligiSV.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 25, left: 5, bottom: 0, right: 0))
        _ = urunfieldSV.anchor(top: seekSlider.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 20, left: 0, bottom: 0, right: 10))
        
        //MARK:constraint labeller
        _ = lblCesit.anchor(top: seekSlider.bottomAnchor, bottom: nil, leading: nil, trailing: urunField.leadingAnchor,padding: .init(top: 30, left: 5, bottom: 0, right: 5))
        _ = lblKisiSayisi.anchor(top: urunField.bottomAnchor, bottom: nil, leading: imgCesit2.trailingAnchor, trailing: nil,padding: .init(top: 14, left: 5, bottom: 0, right: 0))
        _ = lblKacKisilik.anchor(top: urunField.bottomAnchor, bottom: nil, leading: imgCesit2.trailingAnchor, trailing: nil,padding: .init(top: 14, left: 5, bottom: 0, right: 0))
        _ = lblModel.anchor(top: urunField.bottomAnchor, bottom: nil, leading: imgCesit2.trailingAnchor, trailing: nil,padding: .init(top: 14, left: 5, bottom: 0, right: 0))
        _ = lblBeden.anchor(top: urunField.bottomAnchor, bottom: nil, leading: imgCesit2.trailingAnchor, trailing: nil,padding: .init(top: 14, left: 5, bottom: 0, right: 0))
        _ = lblCinsiyyet1.anchor(top: urunField.bottomAnchor, bottom: nil, leading: imgCesit2.trailingAnchor, trailing: nil,padding: .init(top: 14, left: 5, bottom: 0, right: 0))
        _ = lblNumara.anchor(top: urunField2.bottomAnchor, bottom: nil, leading: imgCesit3.trailingAnchor, trailing: nil,padding: .init(top: 14, left: 5, bottom: 0, right: 0))
        _ = lblCinsiyyet2.anchor(top: urunField2.bottomAnchor, bottom: nil, leading: nil, trailing: urunField3.leadingAnchor,padding: .init(top: 14, left: 0, bottom: 0, right: 5))
        
        //MARK: imgCesit
        _ = imgCesit.anchor(top: seekSlider.bottomAnchor, bottom: nil, leading: nil, trailing: lblCesit.leadingAnchor,padding: .init(top: 20, left: 0, bottom: 0, right: 5))
        _ = imgCesit2.anchor(top: imgCesit.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 10, left: 5, bottom: 0, right: 0))
        _ = imgCesit3.anchor(top: imgCesit2.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 13, left: 20, bottom: 0, right: 0))
        
        
        //MARK:constraint imgDown
        _ = imgDown1.anchor(top: urunField.topAnchor, bottom: urunField.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 10, right: 25))
        _ = imgDown2.anchor(top: urunField2.topAnchor, bottom: urunField2.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 10, right: 25))
        _ = imgDown3.anchor(top: urunField3.topAnchor, bottom: urunField3.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 10, right: 25))
        
        
        
    }
    
    @objc func doneAction() {
        getDateFromPicker()
        view.endEditing(true)
        
    }
    
    @objc func doneAction2() {
        getDateFromPicker2()
    }
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDate1.text = formatter.string(from: dataPicker.date)
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyyMMdd"
        firstdate = formatter2.string(from: dataPicker.date)
    }
    
    func getDateFromPicker2() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDate2.text = formatter.string(from: dataPicker2.date)
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyyMMdd"
        enddate = formatter2.string(from: dataPicker2.date)
        
    }
    
    
    
    @objc func leftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    ///Okeybtn
    @objc func okeyAction() {
        print("okey")
    }
    
    //MARK: Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //var KategoriyeGoreUrun : KategoriyeGoreUrun = segue.destination as! KategoriyeGoreUrun
        let nav = segue.destination as! UINavigationController
        let KategoriyeGoreUrun = nav.topViewController as! KategoriyeGoreUrun
        
        KategoriyeGoreUrun.itemcategory = itemcategory
        KategoriyeGoreUrun.minprice = "\(seekSlider.selectedMinValue)"
        KategoriyeGoreUrun.maxprice = "\(seekSlider.selectedMaxValue)"
        
        
        if firstdate == ""{
            firstdate = "none"
        }
        KategoriyeGoreUrun.firstdate = firstdate
        
        if enddate == ""{
            enddate = "none"
        }
        KategoriyeGoreUrun.enddate = enddate
        
        ///set category
        let urun1 = self.urunField.text
        let urun2 = self.urunField2.text
        let urun3 = self.urunField3.text
                
        var kind1 = "none" //get first category
        if self.urunField.isHidden == false {
            if urun1! != ""{
                kind1 = urun1!
            }
        }
        KategoriyeGoreUrun.cesit1 = kind1
        
        var kind2 = "none" //get second category
        if self.urunField2.isHidden == false {
            if urun2! != ""{
                kind2 = urun2!
            }
        }
        KategoriyeGoreUrun.cesit2 = kind2
        
        var kind3 = "none" //get thirt category
        if self.urunField3.isHidden == false {
            if urun3! != ""{
                
                kind3 = urun3!
            }
        }
        KategoriyeGoreUrun.cesit3 = kind3
        
        KategoriyeGoreUrun.filtrelekeyword = "hasfilter"
        
        
    }
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //        var fotorafekle : KategoriyeGoreUrun = segue.destination as! KategoriyeGoreUrun
    //
    //        fotorafekle.itemcategory = "test"
    //
    //
    //    }
    
    @objc func pickerViewGizle() {
        view.endEditing(true)
    }
    
    
    //    //MARK: Picker View Controller
    //    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    //        return 1
    //    }
    //
    //    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    //        return data.count
    //    }
    //
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return data[row]
    //    }
    //
    //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //        urunField.text = data[row]
    //        urunField.resignFirstResponder()
    //    }
    
    
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










