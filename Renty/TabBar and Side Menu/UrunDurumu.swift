//
//  UrunDurumu.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/27/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

class UrunDurumu: UIViewController {
    
    let navController : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    
    let btnLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "left1"), for: .normal)
        btn.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let lblUrunDurumu : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.text = "Ürün Durumu"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let imgUrunDurumu : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "urundurumu"))
        img.heightAnchor.constraint(equalToConstant: 32).isActive = true
        img.widthAnchor.constraint(equalToConstant: 32).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let profilImage : UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        img.image = UIImage(named: "user1")
        img.backgroundColor = .white
        img.heightAnchor.constraint(equalToConstant: 32).isActive = true
        img.widthAnchor.constraint(equalToConstant: 32).isActive = true
        img.layer.cornerRadius = img.frame.size.height / 2
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.white.cgColor
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblIstek : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        lbl.text = "Nicat Talıblı adlı kullanıcı '07-04-2020' - '16 04 2020' tarihleri arası için rezervasyon isteğinde bulundu"
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblEksik : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.text = "Satıcının eksikleri girmesi bekleniyor.."
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let viewEksik : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 13, green: 165, blue: 72)
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.widthAnchor.constraint(equalToConstant: 270).isActive = true
        return view
    }()
    
    let txtEksikleriGiriniz : OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.textColor = .black
        txt.attributedPlaceholder = NSAttributedString(string: "Lütfen eksikleri giriniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        txt.textAlignment = .left
        txt.adjustsFontSizeToFitWidth = true
        txt.minimumFontSize = 10
        txt.heightAnchor.constraint(equalToConstant: 35).isActive = true
        txt.layer.cornerRadius = 15
        return txt
    }()
    
    let btnKayitOl: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("ONAYLA", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(btnkayitoll), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        btn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return btn
    }()
    
    let viewEksik2 : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 201, green: 213, blue: 51)
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }()
    
    let lblEksik2 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.text = "Eksikler"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let txtView : UITextView = {
        let txt = UITextView()
        txt.textColor = .black
        txt.backgroundColor = .white
        txt.isEditable = false
        txt.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return txt
    }()
    
    let viewOnaylanmasiBekleniyor : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 201, green: 213, blue: 51)
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.widthAnchor.constraint(equalToConstant: 295).isActive = true
        view.roundCorners([.topRight,.bottomRight], radius: 15)
        return view
    }()
    
    let lblOnaylanmasiBekleniyor : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.text = "Alıcının ürünü almasını onaylaması bekleniyor..."
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let btnUrunuAldigimiOnayla : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("ÜRÜNÜ ALDIĞINI ONAYLA", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        btn.backgroundColor = .rgb(red: 13, green: 165, blue: 72)
        btn.addTarget(self, action: #selector(urunAldigimiOnayla), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 153).isActive = true
        return btn
    }()
    
    
    
    let viewSaticininUrunuGeriAlmasiBekleniyor : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 13, green: 165, blue: 72)
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.widthAnchor.constraint(equalToConstant: 275).isActive = true
        view.roundCorners([.topLeft,.bottomLeft], radius: 15)
        return view
    }()
    
    let lblSaticininUrunuGeriAlmasiBekleniyor : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.text = "Satıcının ürünü geri alması bekleniyor.."
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let btnUrunuGeriAldiginiOnayla : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("ÜRÜNÜ GERİ ALDIĞINI ONAYLA", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        btn.backgroundColor = .rgb(red: 201, green: 213, blue: 51)
        btn.addTarget(self, action: #selector(urungeriAldigimiOnayla), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 165).isActive = true
        return btn
    }()
    
    let viewDegerlendirmeninBitmesi  : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 13, green: 165, blue: 72)
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }()
    
    let lblDegerlendirmeninBitmesi : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.text = "Değerlendirmenin bitmesi bekleniyor..."
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblDegerlendirmenNedir : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.backgroundColor = .clear
        lbl.text = "Değerlendirmen nedir?"
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let txtYorumBurak : OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.textColor = .black
        txt.attributedPlaceholder = NSAttributedString(string: "Lütfen eksikleri giriniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        txt.textAlignment = .left
        txt.adjustsFontSizeToFitWidth = true
        txt.minimumFontSize = 10
        txt.heightAnchor.constraint(equalToConstant: 35).isActive = true
        txt.layer.cornerRadius = 15
        return txt
    }()
    
    let btnTamamla: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("TAMAMLA", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(btntamamla), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        btn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return btn
    }()
    
    let viewAlisVerisTamamlandi  : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 13, green: 165, blue: 72)
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }()
    
    let lblAlisVerisTamamlandu : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 3
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.text = "Alışveriş tamamlandı."
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let cosmos1 : CosmosView = {
        let cosmos = CosmosView()
        cosmos.rating = 0
        cosmos.settings.updateOnTouch = true
        cosmos.settings.emptyBorderColor = UIColor.rgb(red: 51, green: 81, blue: 72)
        cosmos.settings.filledColor = UIColor.yellow
        cosmos.settings.starMargin = 0
        cosmos.settings.emptyBorderColor = .white
        return cosmos
    }()
    
    //Tanimlamalar
    ///String
    var buyitemid = ""
    var userrate  = ""
    ///Model
    var buyitem : BuyItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        
        /// itemstatus_satici_eksik_info  -->  lblEksik  viewEksik
        /// itemstatus_satici_eksik_edittext --> txtEksikleriGiriniz
        /// itemstatus_satici_eksik_onayla  --> btnKayitOl
        /// itemstatus_eksikler_rel -->  viewEksik2 lblEksik2 txtView ??? text
        /// itemstatus_alici_urunualdim_info --> viewOnaylanmasiBekleniyor lblOnaylanmasiBekleniyor
        /// itemstatus_alici_urunualdim --> btnUrunuAldigimiOnayla
        /// itemstatus_satici_urunugerialdim_info --> viewSaticininUrunuGeriAlmasiBekleniyor lblSaticininUrunuGeriAlmasiBekleniyor
        /// itemstatus_satici_urunugerialdim --> btnUrunuGeriAldiginiOnayla
        /// itemstatus_rate_info --> viewDegerlendirmeninBitmesi lblDegerlendirmeninBitmesi
        /// itemstatus_ratingbar_rel --> lblDegerlendirmenNedir
        /// itemstatus_ratingbar  --> cosmos1
        /// itemstatus_ratingbar_edittext --> txtYorumBurak
        /// itemstatus_ratingbar_tamamla --> btnTamamla
        /// itemstatus_complete_rel --> viewAlisVerisTamamlandi lblAlisVerisTamamlandu
        
        //nese baxaram ona
        lblEksik.isHidden = true
        viewEksik.isHidden = true
        txtEksikleriGiriniz.isHidden = true
        btnKayitOl.isHidden = true
        viewEksik2.isHidden = true
        lblEksik2.isHidden = true
        txtView.isHidden = true
        viewOnaylanmasiBekleniyor.isHidden = true
        lblOnaylanmasiBekleniyor.isHidden = true
        btnUrunuAldigimiOnayla.isHidden = true
        viewSaticininUrunuGeriAlmasiBekleniyor.isHidden = true
        lblSaticininUrunuGeriAlmasiBekleniyor.isHidden = true
        btnUrunuGeriAldiginiOnayla.isHidden = true
        viewDegerlendirmeninBitmesi.isHidden = true
        lblDegerlendirmeninBitmesi.isHidden = true
        lblDegerlendirmenNedir.isHidden = true
        cosmos1.isHidden = true
        txtYorumBurak.isHidden = true
        btnTamamla.isHidden = true
        viewAlisVerisTamamlandi.isHidden = true
        lblAlisVerisTamamlandu.isHidden = true
        
        view.addSubview(navController)
        _ = navController.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        navController.addSubview(btnLeft)
        btnLeft.centerYAnchor.constraint(equalTo: navController.centerYAnchor).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: navController.leftAnchor,constant: 5).isActive = true
        
        navController.addSubview(imgUrunDurumu)
        imgUrunDurumu.centerYAnchor.constraint(equalTo: navController.centerYAnchor).isActive = true
        imgUrunDurumu.leftAnchor.constraint(equalTo: btnLeft.rightAnchor,constant: 70).isActive = true
        
        
        
        navController.addSubview(lblUrunDurumu)
        lblUrunDurumu.centerYAnchor.constraint(equalTo: navController.centerYAnchor).isActive = true
        lblUrunDurumu.leftAnchor.constraint(equalTo: imgUrunDurumu.rightAnchor,constant: 7).isActive = true
        
        navController.addSubview(profilImage)
        profilImage.centerYAnchor.constraint(equalTo: navController.centerYAnchor).isActive = true
        profilImage.rightAnchor.constraint(equalTo: navController.rightAnchor,constant: -10).isActive = true
        
        view.addSubview(lblIstek)
        _ = lblIstek.anchor(top: navController.bottomAnchor , bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(viewEksik)
        self.viewEksik.roundCorners([.bottomLeft,.topLeft], radius: 15)
        _ = viewEksik.anchor(top: lblIstek.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        viewEksik.addSubview(lblEksik)
        lblEksik.centerYAnchor.constraint(equalTo: viewEksik.centerYAnchor).isActive = true
        lblEksik.rightAnchor.constraint(equalTo: viewEksik.rightAnchor,constant: -2).isActive = true
        
        
        view.addSubview(txtEksikleriGiriniz)
        _ = txtEksikleriGiriniz.anchor(top: viewEksik.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        
        view.addSubview(btnKayitOl)
        _ = btnKayitOl.anchor(top: txtEksikleriGiriniz.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 120, bottom: 0, right: 120))
        
        view.addSubview(viewEksik2)
        _ = viewEksik2.anchor(top: btnKayitOl.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        
        viewEksik2.addSubview(lblEksik2)
        lblEksik2.centerXAnchor.constraint(equalTo: viewEksik2.centerXAnchor).isActive = true
        lblEksik2.centerYAnchor.constraint(equalTo: viewEksik2.centerYAnchor).isActive = true
        
        view.addSubview(txtView)
        _ = txtView.anchor(top: viewEksik2.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        view.addSubview(viewOnaylanmasiBekleniyor)
        _ = viewOnaylanmasiBekleniyor.anchor(top: txtView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        viewOnaylanmasiBekleniyor.addSubview(lblOnaylanmasiBekleniyor)
        lblOnaylanmasiBekleniyor.centerXAnchor.constraint(equalTo: viewOnaylanmasiBekleniyor.centerXAnchor).isActive = true
        lblOnaylanmasiBekleniyor.centerYAnchor.constraint(equalTo: viewOnaylanmasiBekleniyor.centerYAnchor).isActive = true
        
        view.addSubview(btnUrunuAldigimiOnayla)
        _ = btnUrunuAldigimiOnayla.anchor(top: viewOnaylanmasiBekleniyor.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 10, bottom: 0, right: 0))
        
        view.addSubview(viewSaticininUrunuGeriAlmasiBekleniyor)
        _ = viewSaticininUrunuGeriAlmasiBekleniyor.anchor(top: btnUrunuAldigimiOnayla.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        viewSaticininUrunuGeriAlmasiBekleniyor.addSubview(lblSaticininUrunuGeriAlmasiBekleniyor)
        lblSaticininUrunuGeriAlmasiBekleniyor.centerXAnchor.constraint(equalTo: viewSaticininUrunuGeriAlmasiBekleniyor.centerXAnchor).isActive = true
        lblSaticininUrunuGeriAlmasiBekleniyor.centerYAnchor.constraint(equalTo: viewSaticininUrunuGeriAlmasiBekleniyor.centerYAnchor).isActive = true
        
        view.addSubview(btnUrunuGeriAldiginiOnayla)
        _ = btnUrunuGeriAldiginiOnayla.anchor(top: viewSaticininUrunuGeriAlmasiBekleniyor.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 10))
        
        view.addSubview(viewDegerlendirmeninBitmesi)
        _ = viewDegerlendirmeninBitmesi.anchor(top: btnUrunuGeriAldiginiOnayla.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        viewDegerlendirmeninBitmesi.addSubview(lblDegerlendirmeninBitmesi)
        lblDegerlendirmeninBitmesi.centerXAnchor.constraint(equalTo: viewDegerlendirmeninBitmesi.centerXAnchor).isActive = true
        lblDegerlendirmeninBitmesi.centerYAnchor.constraint(equalTo: viewDegerlendirmeninBitmesi.centerYAnchor).isActive = true
        
        view.addSubview(lblDegerlendirmenNedir)
        _ = lblDegerlendirmenNedir.anchor(top: viewDegerlendirmeninBitmesi.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 7, left: 40, bottom: 0, right: 0))
        
        view.addSubview(cosmos1)
        _ = cosmos1.anchor(top: viewDegerlendirmeninBitmesi.bottomAnchor, bottom: nil, leading: lblDegerlendirmenNedir.trailingAnchor, trailing: nil,padding: .init(top: 5, left: 10, bottom: 0, right: 0))
        
        view.addSubview(txtYorumBurak)
        _ = txtYorumBurak.anchor(top: cosmos1.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10))
        
        view.addSubview(btnTamamla)
        _ = btnTamamla.anchor(top: txtYorumBurak.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 100, bottom: 0, right: 100))
        
        view.addSubview(viewAlisVerisTamamlandi)
        _ = viewAlisVerisTamamlandi.anchor(top: btnTamamla.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        viewAlisVerisTamamlandi.addSubview(lblAlisVerisTamamlandu)
        lblAlisVerisTamamlandu.centerXAnchor.constraint(equalTo: viewAlisVerisTamamlandi.centerXAnchor).isActive = true
        lblAlisVerisTamamlandu.centerYAnchor.constraint(equalTo: viewAlisVerisTamamlandi.centerYAnchor).isActive = true
        
        
        controldata()
        
    }
    
    class BuyItem {
        
        let buyer: String
        let buyercomment: String
        let buyerrate: String
        let buyitemid : String
        let daycounter: String
        let eksikler: String
        let enddate: String
        let itemid: String
        let seller : String
        let sellercomment : String
        let sellerrate : String
        let startdate : String
        let status : String
        let totalprice : String
        
        init(buyer:String,buyercomment:String,buyerrate: String,buyitemid: String,daycounter: String,eksikler: String,enddate: String,itemid:String,seller:String, sellercomment:String, sellerrate:String,startdate:String, status:String,totalprice:String)
        {
            self.buyer = buyer
            self.buyercomment = buyercomment
            self.buyerrate = buyerrate
            self.buyitemid = buyitemid
            self.daycounter = daycounter
            self.eksikler = eksikler
            self.enddate = enddate
            self.itemid = itemid
            self.seller = seller
            self.sellercomment = sellercomment
            self.sellerrate = sellerrate
            self.startdate = startdate
            self.status = status
            self.totalprice = totalprice
            
        }
        
    }
    
    
    func controldata(){
        
        let buyitemref = Database.database().reference().child("BuyItem").child(buyitemid)
        
        buyitemref.observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            let buyer = value!["buyer"] as? String ?? ""
            let buyercomment = value!["buyercomment"] as? String ?? ""
            let buyerrate = value!["buyerrate"] as? String ?? ""
            let buyitemid = value!["buyitemid"] as? String ?? ""
            let daycounter = value!["daycounter"] as? String ?? ""
            let eksikler = value!["eksikler"] as? String ?? ""
            let enddate = value!["enddate"] as? String ?? ""
            let itemid = value!["itemid"] as? String ?? ""
            let seller = value!["seller"] as? String ?? ""
            let sellercomment = value!["sellercomment"] as? String ?? ""
            let sellerrate = value!["sellerrate"] as? String ?? ""
            let startdate = value!["startdate"] as? String ?? ""
            let status = value!["status"] as? String ?? ""
            let totalprice = value!["totalprice"] as? String ?? ""
            
            
            self.buyitem = BuyItem.init(
                buyer: buyer,
                buyercomment: buyercomment,
                buyerrate: buyerrate,
                buyitemid: buyitemid,
                daycounter: daycounter,
                eksikler: eksikler,
                enddate:enddate,
                itemid: itemid,
                seller: seller,
                sellercomment: sellercomment,
                sellerrate: sellerrate,
                startdate: startdate,
                status:status,
                totalprice:totalprice)
            
            self.setstatusbuyinfo(statusbuyitem: self.buyitem!)
            self.setotherpp(statusbuyitem: self.buyitem!)
            
            /// itemstatus_satici_eksik_info  -->  lblEksik  viewEksik
            /// itemstatus_satici_eksik_edittext --> txtEksikleriGiriniz
            /// itemstatus_satici_eksik_onayla  --> btnKayitOl
            /// itemstatus_eksikler_rel -->  viewEksik2 lblEksik2 txtView ??? text
            /// itemstatus_alici_urunualdim_info --> viewOnaylanmasiBekleniyor lblOnaylanmasiBekleniyor
            /// itemstatus_alici_urunualdim --> btnUrunuAldigimiOnayla
            /// itemstatus_satici_urunugerialdim_info --> viewSaticininUrunuGeriAlmasiBekleniyor lblSaticininUrunuGeriAlmasiBekleniyor
            /// itemstatus_satici_urunugerialdim --> btnUrunuGeriAldiginiOnayla
            /// itemstatus_rate_info --> viewDegerlendirmeninBitmesi lblDegerlendirmeninBitmesi
            /// itemstatus_ratingbar_rel --> lblDegerlendirmenNedir
            /// itemstatus_ratingbar  --> cosmos1
            /// itemstatus_ratingbar_edittext --> txtYorumBurak
            /// itemstatus_ratingbar_tamamla --> btnTamamla
            /// itemstatus_complete_rel --> viewAlisVerisTamamlandi lblAlisVerisTamamlandu
            
            let userID = Auth.auth().currentUser?.uid
            
            switch self.buyitem?.status {
            case "waitforminus":
                
                self.lblEksik.isHidden = false
                self.viewEksik.isHidden = false
                
                if userID == self.buyitem?.seller{
                    self.txtEksikleriGiriniz.isHidden = false
                    self.btnKayitOl.isHidden = false
                }
                
                ///button btnOnayla
                
                break
            case "waitforbuyerconfirm":
                
                self.lblEksik.isHidden = false
                self.viewEksik.isHidden = false
                self.lblEksik.text = "Satıcı eksikleri tamamladı."
                self.txtEksikleriGiriniz.isHidden = true
                self.btnKayitOl.isHidden = true
                
                self.viewEksik2.isHidden = false
                self.lblEksik2.isHidden  = false
                self.txtView.isHidden    = false
                self.txtView.text        = self.buyitem?.eksikler
                
                self.viewOnaylanmasiBekleniyor.isHidden = false
                self.lblOnaylanmasiBekleniyor.isHidden  = false
                
                if userID == self.buyitem?.buyer{
                    self.btnUrunuAldigimiOnayla.isHidden = false
                }
                
                ///button btnUrunuAldigimiOnayla
                
                break
            case "waitforsellerconfirm":
                
                
                self.lblEksik.isHidden = false
                self.viewEksik.isHidden = false
                self.lblEksik.text = "Satıcı eksikleri tamamladı."
                self.viewEksik2.isHidden = false
                self.lblEksik2.isHidden = false
                self.txtView.isHidden = false
                self.txtView.text = self.buyitem?.eksikler
                self.viewOnaylanmasiBekleniyor.isHidden = false
                self.lblOnaylanmasiBekleniyor.isHidden = false
                self.lblOnaylanmasiBekleniyor.text = "Alıcı ürünü aldığını onayladı."
                self.viewSaticininUrunuGeriAlmasiBekleniyor.isHidden = false
                self.lblSaticininUrunuGeriAlmasiBekleniyor.isHidden = false
                self.btnUrunuAldigimiOnayla.isHidden = true
               
                if userID == self.buyitem?.seller {
                    self.btnUrunuGeriAldiginiOnayla.isHidden = false
                }
                
                ///button btnUrunuGeriAldiginiOnayla
                
                break
            case "wait for rating":
                
                self.lblEksik.isHidden = false
                self.viewEksik.isHidden = false
                self.lblEksik.text = "Satıcı eksikleri tamamladı."
                self.viewEksik2.isHidden = false
                self.lblEksik2.isHidden = false
                self.txtView.isHidden = false
                self.txtView.text = self.buyitem?.eksikler
                self.viewOnaylanmasiBekleniyor.isHidden = false
                self.lblOnaylanmasiBekleniyor.isHidden = false
                self.lblOnaylanmasiBekleniyor.text = "Alıcı ürünü aldığını onayladı."
                self.viewSaticininUrunuGeriAlmasiBekleniyor.isHidden = false
                self.lblSaticininUrunuGeriAlmasiBekleniyor.isHidden = false
                self.lblSaticininUrunuGeriAlmasiBekleniyor.text = "Satıcı ürünü geri aldığını onayladı."
                self.btnUrunuGeriAldiginiOnayla.isHidden = true
                
                self.viewDegerlendirmeninBitmesi.isHidden = false
                self.lblDegerlendirmeninBitmesi.isHidden = false
                
                if userID == self.buyitem?.buyer{
                    if self.buyitem?.buyerrate == ""{
                        
                        self.lblDegerlendirmenNedir.isHidden = false
                        self.cosmos1.isHidden = false
                        self.txtYorumBurak.isHidden = false
                        self.btnTamamla.isHidden = false
                        
                    }else{
                        
                        self.lblDegerlendirmenNedir.isHidden = true
                        self.cosmos1.isHidden = true
                        self.txtYorumBurak.isHidden = true
                        self.btnTamamla.isHidden = true
                        
                    }
                }else{
                    if self.buyitem?.sellerrate == ""{
                        
                        self.lblDegerlendirmenNedir.isHidden = false
                        self.cosmos1.isHidden = false
                        self.txtYorumBurak.isHidden = false
                        self.btnTamamla.isHidden = false
                        
                    }else{
                        
                        self.lblDegerlendirmenNedir.isHidden = true
                        self.cosmos1.isHidden = true
                        self.txtYorumBurak.isHidden = true
                        self.btnTamamla.isHidden = true
                        
                    }
                }
                
                
                
                break
            case "complete":
                
                
                
                self.lblEksik.isHidden = false
                self.viewEksik.isHidden = false
                self.lblEksik.text = "Satıcı eksikleri tamamladı."
                self.viewEksik2.isHidden = false
                self.lblEksik2.isHidden = false
                self.txtView.isHidden = false
                self.txtView.text = self.buyitem?.eksikler
                self.viewOnaylanmasiBekleniyor.isHidden = false
                self.lblOnaylanmasiBekleniyor.isHidden = false
                self.lblOnaylanmasiBekleniyor.text = "Alıcı ürünü aldığını onayladı."
                self.viewSaticininUrunuGeriAlmasiBekleniyor.isHidden = false
                self.lblSaticininUrunuGeriAlmasiBekleniyor.isHidden = false
                self.lblSaticininUrunuGeriAlmasiBekleniyor.text = "Satıcı ürünü geri aldığını onayladı."
                self.btnUrunuGeriAldiginiOnayla.isHidden = true
                self.viewDegerlendirmeninBitmesi.isHidden = true
                self.lblDegerlendirmeninBitmesi.isHidden = true
                self.lblDegerlendirmenNedir.isHidden = true
                self.cosmos1.isHidden = true
                self.txtYorumBurak.isHidden = true
                self.btnTamamla.isHidden = true
                self.viewAlisVerisTamamlandi.isHidden = false
                self.lblAlisVerisTamamlandu.isHidden = false
                
                break
            default:break
            }
            
        })
        
        
    }
    
    @objc func leftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func btnkayitoll() {
        let eksik = txtEksikleriGiriniz.text
        
        if eksik != "" {
            
            //database kullanici kayit etme
            var firebaseusermap = [String : Any]()
            firebaseusermap["eksikler"] = eksik
            firebaseusermap["status"] = "waitforbuyerconfirm"
            
            //Save Notifacition
            var notihashmap = [String : Any]()
            let notificationid = Database.database().reference().child("Notification").child(buyitem!.buyer).childByAutoId().key
            
            notihashmap["notiid"] = notificationid
            notihashmap["notitype"] = "itemupdateeksikler"
            notihashmap["time"] = gettime()
            notihashmap["date"] = getdate()
            notihashmap["extradata"] = buyitem?.buyitemid
            notihashmap["extradata2"] = buyitem?.itemid
            
            let notiref = Database.database().reference().child("Notification").child(buyitem!.buyer).child(notificationid!)
            notiref.setValue(notihashmap)
            
            //database kayit etme
            let ref = Database.database().reference()
            ref.child("BuyItem").child(buyitemid).updateChildValues(firebaseusermap)
            
            self.sendnotification(userid: buyitem!.buyer, title: "Renty | Ürün durumu", body: "Eksikler tamamlandı. Hemen kontrol et.")
            
        }
        
    }
    @objc func urunAldigimiOnayla() {
        
        //Save Notifacition
        var notihashmap = [String : Any]()
        let notificationid = Database.database().reference().child("Notification").child(buyitem!.seller).childByAutoId().key
        
        notihashmap["notiid"] = notificationid
        notihashmap["notitype"] = "itemurunaldim"
        notihashmap["time"] = gettime()
        notihashmap["date"] = getdate()
        notihashmap["extradata"] = buyitem?.buyitemid
        notihashmap["extradata2"] = buyitem?.itemid
        
        let notiref = Database.database().reference().child("Notification").child(buyitem!.seller).child(notificationid!)
        notiref.setValue(notihashmap)
        
        //database kullanici kayit etme
        var firebaseusermap = [String : Any]()
        firebaseusermap["status"] = "waitforsellerconfirm"
        
        let ref = Database.database().reference()
        ref.child("BuyItem").child(buyitemid).updateChildValues(firebaseusermap)
        
        self.sendnotification(userid: buyitem!.seller, title: "Renty | Ürün durumu", body: "Alıcı ürünü aldığını onayladı. Hemen kontrol et.")
    }
    @objc func urungeriAldigimiOnayla() {
        
        //Save Notifacition
        var notihashmap = [String : Any]()
        let notificationid = Database.database().reference().child("Notification").child(buyitem!.buyer).childByAutoId().key
        
        notihashmap["notiid"] = notificationid
        notihashmap["notitype"] = "itemurungerialdim"
        notihashmap["time"] = gettime()
        notihashmap["date"] = getdate()
        notihashmap["extradata"] = buyitem?.buyitemid
        notihashmap["extradata2"] = buyitem?.itemid
        
        let notiref = Database.database().reference().child("Notification").child(buyitem!.buyer).child(notificationid!)
        notiref.setValue(notihashmap)
        
        //database kullanici kayit etme
        var firebaseusermap = [String : Any]()
        firebaseusermap["status"] = "wait for rating"
        
        let ref = Database.database().reference()
        ref.child("BuyItem").child(buyitemid).updateChildValues(firebaseusermap)
        
        self.sendnotification(userid: buyitem!.buyer, title: "Renty | Ürün durumu", body: "Satıcı ürünü geri aldığını onayladı. Hemen kontrol et.")
    }
    @objc func btntamamla() {
        
        userrate = "\(cosmos1.rating)"
        
        if userrate == "0.0" {
            //make alert "Lütfen yorumunuzu yazın."
            return
        }
        if self.txtYorumBurak.text!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            //make alert "Lütfen kullanıcıya oy verin."
            return
        }
        
        if buyitem?.sellerrate == "" && buyitem?.buyerrate == "" {
            // make alert "Değerlendirmeniz alındı! Karşı tarafında değerlendirmesi bittikten sonra değerlendirmeler gözükücektir."
            let userID = Auth.auth().currentUser?.uid
            var firebaseusermap = [String : Any]()
            
            if userID == self.buyitem?.buyer{
                firebaseusermap["buyerrate"] = userrate
                firebaseusermap["buyercomment"] = txtYorumBurak.text!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            }else {
                firebaseusermap["sellerrate"] = userrate
                firebaseusermap["sellercomment"] = txtYorumBurak.text!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            }
            
            let ref = Database.database().reference()
            ref.child("BuyItem").child(buyitemid).updateChildValues(firebaseusermap)
            
        } else{
            // make alert "Değerlendirmeniz alındı! Karşı tarafın değerlendirmesini görüntüleyebilirsiniz."
            let userID = Auth.auth().currentUser?.uid
            var firebaseusermap = [String : Any]()
            
            if userID == self.buyitem?.buyer{
                firebaseusermap["buyerrate"] = userrate
                firebaseusermap["buyercomment"] = txtYorumBurak.text!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            }else {
                firebaseusermap["sellerrate"] = userrate
                firebaseusermap["sellercomment"] = txtYorumBurak.text!.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            }
            firebaseusermap["status"] = "complete"
            
            //database kayit etme
            let ref = Database.database().reference()
            ref.child("BuyItem").child(buyitemid).updateChildValues(firebaseusermap)
            { (err, resp) in
                guard err == nil else {
                    print("Posting failed : ")
                    //self.actIndicator.hidesWhenStopped = true
                    return
                }
                self.updateuserdata()
            }
            
        }
        
        
    }
    
    func updateuserdata(){
        
        let buyitemref = Database.database().reference().child("BuyItem").child(buyitemid)
        
        buyitemref.observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            let buyer = value!["buyer"] as? String ?? ""
            let buyercomment = value!["buyercomment"] as? String ?? ""
            let buyerrate = value!["buyerrate"] as? String ?? ""
            let buyitemid = value!["buyitemid"] as? String ?? ""
            let daycounter = value!["daycounter"] as? String ?? ""
            let eksikler = value!["eksikler"] as? String ?? ""
            let enddate = value!["enddate"] as? String ?? ""
            let itemid = value!["itemid"] as? String ?? ""
            let seller = value!["seller"] as? String ?? ""
            let sellercomment = value!["sellercomment"] as? String ?? ""
            let sellerrate = value!["sellerrate"] as? String ?? ""
            let startdate = value!["startdate"] as? String ?? ""
            let status = value!["status"] as? String ?? ""
            let totalprice = value!["totalprice"] as? String ?? ""
            
            let buyitemfinish = BuyItem.init(
                buyer: buyer,
                buyercomment: buyercomment,
                buyerrate: buyerrate,
                buyitemid: buyitemid,
                daycounter: daycounter,
                eksikler: eksikler,
                enddate:enddate,
                itemid: itemid,
                seller: seller,
                sellercomment: sellercomment,
                sellerrate: sellerrate,
                startdate: startdate,
                status:status,
                totalprice:totalprice)
            
            _ = Auth.auth().currentUser?.uid
            
            var buyerhasmap  = [String : Any]()
            
            let buyercommentid = Database.database().reference().child("user").child(buyitemfinish.buyer).child("Comments").childByAutoId().key
            let sellercommentid = Database.database().reference().child("user").child(buyitemfinish.seller).child("Comments").childByAutoId().key

            buyerhasmap["rate"] = buyitemfinish.buyerrate
            buyerhasmap["comment"] = buyitemfinish.buyercomment
            buyerhasmap["commentid"] = buyercommentid
            buyerhasmap["itemid"] = buyitemfinish.itemid
            buyerhasmap["buyitemid"] = buyitemfinish.buyitemid
            buyerhasmap["anotherusercommentid"] = sellercommentid
                  
            var sellerhasmap  = [String : Any]()

            sellerhasmap["rate"] = buyitemfinish.sellerrate
            sellerhasmap["comment"] = buyitemfinish.sellercomment
            sellerhasmap["commentid"] = sellercommentid
            sellerhasmap["itemid"] = buyitemfinish.itemid
            sellerhasmap["buyitemid"] = buyitemfinish.buyitemid
            sellerhasmap["anotherusercommentid"] = buyercommentid

            //database kayit etme
            let ref = Database.database().reference()
            ref.child("user").child(buyitemfinish.buyer).child("Comments").child(buyercommentid!).setValue(buyerhasmap)
            { (err, resp) in
                guard err == nil else {
                    print("Posting failed : ")
                    return
                }
                
                let ref2 = Database.database().reference()
                ref2.child("user").child(buyitemfinish.seller).child("Comments").child(sellercommentid!).setValue(sellerhasmap)
                { (err, resp) in
                    guard err == nil else {
                        print("Posting failed : ")
                        return
                    }
                    self.setuserrate(lastbuyitem: buyitemfinish)
                }
            }
            
            //Save Notifacition
            var notihasmapbuyer = [String : Any]()
            let notihasmapidbuyerid = Database.database().reference().child("Notification").child(buyitemfinish.buyer).childByAutoId().key
            
            notihasmapbuyer["notiid"] = notihasmapidbuyerid
            notihasmapbuyer["notitype"] = "itemfinishreview"
            notihasmapbuyer["time"] = self.gettime()
            notihasmapbuyer["date"] = self.getdate()
            notihasmapbuyer["extradata"] = buyitemfinish.buyitemid
            notihasmapbuyer["extradata2"] = buyitemfinish.itemid
            
            var notihasmapseller = [String : Any]()
            let notihasmapidsellerid = Database.database().reference().child("Notification").child(buyitemfinish.seller).childByAutoId().key
            
            notihasmapseller["notiid"] = notihasmapidsellerid
            notihasmapseller["notitype"] = "itemfinishreview"
            notihasmapseller["time"] = self.gettime()
            notihasmapseller["date"] = self.getdate()
            notihasmapseller["extradata"] = buyitemfinish.buyitemid
            notihasmapseller["extradata2"] = buyitemfinish.itemid
            
            
            
            let notibuyerref = Database.database().reference().child("Notification").child(buyitemfinish.buyer).child(notihasmapidbuyerid!)
            let notisellerref = Database.database().reference().child("Notification").child(buyitemfinish.seller).child(notihasmapidsellerid!)

            notibuyerref.setValue(notihasmapbuyer)
            notisellerref.setValue(notihasmapseller)
                    
            self.sendnotification(userid: self.buyitem!.buyer, title: "Renty | Ürün durumu", body: "Değerlendirme bitti. Değerlendirmeni ürün sayfasından görüntüleyebilirsin.")
            self.sendnotification(userid: self.buyitem!.seller, title: "Renty | Ürün durumu", body: "Değerlendirme bitti. Değerlendirmeni ürün sayfasından görüntüleyebilirsin.")
            
            
        })
        
        
    }
    
    func setuserrate(lastbuyitem:BuyItem){
        
        let userRef = Database.database().reference().child("user")
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            //let value = snapshot.value as? NSDictionary

            self.updateuserrate(datasnapshot: snapshot, userid: lastbuyitem.buyer)
            self.updateuserrate(datasnapshot: snapshot, userid: lastbuyitem.seller)
            self.updateitemrate(itemid: lastbuyitem.itemid, datasnapshot: snapshot, seller: lastbuyitem.seller)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    func updateitemrate(itemid:String,datasnapshot:DataSnapshot,seller:String){
        _ = Auth.auth().currentUser?.uid

        var totalrate = 0.0
        var counter = 0
        
        
        for child in datasnapshot.childSnapshot(forPath: seller).childSnapshot(forPath: "Comments").children {
            
            let snap = child as! DataSnapshot //get first snapshot
            let value = snap.value as? NSDictionary //get second snapshot
            
            let rate = value!["rate"] as? String ?? ""
            let itemidd = value!["itemid"] as? String ?? ""
            
            if !rate.isEmpty && itemidd == itemid{
                totalrate = totalrate + Double(rate)!
                counter = counter + 1
            }
            
        }
        totalrate = totalrate / Double(counter)
        var firebaseusermap = [String : Any]()
        firebaseusermap["itemrate"] = "\(totalrate)"
        
        let userRef = Database.database().reference().child("items").child(itemid)
        userRef.updateChildValues(firebaseusermap)
        	
    }
    func updateuserrate(datasnapshot : DataSnapshot, userid: String){
        _ = Auth.auth().currentUser?.uid

        var totalrate = 0.0
        
        for child in datasnapshot.childSnapshot(forPath: userid).childSnapshot(forPath: "Comments").children {
            
            let snap = child as! DataSnapshot //get first snapshot
            let value = snap.value as? NSDictionary //get second snapshot
            
            let rate = value!["rate"] as? String ?? ""
            
            if rate != "" && !rate.isEmpty{
                totalrate = totalrate + Double(rate)!
            }
            
        }
        totalrate = totalrate / Double(datasnapshot.childSnapshot(forPath: userid).childSnapshot(forPath: "Comments").childrenCount)
        
        var firebaseusermap = [String : Any]()
        firebaseusermap["userrate"] = "\(totalrate)"
        let userRef = Database.database().reference().child("user").child(userid)
        userRef.updateChildValues(firebaseusermap)
    }
    
    func setotherpp(statusbuyitem : BuyItem){
        ///find my status
        var otheruserid = ""
        let userID = Auth.auth().currentUser?.uid
        
        if statusbuyitem.buyer == userID{
            otheruserid = statusbuyitem.seller
        }else{
            otheruserid = statusbuyitem.buyer
        }
        
        let userRef = Database.database().reference().child("user").child(otheruserid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let profilepicture = value?["profilepicture"] as? String ?? ""
            
            if(profilepicture != ""){
                self.profilImage.sd_setImage(with: URL(string: "\(profilepicture)"))
            }
            
            //!!! Profile Click Listener !!!
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    func setstatusbuyinfo(statusbuyitem : BuyItem){
        
        let userRef = Database.database().reference().child("user").child(statusbuyitem.buyer)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let namesurname = value?["namesurname"] as? String ?? ""
            
            ///istek ayarlarini ayarla
            self.lblIstek.text = "\(namesurname) adlı adlı kullanıcı \(statusbuyitem.startdate) - \(statusbuyitem.enddate) tarihleri arası için rezervasyon isteğinde bulundu."
            
            
            
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
    func sendnotification(userid:String,title:String,body:String){
          
          let tokenRef = Database.database().reference().child("user").child(userid)
          tokenRef.observeSingleEvent(of: .value, with: { (snapshot) in
                  let value = snapshot.value as? NSDictionary
                  
                  let token = value?["token"] as? String ?? ""
          
                  let sender = PushNotificationSender()
                  sender.sendPushNotification(to: token,title: title,body: body)
              
              }) { (error) in
                  print(error.localizedDescription)
              }
          
    
      }
    
    
}
