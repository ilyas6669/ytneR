//
//  UrunSayfasi.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/19/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import ImageSlideshow
import MapKit
import Kingfisher
import Cosmos
import FSCalendar
import TTGSnackbar




class UrunSayfasi: UIViewController,MKMapViewDelegate, FSCalendarDataSource, FSCalendarDelegate{
    
    
  
   lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+350)
       
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
  
    
    var itemid = ""
    
    
    
    fileprivate weak var calendar: FSCalendar!
    
    private var firstDate: Date?
    
    private var lastDate: Date?
    
    private var datesRange: [Date]!
    
    
    var userid = ""
    var pricestr = ""
    var publisher = ""
    var commentList : [NSDictionary] = []
    
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.heightAnchor.constraint(equalToConstant: 270).isActive = true
        return view
    }()
    
    let imageSlideShow = ImageSlideshow()
    
    
    
    let yesilView : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }()
    
    
    let btnFavori : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Urunstar"), for: .normal)
        btn.addTarget(self, action: #selector(btnFavoriClicked), for: .touchUpInside)
        return btn
    }()
    
    let btnMesaj : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Urunmesaj"), for: .normal)
        btn.addTarget(self, action: #selector(btnMesajClicked), for: .touchUpInside)
        return btn
    }()
    
    
    let lblFiyat : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 22)
        return lbl
    }()
    
    let imgUrun : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "ic_tag_white"))
        img.heightAnchor.constraint(equalToConstant: 32).isActive = true
        img.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return img
        
    }()
    
    
    var lblUrunIsmi : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.text = ""
        return lbl
    }()
    
    var lblUrunAciklama : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.text = ""
        return lbl
    }()
    
    var lblurunAciklama3 : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.text = ""
        return lbl
    }()
    
    
    let lblUrunAciklamasi : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textAlignment = .left
        lbl.textColor = .lightText
        lbl.numberOfLines = 4
        return lbl
    }()
    
    let ortaView : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.heightAnchor.constraint(equalToConstant: 65).isActive = true
        view.roundCorners([.bottomRight], radius: 20)
        return view
    }()
    
    let ortaView2 : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.heightAnchor.constraint(equalToConstant: 65).isActive = true
        view.widthAnchor.constraint(equalToConstant: 220).isActive = true
        view.roundCorners([.bottomRight], radius: 20)
        return view
    }()
    
    let ortaView3 : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        view.heightAnchor.constraint(equalToConstant: 65).isActive = true
        view.roundCorners([.topLeft], radius: 20)
        return view
    }()
    
    let ortaView4 : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 90, blue: 63)
        view.heightAnchor.constraint(equalToConstant: 65).isActive = true
        //view.roundCorners([.topLeft], radius: 20)
        return view
    }()
    
    
    
    
    let sebetView : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return view
    }()
    
    let profilImage : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "user1"))
        img.backgroundColor = .white
        img.heightAnchor.constraint(equalToConstant: 60).isActive = true
        img.widthAnchor.constraint(equalToConstant: 60).isActive = true
        img.layer.cornerRadius = img.frame.size.height / 2
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        return img
    }()
    
    let lblSoyIsim : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.text = ""
        return lbl
    }()
    
    let harita : MKMapView = {
        let harita = MKMapView()
        harita.heightAnchor.constraint(equalToConstant: 200).isActive = true
        harita.layer.cornerRadius = 10
        return harita
    }()
    
    let btnSebet : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "sebet1"), for: .normal)
        btn.addTarget(self, action: #selector(sebetEkleAction), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    let cosmos1 : CosmosView = {
        let cosmos = CosmosView()
        cosmos.rating = 0
        cosmos.settings.updateOnTouch = false
        cosmos.settings.emptyBorderColor = UIColor.rgb(red: 51, green: 81, blue: 72)
        cosmos.settings.filledColor = UIColor.yellow
        cosmos.settings.starMargin = 0
        return cosmos
    }()
    
    let cosmos2 : CosmosView = {
        let cosmos = CosmosView()
        cosmos.rating = 0
        cosmos.settings.updateOnTouch = false
        cosmos.settings.emptyBorderColor = .white
        cosmos.settings.filledColor = UIColor.yellow
        cosmos.settings.starMargin = 0
        return cosmos
    }()
    
    let btnOnayla: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(" Sepete Ekle", for: .normal)
        btn.setImage(UIImage(named: "succes2"), for: .normal)
        btn.backgroundColor = .rgb(red: 13, green: 165, blue: 72)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(btnOnaylaAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 140).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let lblSepetFiyat : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .black
        lbl.textAlignment = .center
        return lbl
    }()
    
    let calendarview : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 370).isActive = true
        view.widthAnchor.constraint(equalToConstant: 350).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorners([.bottomRight,.bottomLeft], radius: 15)
        return view
    }()
    
    let btnLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "left1"), for: .normal)
        btn.addTarget(self, action: #selector(leftBtnAction), for: .touchUpInside)
        return btn
    }()
    
    let beyazView : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 193, green: 189, blue: 189)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.heightAnchor.constraint(equalToConstant: 260).isActive = true
        cv.backgroundColor = .white
        return cv
    }()
    
    fileprivate let collectionView2 : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        cv.backgroundColor = .white
        return cv
    }()
    
    var dataArray = ["Cadir","Decatlon","projeksiyon"]
    
    var similaritemlist : [NSDictionary] = []
    
    
    let benzerUrunView : UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 112, green: 182, blue: 44)
        view.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return view
    }()
    
    let lblBenzerUrun  : UILabel = {
        let lbl = UILabel()
        lbl.text = "Benzer Ürünler"
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imageSlideShow.contentScaleMode = .scaleToFill
        
        
        getitemdata()
        
        self.ustView.roundCorners([.bottomLeft,.bottomRight], radius: 20)
        self.imageSlideShow.roundCorners([.bottomLeft,.bottomRight], radius: 20)
        
        
        
        let btnSV = UIStackView(arrangedSubviews: [btnFavori,btnMesaj])
        btnSV.spacing = 7
        
        let fiyatSV = UIStackView(arrangedSubviews: [imgUrun,lblFiyat])
        fiyatSV.spacing = 7
        
        
        let lblSV = UIStackView(arrangedSubviews: [lblUrunIsmi,lblUrunAciklama,lblurunAciklama3])
        lblSV.axis = .vertical
        lblSV.spacing = 5
        
        let stackView = UIStackView(arrangedSubviews: [collectionView2,harita,benzerUrunView,collectionView])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        
        
        
        imageSlideShow.contentMode = .scaleAspectFill
        imageSlideShow.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "left1"), style: .done, target: self, action: #selector(btnleftAction))
        self.navigationItem.leftBarButtonItem = rightBarButtonItem
        
        
        
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        
        containerView.addSubview(ustView)
        containerView.addSubview(imageSlideShow)
        
        
        containerView.addSubview(btnSV)
        containerView.addSubview(fiyatSV)
        containerView.addSubview(lblUrunAciklamasi)
        containerView.addSubview(lblSV)
        containerView.addSubview(ortaView)
        containerView.addSubview(ortaView2)
        containerView.addSubview(ortaView4)
        containerView.addSubview(ortaView3)
        containerView.addSubview(profilImage)
        containerView.addSubview(lblSoyIsim)
        //containerView.addSubview(harita)
        containerView.addSubview(cosmos1)
        containerView.addSubview(cosmos2)
        containerView.addSubview(btnSebet)
        
        
        containerView.addSubview(stackView)
        benzerUrunView.addSubview(lblBenzerUrun)
        
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BenzerUrunCell",bundle: nil), forCellWithReuseIdentifier: "BenzerUrunCell")
        self.collectionView2.delegate = self
        self.collectionView2.dataSource = self
        self.collectionView2.register(UINib(nibName: "YorumlarCell", bundle: nil), forCellWithReuseIdentifier: "YorumlarCell")
        
        
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 167, height: 249)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
        }
        
        if let layout = collectionView2.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 350, height: 263)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
        }
        
        
        
        _ = stackView.anchor(top: ortaView.bottomAnchor, bottom: nil, leading: stackView.leadingAnchor, trailing: stackView.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        
        
        _ = benzerUrunView.anchor(top: nil, bottom: collectionView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        _ = lblBenzerUrun.anchor(top: benzerUrunView.topAnchor, bottom: benzerUrunView.bottomAnchor, leading: benzerUrunView.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        collectionView.backgroundColor = .rgb(red: 112, green: 182, blue: 44)
        collectionView.topAnchor.constraint(equalTo: harita.bottomAnchor,constant: 40).isActive = true
        collectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        collectionView2.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        //        collectionView2.topAnchor.constraint(equalTo: btnSebet.bottomAnchor).isActive = true
        //        collectionView2.leftAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        //        collectionView2.rightAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        //collectionView2.bottomAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
        
        
        
        _ = ustView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        imageSlideShow.backgroundColor = .white
        imageSlideShow.heightAnchor.constraint(equalToConstant: 250).isActive = true
        _ = imageSlideShow.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        _ = btnSV.anchor(top: containerView.topAnchor, bottom: nil, leading: nil, trailing: containerView.trailingAnchor,padding: .init(top: 235, left: 0, bottom: 0, right: 18))
        _ = fiyatSV.anchor(top: ustView.bottomAnchor, bottom: nil, leading: nil, trailing: containerView.trailingAnchor,padding: .init(top: 35, left: 0, bottom: 0, right: 5))
        _ = cosmos1.anchor(top: lblSV.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 20, bottom: 0, right: 0))
        _ = lblUrunAciklamasi.anchor(top: cosmos1.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        _ = lblSV.anchor(top: ustView.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil,padding: .init(top: 35, left: 20, bottom: 0, right: 0))
        _ = ortaView.anchor(top: lblUrunAciklamasi.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: ortaView3.leadingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        _ = ortaView2.anchor(top: ortaView.topAnchor, bottom: ortaView.bottomAnchor, leading: containerView.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        _ = ortaView4.anchor(top: ortaView.topAnchor, bottom: nil, leading: ortaView2.trailingAnchor, trailing: containerView.trailingAnchor)
        _ = ortaView3.anchor(top: ortaView4.topAnchor, bottom: ortaView4.bottomAnchor, leading: ortaView2.trailingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        _ = lblSoyIsim.anchor(top: ortaView.topAnchor, bottom: nil, leading: profilImage.trailingAnchor, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        _ = cosmos2.anchor(top: lblSoyIsim.bottomAnchor, bottom: nil, leading: profilImage.trailingAnchor, trailing: nil,padding: .init(top: 5, left: 10, bottom: 0, right: 0))
        profilImage.centerYAnchor.constraint(equalTo: ortaView.centerYAnchor).isActive = true
        profilImage.leftAnchor.constraint(equalTo: ortaView.leftAnchor, constant: 10).isActive = true
        
        
        _ = btnSebet.anchor(top: ortaView3.topAnchor, bottom: nil, leading: ortaView2.trailingAnchor , trailing: containerView.trailingAnchor,padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 350, height: 370))
        calendar.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        calendar.allowsMultipleSelection = true
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.appearance.titleDefaultColor = UIColor.white
        calendar.appearance.todayColor = UIColor.rgb(red: 201, green: 213, blue: 51)
        calendar.appearance.selectionColor = UIColor.rgb(red: 112, green: 182, blue: 44)
        calendar.appearance.weekdayTextColor = UIColor.white
        calendar.appearance.headerTitleColor = UIColor.white
        calendar.roundCorners([.bottomLeft,.bottomRight], radius: 15)
        calendar.dataSource = self
        calendar.delegate = self
        self.calendar = calendar
        calendarview.addSubview(calendar)
        
        
        
        view.addSubview(beyazView)
        _ = beyazView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        
        
        beyazView.addSubview(calendarview)
        //calendarview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        calendarview.centerXAnchor.constraint(equalTo: beyazView.centerXAnchor).isActive = true
        calendarview.topAnchor.constraint(equalTo: view.topAnchor,constant: 50).isActive = true
        
        beyazView.addSubview(lblSepetFiyat)
        _ = lblSepetFiyat.anchor(top: calendarview.bottomAnchor, bottom: nil, leading: beyazView.leadingAnchor, trailing: beyazView.trailingAnchor,padding: .init(top: 10, left: 80, bottom: 0, right: 80))
        
        beyazView.addSubview(btnOnayla)
        _ = btnOnayla.anchor(top: calendarview.bottomAnchor, bottom: nil, leading: beyazView.leadingAnchor, trailing: beyazView.trailingAnchor,padding: .init(top: 50, left: 100, bottom: 0, right: 100))
        
        
        beyazView.addSubview(btnLeft)
        _ = btnLeft.anchor(top: nil, bottom: calendarview.topAnchor, leading: beyazView.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 10, right: 0))
        
        beyazView.isHidden = true
        
        ///---------------------------------------------------------
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
        let gestureReconGizerrr = UITapGestureRecognizer(target: self, action: #selector(imgSecAction))
        profilImage.addGestureRecognizer(gestureReconGizerrr)
        
    }
    
    @objc func imgSecAction() {
//        let profilBar = KisiProfilsayfasi()
//        profilBar.modalPresentationStyle = .fullScreen
//        profilBar.userid = publisher
//        self.present(profilBar, animated: true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "KisiProfilsayfasi") as! KisiProfilsayfasi
        vc.userid = publisher
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    
    
    @objc func btnleftAction() {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func sebetEkleAction() {
        
        let userID = Auth.auth().currentUser?.uid
        
        let userRef = Database.database().reference().child("Sepet").child(userID!)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            print("deneme1:\(snapshot)")
            print("deneme1:\(userID ?? "")")
            
            if(snapshot.hasChild(self.itemid)){
                
                
                let snackbar = TTGSnackbar(
                    message: "Ürün zaten sepetinizde. Ürünü sepetinizden kaldırmak istermisiniz?",
                    duration: .forever,
                    actionText: "EVET",
                    actionBlock: { (snackbar) in
                        let userID = Auth.auth().currentUser?.uid
                        Database.database().reference().child("Sepet").child(userID!).child(self.itemid).removeValue()
                       
                            snackbar.dismiss()
                        
                }
                )
                
                snackbar.show()
                
                
                
                print("test")
            }else{
                self.beyazView.isHidden = false
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
    @objc func btnOnaylaAction() { //sepete ekle
        
        if(lastDate == nil || firstDate == nil){ ///veri girilmemisse
            return
        }
        
        let totalprice = self.calculatetotaldayprice(daycounter: datesRange.count-1, itemprice: self.pricestr)
        let userID = Auth.auth().currentUser!.uid
        
        print("lastdate : \(convertdate(date: lastDate!))")
        print("firstdate : \(convertdate(date: firstDate!))")
        print("datesrange : \(datesRange.count)")
        print("totalprice : \(totalprice)")
      
        
        
        //database sepet kayit etme
        var firebaseusermap = [String : Any]()
        
        firebaseusermap["startdate"] = "\(convertdate(date: firstDate!))"
        firebaseusermap["enddate"] = "\(convertdate(date: lastDate!))"
        firebaseusermap["daycounter"] = "\(datesRange.count)"
        firebaseusermap["buyer"] = userID
        firebaseusermap["seller"] = self.publisher
        firebaseusermap["itemid"] = self.itemid
        firebaseusermap["itemprice"] = "\(totalprice)"
        
        print("deneme11:\(self.publisher)")
        print("deneme11:\(userID)")
        print("deneme1:\(firebaseusermap)")
        
        
        //database kayit etme
        let ref = Database.database().reference()
        ref.child("Sepet").child(userID).child(itemid).setValue(firebaseusermap)
        { (err, resp) in
            guard err == nil else {
                print("Posting failed : ")
                //self.actIndicator.hidesWhenStopped = true
                return
            }
            self.beyazView.isHidden = true
            self.makeAlertt(tittle: "Başarılı", message: "Ürününüz sepete eklendi")
            
        }
        
        
        
    }
    
    
    //bulardan hansidi
    func calculatetotaldayprice(daycounter : Int, itemprice : String) -> Int{
        var toplamfiyat = 0
        
        switch daycounter {
        case 1:
            toplamfiyat = Int(itemprice)!
            break
        case 2:
            toplamfiyat = Int(itemprice)! + (Int(itemprice)!*2)/3
            break
        default:
            let daycounter2 = daycounter + 1
            toplamfiyat = Int(itemprice)! + (Int(itemprice)!*2)/3
            for _ in 3..<daycounter2 {
                
                toplamfiyat = toplamfiyat + Int(itemprice)!/2
            }
            break
        }
        
        return toplamfiyat
    }
    
    
    func convertdate(date : Date) -> String {
        //    "01 Oca 2020"
        let date = date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    @objc func leftBtnAction() {
        beyazView.isHidden = true
    }
    
    
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:
        
        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                
                print("datesRange contains: \(datesRange!)")
                
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            
            lastDate = range.last
            
            for d in range {
                calendar.select(d)
            }
            
            datesRange = range
            
            print("datesRange contains: \(datesRange!)")
            
            let totalprice1 = self.calculatetotaldayprice(daycounter: datesRange.count-1, itemprice: self.pricestr)
            lblSepetFiyat.text = "Toplam Fiyat : \(totalprice1)"
            
            return
        }
        
        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            
            print("datesRange contains: \(datesRange!)")
            
        }
    }
    
    
    
    
    
    func getveri(){
        
        let userID = Auth.auth().currentUser?.uid
        
        if userID != nil {
            let userRef = Database.database().reference().child("user").child(publisher)
            
            userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                
                
                let namesurname = value?["namesurname"] as? String ?? ""
                let profilepicture = value?["profilepicture"] as? String ?? ""
                let userrate = value?["userrate"] as? String ?? ""
                
                self.cosmos2.rating = Double(userrate)!
                
                self.lblSoyIsim.text = namesurname
                
                
                if(profilepicture != ""){
                    self.profilImage.sd_setImage(with: URL(string: "\(profilepicture)"))
                }
                
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
    
    
    func checkfavoritestatus(itemid:String,button:UIButton){
        
        let userID = Auth.auth().currentUser?.uid
        
        let userRef = Database.database().reference().child("Favorite").child(userID!)
        
        userRef.observe(.value, with: { (snapshot) in
            
            if(snapshot.hasChild(itemid)){
                button.setImage(UIImage(named: "favoriurun"), for: .normal)
                button.tag = 1
            }else{
                button.setImage(UIImage(named: "favoriurun1"), for: .normal)
                button.tag = 0
            }
            
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
                
           
                let sehir = value!["sehir"] as? String ?? ""
                 let publisher = value!["publisher"] as? String ?? ""
                
                if sehir == Cache.usersehir && publisher != Auth.auth().currentUser?.uid {
                    
                    if itempublish {
                        if currentcategory == category &&
                            currentkind1   == kind1 &&
                            currentitemid  != itemid {
                            self.similaritemlist.append(value!)
                        }
                    }
                }
                  
              }
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
            if self.similaritemlist.count == 0 {
                  self.collectionView.isHidden = true
                  self.benzerUrunView.isHidden = true
                  self.lblBenzerUrun.isHidden = true
              }else{
                  self.collectionView.isHidden = false
                  self.benzerUrunView.isHidden = false
                  self.lblBenzerUrun.isHidden = false
              }
                          
              self.collectionView.reloadData()
          })
          
      }
    
    func getitemdata(){
        //bu userden almalidid itemnen alir belke onnandi ?  yox userden alir brat yeni itemin icine saxranit olunan userin bilkdime onda itemisin icine userin idisin harda saxranit eliyirihki biz ? burda konumu itemnen alirig itemin icinede itemi saxranit eliyende userden konum alib saxranit leiyirik bidene bilsen ne sefdi latitudeynen longitude eynidi men dbdan urunlerei sildim ona gore oldu birinci konumu guncelle sonra urun paylas bildm birde eyer duz olsa kayit olma yerine baxag bide gordun ordada eyni qoymusug duzeldi yobana vurod bele shevin icine soxumda ograshdi adam bilmir gulsun aglasin mendede duzs du :D :D bu niye error verdi yene yoxsa vebremyedi bayaxkidi hdee yetseebn qalp tebrik eliyirem yetim bu da bele getti ;D bunna sora nese cixsa oluopda ALA HELE ENGELLEMENI SOXMUSUGE XEBERI YOXUD ;D: :DD:D hele filtirelemedede soxus var :D :D :D :D :D BIDENE KAYIT OLMA YERINE BAX GOR ORDADA PROBLEM YOXUD KODLARINA GET 
        
        let userRef = Database.database().reference().child("items").child(itemid)
        
        
        userRef.observe(.value, with: { (snapshot) in
            // Get item value
            let value = snapshot.value as? NSDictionary
            
            self.getbenzeritem(item: value!)
            
            let itempublish = value!["itempublish"] as? Bool ?? false
            let photo0 = value!["photo0"] as? String ?? ""
            let photo1 = value!["photo1"] as? String ?? ""
            let photo2 = value!["photo2"] as? String ?? ""
            let photo3 = value!["photo3"] as? String ?? ""
            let latitude = value!["latitude"] as? Double ?? 0.0
            let longitude = value!["longitude"] as? Double ?? 0.0
            let kind1 = value!["kind1"] as? String ?? ""
            let kind2 = value!["kind2"] as? String ?? ""
            let kind3 = value!["kind3"] as? String ?? ""
            let description = value!["description"] as? String ?? ""
            self.pricestr = value!["pricestr"] as? String ?? ""
            let itemrate = value!["itemrate"] as? String ?? ""
            let itemid = value!["itemid"] as? String ?? ""
            self.publisher = value!["publisher"] as? String ?? ""
            
            self.getveri() // bun eid ? bezner urunelr ? ne dbda da eynidi dzu alirsan saxranit eliyende nese trema var userdede eynidi bidene o profili duzenleye get 
            
            if itempublish{
                
                self.checkfavoritestatus(itemid: itemid, button: self.btnMesaj)
                
                //get image
                if photo0 != "empty"{
                    self.imageSlideShow.setImageInputs([
                        KingfisherSource(urlString:photo0)!
                    ])
                }
                if photo1 != "empty"{
                    self.imageSlideShow.setImageInputs([
                        KingfisherSource(urlString:photo0)!,
                        KingfisherSource(urlString:photo1)!
                    ])
                }
                if photo2 != "empty"{
                    self.imageSlideShow.setImageInputs([
                        KingfisherSource(urlString:photo0)!,
                        KingfisherSource(urlString:photo1)!,
                        KingfisherSource(urlString:photo2)!
                    ])
                }
                if photo3 != "empty"{
                    self.imageSlideShow.setImageInputs([
                        KingfisherSource(urlString:photo0)!,
                        KingfisherSource(urlString:photo1)!,
                        KingfisherSource(urlString:photo2)!,
                        KingfisherSource(urlString:photo3)!
                    ])
                }
                
                //set pin in map buralardi latitude alanda xiar kimi dexlisiz yer alir neter olur bas acmadm dian
                let annotation = MKPointAnnotation()
                let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                print("la/\(latitude),\(longitude)")
                annotation.coordinate = centerCoordinate
                annotation.title = "Ürün Konumu"
                self.harita.addAnnotation(annotation)
                let pinZoom = annotation
                let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                let region = MKCoordinateRegion(center: pinZoom.coordinate, span: span)
                self.harita.setRegion(region, animated: true)
                
                ///set kind1
                if kind1 != "empty"{
                    self.lblUrunIsmi.isHidden = false
                    self.lblUrunIsmi.text = kind1
                }
                ///set kind2
                if kind2 != "empty"{
                    self.lblUrunAciklama.isHidden = false
                    self.lblUrunAciklama.text = kind2
                }else{
                    self.lblUrunAciklama.isHidden = true
                }
                
                if kind3 != "empty" {
                    self.lblurunAciklama3.isHidden = false
                    self.lblurunAciklama3.text = kind3
                }else{
                    self.lblurunAciklama3.isHidden = true
                    
                }
                
                self.cosmos1.rating = Double(itemrate)!
                
                
                
                ///set description
                self.lblUrunAciklamasi.text = description
                
                ///set price
                self.lblFiyat.text = "\(self.pricestr) TL"
                
                
                ///get item comment
                let userRef = Database.database().reference().child("user").child(self.publisher).child("Comments")
                //indi tema nedi meselen androide paylasilan urununded konumun sef gosterir ? yoxsa oz paylasilanlari ? onu deqiq tutanmiramki ba men indi bidene paylasim gor sende o hara gosterir mende hara paylas paylasdm nicatda bidene konum guncelle seyde konum dediyim seherivi deyiwdir mende error veerdi seeher deyisnede andrpidde ne basa dusmedim hansi seherde pahanyslas m hansisa sehere deyeisdir guncelle gor error verir deisdirib oaylasdim mende ilin bayramovdu telde andoriide sen nicata gir baxda bidedne urune mende parolu yoxdu qalsn cixmiyim girirem bideki nicat hesabinda bidene test oaylasimi var ona basanda atir onu silmeh lazmdi dbdan urunu silme yerine get 
                userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    
                    for child in snapshot.children {
                        
                        let snap = child as! DataSnapshot //get first snapshot
                        let value = snap.value as? NSDictionary //get second snapshot
                        
                        let userreviewitemid = value!["itemid"] as? String ?? ""
                        
                        if itemid == userreviewitemid {
                            self.commentList.append(value!)
                        }
                        
                    }
                    
                    if self.commentList.count == 0 {
                        self.collectionView2.isHidden = true
                    }else{
                        self.collectionView2.isHidden = false
                    }
                    
                    self.collectionView2.reloadData()
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
                
                
                
                
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    
    @objc func btnFavoriClicked() {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.receiver = publisher
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
        
        
        
    }
    
    
    @objc func btnMesajClicked() {
        
        let tagstatus = self.btnMesaj.tag
        let userID = Auth.auth().currentUser?.uid
        
        if(tagstatus == 0){
            Database.database().reference().child("Favorite").child(userID!).child(itemid).setValue(true)
        }else{
            Database.database().reference().child("Favorite").child(userID!).child(itemid).removeValue()
        }
        
    }
    
    
    
    
    
}


extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
            
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}





extension UrunSayfasi : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return self.similaritemlist.count
        }else{
            return self.commentList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "BenzerUrunCell", for: indexPath) as! BenzerUrunCell
          
            
            let value2 = self.similaritemlist[indexPath.row]

                    let photo0 = value2["photo0"] as? String ?? ""
            _ = value2["itemid"] as? String ?? ""
                    let kind1 = value2["kind1"] as? String ?? ""
            _ = value2["kind2"] as? String ?? ""
                    let price = value2["pricestr"] as? String ?? ""
                    
                    //set first category
                    
            if kind1 != "empty"{
                              cell1.lblurun.text = kind1
                              cell1.lblurun.isHidden = false
                          }else{
                              cell1.lblurun.text = ""
                              cell1.lblurun.isHidden = true
                          }
            
            let title = value2["title"] as? String ?? ""
                
            if title != "" {
                
                cell1.lblurun.text = title
                cell1.lblurun.isHidden = false
                
                
            }else {
                
                //set first category
                    if kind1 != "empty"{
                        cell1.lblurun.text = kind1
                        cell1.lblurun.isHidden = false
                    }else{
                        cell1.lblurun.text = ""
                        cell1.lblurun.isHidden = true
                    }
                    
                   
                
            }
            
            
            
            
            
                    cell1.imgUrun.sd_setImage(with: URL(string: "\(photo0)"))
                    cell1.lblFiyat.text = "\(price) TL"

                    cell1.imgUrun.contentMode = .scaleAspectFill
            
            return cell1
        } else {
            let cell2 = collectionView2.dequeueReusableCell(withReuseIdentifier: "YorumlarCell", for: indexPath) as! YorumlarCell
            
            //itemleri collection viewda gosterme
            let value2  = self.commentList[indexPath.row]
            
            let comment                 = value2["comment"] as? String ?? ""
            let rate                    = value2["rate"] as? String ?? ""
            let buyitemid               = value2["buyitemid"] as? String ?? ""
            let anotherusercommentid    = value2["anotherusercommentid"] as? String ?? ""
            
            
            //set userreview data || ALICI
            cell2.lblMesaj.text = comment
            cell2.cosmos.rating = Double(rate)!
            
            ///get buy item
            let userRef = Database.database().reference().child("BuyItem").child(buyitemid)
            userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let valued = snapshot.value as? NSDictionary
                
                let buyer = valued!["buyer"] as? String ?? ""
                let seller = valued!["seller"] as? String ?? ""
                let startdate = valued!["startdate"] as? String ?? ""
                let enddate = valued!["enddate"] as? String ?? ""
                
                
                ///tarihlerin arasi
                let df = DateFormatter()
                df.dateFormat = "dd-MM-yyyy"
//                let result = df.date(from: string)
                
                
                let calendar = Calendar.current
                
                // Replace the hour (time) of both dates with 00:00
                let date1 = calendar.startOfDay(for: df.date(from: startdate)!)
                let date2 = calendar.startOfDay(for: df.date(from: enddate)!)
                let components = calendar.dateComponents([.day], from: date1, to: date2)

                if components.day == 0 {
                    cell2.lblTarih.text = " Bugün"
                    cell2.lblTarih2.text = " Bugün"
                }else if components.day! > 0{
                    cell2.lblTarih.text = " \(components.day!) gün önce"
                    cell2.lblTarih2.text = " \(components.day!) gün önce"
                }else{
                    cell2.lblTarih.text = " Yeni"
                    cell2.lblTarih2.text = " Yeni"
                }
                
                                
                ///set userreview data || SATICI
                let anotherref = Database.database().reference().child("user").child(buyer).child("Comments").child(anotherusercommentid)
                
                anotherref.observeSingleEvent(of: .value, with: { (snapshot2) in
                    let userreview1 = snapshot2.value as? NSDictionary
                    
                    
                    let comment                 = userreview1!["comment"] as? String ?? ""
                    let rate                    = userreview1!["rate"] as? String ?? ""
                    
                    cell2.lblMesaj2.text = comment
                    cell2.cosmos2.rating = Double(rate)!
                    
                }) { (error) in print(error.localizedDescription)}
                
                
                ///get user info || ALICI
                let satiref = Database.database().reference().child("user").child(buyer)
                satiref.observeSingleEvent(of: .value, with: { (snapshot2) in
                    let user = snapshot2.value as? NSDictionary
          
                    let namesurname = user?["namesurname"] as? String ?? ""
                    let profilepicture = user?["profilepicture"] as? String ?? ""
                    
                    cell2.lblIsim.text = namesurname
                    if(profilepicture != ""){
                        cell2.imgProfil.sd_setImage(with: URL(string: "\(profilepicture)"))
                    }
                    
                }) { (error) in print(error.localizedDescription)}
                
                ///get user info || SATICI
                let aliciref = Database.database().reference().child("user").child(seller)
                aliciref.observeSingleEvent(of: .value, with: { (snapshot2) in
                    let user = snapshot2.value as? NSDictionary
                      
                                let namesurname = user?["namesurname"] as? String ?? ""
                                let profilepicture = user?["profilepicture"] as? String ?? ""
                                
                                cell2.lblIsim2.text = namesurname
                                if(profilepicture != ""){
                                    cell2.imgProfil2.sd_setImage(with: URL(string: "\(profilepicture)"))
                                }
                                
                            }) { (error) in print(error.localizedDescription)}
                
                
                
                
            }) { (error) in print(error.localizedDescription)}
            
            
            return cell2
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            
            let value2 = self.similaritemlist[indexPath.row]
                             let itemid = value2["itemid"] as? String ?? ""
                             
                             let uruneklson = UrunSayfasi()
                             uruneklson.modalPresentationStyle = .fullScreen
                             uruneklson.itemid = itemid
                             navigationController?.pushViewController(uruneklson, animated: true)
            
        }else{
            
        }
        
        
    }
    
    
}


extension UIViewController {
    func makeAlertt(tittle: String, message : String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
