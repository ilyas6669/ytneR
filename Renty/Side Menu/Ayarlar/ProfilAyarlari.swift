//
//  ProfilAyarlari.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import CoreLocation
import Firebase
import SDWebImage

class ProfilAyarlari: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, CLLocationManagerDelegate{
    
    
    
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.color = .black
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var locationManager: CLLocationManager = CLLocationManager()
    var latitude : String = ""
    var longutide : String = ""
    
   let imgProfil : UIImageView = {
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
    img.isUserInteractionEnabled = true
            img.translatesAutoresizingMaskIntoConstraints = false
            return img
    }()
    
    
    
    
    let txtIsim : SkyFloatingLabelTextField = {
        let txt = SkyFloatingLabelTextField()
        txt.placeholder = "İsim Soyisim"
        txt.title = "İsim Soyisim"
        txt.backgroundColor = .white
        txt.textColor = .black
        txt.lineColor = .rgb(red: 0, green: 38, blue: 26)
        txt.selectedLineColor = .rgb(red: 0, green: 90, blue: 63)
        txt.selectedTitleColor = .rgb(red: 0, green: 90, blue: 63)
        txt.lineHeight = 1.0
        txt.selectedLineHeight = 2.0
        return txt
    }()
    
    
    let txtAcikAdres : SkyFloatingLabelTextField = {
        let txt = SkyFloatingLabelTextField()
        txt.placeholder = "Açık Adres"
        txt.title = "Açık Adres"
        txt.backgroundColor = .white
        txt.textColor = .black
        txt.lineColor = .rgb(red: 0, green: 38, blue: 26)
        txt.selectedLineColor = .rgb(red: 0, green: 90, blue: 63)
        txt.selectedTitleColor = .rgb(red: 0, green: 90, blue: 63)
        txt.lineHeight = 1.0
        txt.selectedLineHeight = 2.0
        return txt
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        layoutDuzenle()
        hideKeyboardWhenTappedRecongizer()
        
        let gestureReconGizer = UITapGestureRecognizer(target: self, action: #selector(imgSecAction))
        imgProfil.addGestureRecognizer(gestureReconGizer)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let logo = UIImage(named: "ProfilAyarlari")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        getveri()
        
    }
    
    
    
    
    func layoutDuzenle() {
        view.addSubview(imgProfil)
        view.addSubview(txtIsim)
        view.addSubview(txtAcikAdres)
        view.addSubview(btnKonumBelirle)
        
        
        
        
        
        
        imgProfil.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgProfil.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        _ = txtIsim.anchor(top: imgProfil.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 20, left: 10, bottom: 0, right: 10))
        _ = txtAcikAdres.anchor(top: txtIsim.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        _ = btnKonumBelirle.anchor(top: txtAcikAdres.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 15, left: 30, bottom: 0, right: 30))
       
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func makeAlert(tittle: String, message : String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func imgSecAction() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgProfil.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func btnKonumBelirlee() {
        
        
        
        //database konum kayit guncellenme
        var firebaseusermap = [String : Any]()
        
        let userID = Auth.auth().currentUser!.uid
        
        firebaseusermap["latitude"] = Double(latitude)!
        firebaseusermap["longitude"] = Double(longutide)!
        
        //database kayit etme
        let ref = Database.database().reference()
        ref.child("user").child(userID).updateChildValues(firebaseusermap)
        { (err, resp) in
            guard err == nil else {
                print("Posting failed : ")
                return
            }
            self.btnKonumBelirle.setTitle("Konum belirlendi",for: UIControl.State.normal)
        }
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation : CLLocation = locations[locations.count-1]
        
        latitude = String(format: "%.6f",lastLocation.coordinate.latitude)
        longutide = String(format: "%.6f",lastLocation.coordinate.longitude)
        
    }
    
    
    @IBAction func btnLeft(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getveri(){
        
        let userID = Auth.auth().currentUser?.uid
        
        let userRef = Database.database().reference().child("user").child(userID!)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let namesurname = value?["namesurname"] as? String ?? ""
            let acikadres = value?["acikadres"] as? String ?? ""
            let profilepicture = value?["profilepicture"] as? String ?? ""
            
            self.txtIsim.text = namesurname
            self.txtAcikAdres.text = acikadres
            
            if(profilepicture != ""){
                self.imgProfil.sd_setImage(with: URL(string: "\(profilepicture)"))
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }
    
    @IBAction func btnRIght(_ sender: Any) {
        self.activityIndicator.startAnimating()
        
        if txtIsim.text == "" {
            makeAlert(tittle: "Hata", message: "Lütfen İsim Soyisim kısmını boş bırakmayın")
            return
                self.activityIndicator.stopAnimating()
        }else if txtAcikAdres.text == ""{
            makeAlert(tittle: "Hata", message: "Lütfen acik adres kısmını boş bırakmayın")
            self.activityIndicator.stopAnimating()
            return
        }
        else{
            
            if(imgProfil.image != nil){ //fotograf varsa
                
                let storage = Storage.storage()
                let storageReferance = storage.reference()
                
                let mediaFolder = storageReferance.child("profileimage")
                
                if let data = imgProfil.image?.jpegData(compressionQuality: 0.5) {
                    
                    let uuid = UUID().uuidString
                    
                    let imageReferance = mediaFolder.child("\(uuid).jpg").child("profilepicture.jpg")
                    imageReferance.putData(data, metadata: nil) { (metadata, error) in
                        if error != nil {
                            self.makeAlert(tittle: "Error", message: error?.localizedDescription ?? "Error")
                        }else{
                            imageReferance.downloadURL { (url, error) in
                                if error == nil {
                                    let imgageUrl = url?.absoluteString
                                    
                                    let isimsoyisim = self.txtIsim.text
                                    let acikadres = self.txtAcikAdres.text
                                    
                                    //database kullanici kayit guncellenme
                                    var firebaseusermap = [String : Any]()
                                    
                                    let userID = Auth.auth().currentUser!.uid
                                    
                                    firebaseusermap["profilepicture"] = imgageUrl
                                    firebaseusermap["namesurname"] = isimsoyisim
                                    firebaseusermap["acikadres"] = acikadres
                                    
                                    //database kayit etme
                                    let ref = Database.database().reference()
                                    ref.child("user").child(userID).updateChildValues(firebaseusermap)
                                    { (err, resp) in
                                        guard err == nil else {
                                            print("Posting failed : ")
                                            return
                                        }
                                        
                                        
                                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
                                        vc.selectedIndex = 0
                                        vc.modalPresentationStyle = .fullScreen
                                        self.present(vc, animated: true, completion: nil)
                                        self.activityIndicator.stopAnimating()
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }
                
            }else{ //fotograf yoksa
                
                
                let isimsoyisim = self.txtIsim.text
                let acikadres = self.txtAcikAdres.text
                
                //database kullanici kayit guncellenme
                var firebaseusermap = [String : Any]()
                
                let userID = Auth.auth().currentUser!.uid
                
                firebaseusermap["namesurname"] = isimsoyisim
                firebaseusermap["acikadres"] = acikadres
                
                
                
                //database kayit etme
                let ref = Database.database().reference()
                ref.child("user").child(userID).updateChildValues(firebaseusermap)
                { (err, resp) in
                    guard err == nil else {
                        print("Posting failed : ")
                        return
                    }
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
                    vc.selectedIndex = 0
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                    
                }
                
            }
        }
        
    }
    
}



