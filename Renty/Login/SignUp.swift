//
//  SignUp.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class SignUp: UIViewController,UITextFieldDelegate {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    lazy var contentViewSize2 = CGSize(width: self.view.frame.width, height: self.view.frame.height+150)
    
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
    
    
    let logo : UIImageView = {
        let logo = UIImageView(image: #imageLiteral(resourceName: "rentylogo"))
        logo.contentMode = .scaleAspectFill
        logo.heightAnchor.constraint(equalToConstant: 140).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 230).isActive = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
   let yasil : UIImageView = {
       let yasil = UIImageView(image: #imageLiteral(resourceName: "Group 14"))
       yasil.contentMode = .scaleAspectFill
       return yasil
    }()
    
    let imageView : UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "triangle"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let lblKullaniciAdi : UILabel = {
        let lbl = UILabel()
        lbl.text = "İsim Soyisim"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return lbl
    }()
    
    let lblEmail : UILabel = {
        let lbl = UILabel()
        lbl.text = "Email"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return lbl
    }()
    
    let lblSifre : UILabel = {
        let lbl = UILabel()
        lbl.text = "Şifre"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return lbl
    }()
    
    let lblSifreTekrar : UILabel = {
        let lbl = UILabel()
        lbl.text = "Şifre Tekrar"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return lbl
    }()
    
    let txtKullaniciAdi : OzelTextField = {
        let txt = OzelTextField()
        txt.adjustsFontSizeToFitWidth = true
        txt.minimumFontSize = 10
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string: "John Doe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        txt.layer.cornerRadius = 15
         txt.textColor = .black
        return txt
     }()
     
     let txtEmail : OzelTextField = {
         let txt = OzelTextField()
         txt.backgroundColor = .white
         txt.adjustsFontSizeToFitWidth = true
         txt.minimumFontSize = 10
        txt.attributedPlaceholder = NSAttributedString(string: "johndeo@mail.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
         txt.keyboardType = .emailAddress
         txt.layer.cornerRadius = 15
         txt.textColor = .black
         return txt
     }()
     
     let txtParol : OzelTextField = {
         let txt = OzelTextField()
         txt.adjustsFontSizeToFitWidth = true
         txt.minimumFontSize = 10
         txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string: "••••••", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
         txt.isSecureTextEntry = true
         txt.layer.cornerRadius = 15
         txt.textColor = .black
         return txt
     }()
     
     let txtParol2 : OzelTextField = {
         let txt = OzelTextField()
         txt.adjustsFontSizeToFitWidth = true
         txt.minimumFontSize = 10
         txt.backgroundColor = .white
         txt.attributedPlaceholder = NSAttributedString(string: "••••••", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
         txt.isSecureTextEntry = true
         txt.layer.cornerRadius = 15
         txt.textColor = .black
         return txt
     }()
     
    
    let kayitOl : UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.setTitle("Kayıt Ol", for: .normal)
        button.addTarget(self, action: #selector(KayitOLAction), for: .touchUpInside)
        return button
    }()
    
    let girisYap : UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.setTitle("Giriş Yap", for: .normal)
        button.addTarget(self, action: #selector(GirisYapAction), for: .touchUpInside)
        return button
    }()
    
     let btnKayitOl: UIButton = {
         let btn = UIButton(type: .system)
         btn.setTitle("KAYIT OL", for: .normal)
         btn.setTitleColor(.rgb(red: 83, green: 105, blue: 196), for: .normal)
         btn.backgroundColor = .white
         btn.layer.cornerRadius = 15
         btn.addTarget(self, action: #selector(btnkayitOl), for: .touchUpInside)
         btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
         btn.heightAnchor.constraint(equalToConstant: 35).isActive = true
         return btn
     }()
     
     let btnSifremiUnuttum: UIButton = {
         let btn = UIButton(type: .system)
         btn.setTitle("KAYIT OLMADAN GİRİŞ YAP", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
         btn.backgroundColor = .white
         btn.setTitleColor(.rgb(red: 83, green: 105, blue: 196), for: .normal)
         btn.layer.cornerRadius = 15
         btn.addTarget(self, action: #selector(sifremiUnuttum), for: .touchUpInside)
         btn.heightAnchor.constraint(equalToConstant: 35).isActive = true
         return btn
     }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgraoundGradient()
        layoutDuzenle()

        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureREcongizer)
    
    }
    
    fileprivate func layoutDuzenle() {
        
        txtKullaniciAdi.delegate = self
        txtEmail.delegate = self

        let signUpSV = UIStackView(arrangedSubviews: [txtKullaniciAdi,txtEmail,txtParol,txtParol2])
        let signUpSV2 = UIStackView(arrangedSubviews: [girisYap,kayitOl])
        
        //MARK: addSubView
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        containerView.addSubview(yasil)
        containerView.addSubview(logo)
        containerView.addSubview(signUpSV2)
        containerView.addSubview(signUpSV)
        containerView.addSubview(btnKayitOl)
        containerView.addSubview(btnSifremiUnuttum)
        containerView.addSubview(imageView)
        containerView.addSubview(lblKullaniciAdi)
        containerView.addSubview(lblEmail)
        containerView.addSubview(lblSifre)
        containerView.addSubview(lblSifreTekrar)
    
        signUpSV.axis = .vertical
        signUpSV.spacing = 15

        signUpSV2.spacing = 30
        signUpSV2.distribution = .fillEqually

        //MARK: add constraint
//        _ = logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 80, bottom: 0, right: 80),boyut: .init(width: 230, height: 140))
        
        logo.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        logo.merkezXSuperView()
       
        
        _ = yasil.anchor(top: logo.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 0),boyut: .init(width: 360, height: 450))
        _ = signUpSV2.anchor(top: yasil.topAnchor, bottom: nil, leading: yasil.leadingAnchor, trailing: yasil.trailingAnchor,padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        _ = signUpSV.anchor(top: signUpSV2.bottomAnchor, bottom: nil, leading: yasil.leadingAnchor, trailing: yasil.trailingAnchor,padding: .init(top: 5, left: 20, bottom: 0, right: 20))
        _ = btnKayitOl.anchor(top: signUpSV.bottomAnchor, bottom: nil, leading: yasil.leadingAnchor, trailing: yasil.trailingAnchor,padding: .init(top: 15, left: 80, bottom: 0, right: 80))
        _ = btnSifremiUnuttum.anchor(top: btnKayitOl.bottomAnchor, bottom: nil, leading: yasil.leadingAnchor, trailing: yasil.trailingAnchor,padding: .init(top: 10, left: 90, bottom: 0, right: 90))
        _ = imageView.anchor(top: signUpSV2.bottomAnchor, bottom: signUpSV.topAnchor, leading: nil, trailing: yasil.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 64))
        _ = lblKullaniciAdi.anchor(top: txtKullaniciAdi.topAnchor, bottom: txtKullaniciAdi.bottomAnchor, leading: nil, trailing: txtKullaniciAdi.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        _ = lblEmail.anchor(top: txtEmail.topAnchor, bottom: txtEmail.bottomAnchor, leading: nil, trailing: txtEmail.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        _ = lblSifre.anchor(top: txtParol.topAnchor, bottom: txtParol.bottomAnchor, leading: nil, trailing: txtParol.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        _ = lblSifreTekrar.anchor(top: txtParol2.topAnchor, bottom: txtParol2.bottomAnchor, leading: nil, trailing: txtParol2.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
         scrolView.contentSize = contentViewSize2
        
       
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrolView.contentSize = contentViewSize
    }
    
    @objc func KayitOLAction() {
        let signUP = SignUp()
        signUP.modalPresentationStyle = .fullScreen
        self.present(signUP, animated: true, completion: nil)
    }
    
    @objc func GirisYapAction() {
        let girisYap = Login()
        girisYap.modalPresentationStyle = .fullScreen
        self.present(girisYap, animated: true, completion: nil)
       }
    
    @objc func sifremiUnuttum() {
           let sifremiUnuttum = KayitOlmadanGirisYap()
           sifremiUnuttum.modalPresentationStyle = .fullScreen
           self.present(sifremiUnuttum, animated: true, completion: nil)
       }
    
    
    //MARK: DataBase Kayit ol Kontroller
    @objc func btnkayitOl() {
        
        if txtKullaniciAdi.text == "" {
            makeAlert(tittle: "Error", message: "Lütfen isim soyisminizi giriniz")
            return
        }else if txtEmail.text == "" {
             makeAlert(tittle: "Error", message: "Lütfen email adresinizi girniz")
            return
        }else if txtParol.text == "" {
            makeAlert(tittle: "Error", message: "Lütfen şifrenizi giriniz")
            return
        }else if txtParol2.text == "" {
            makeAlert(tittle: "Error", message: "Lütfen şifrenizi tekrar giriniz")
            return
        }else if txtParol.text != txtParol2.text{
            makeAlert(tittle: "Error", message: "Girdiğiniz şifreler aynı değil")
            return
        }
        
        self.activityIndicator.startAnimating()
      
            let kullaniciaAdi = txtKullaniciAdi.text
            let email = txtEmail.text
            let sifre = txtParol.text
         
            Auth.auth().createUser(withEmail: (email ?? ""), password: (sifre ?? "")) { (result, error) in
               if let _eror = error {
                   //MARK: Kayit olma basarisiz ise
                self.makeAlert(tittle: "Error", message: _eror.localizedDescription)
                self.activityIndicator.stopAnimating()
               }
               else{ //MARK: Kayit olma basarili ise
                
                //database kullanici kayit etme
                var firebaseusermap = [String : Any]()
        
                let userID = Auth.auth().currentUser!.uid

                firebaseusermap["userid"] = userID
                firebaseusermap["accountcomplete"] = "false"
                firebaseusermap["email"] = email
                firebaseusermap["namesurname"] = kullaniciaAdi
                firebaseusermap["profilepicture"] = ""
                firebaseusermap["userrate"] = "0.0"
                firebaseusermap["sehir"] = ""
                firebaseusermap["il"] = ""
                firebaseusermap["acikadres"] = ""
                firebaseusermap["phonenumber"] = ""
                firebaseusermap["blockedadmin"] = "false"
                
                firebaseusermap["signupdate"] = signupdate()
                firebaseusermap["signupdateint"] = signupdateint()
                firebaseusermap["signupdatestring"] = signupdatestring()
                
                self.activityIndicator.stopAnimating()
                    
                //database kayit etme
                let ref = Database.database().reference()
                ref.child("user").child(userID).setValue(firebaseusermap)
                { (err, resp) in
                    guard err == nil else {
                        print("Posting failed : ")
                        //self.actIndicator.hidesWhenStopped = true
                        self.activityIndicator.stopAnimating()
                        return
                        }
                        let splash = SplahView()
                    self.present(splash, animated: true, completion: nil)
                        print("No errors while posting, :")
                    self.activityIndicator.stopAnimating()
                        print(resp)
                        }
            
               }
            }
            
        
            
    
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    fileprivate func backgraoundGradient() {
        let gradient = CAGradientLayer()
        let ustRenk = #colorLiteral(red: 0, green: 0.1490196078, blue: 0.1019607843, alpha: 1)
        let alrRenk = #colorLiteral(red: 0.01568627451, green: 0.5490196078, blue: 0.3882352941, alpha: 1)
        gradient.colors = [ustRenk.cgColor,alrRenk.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.bounds
    }
    
    func makeAlert(tittle: String, message : String) {
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 16 characters
        return updatedText.count <= 40
    }
    
    
}


func signupdate() -> String {
//    "01 Oca 2020"
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    let result = formatter.string(from: date)
    return result
}

func signupdateint() -> Int {
//    20200101
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    let result = formatter.string(from: date)
    return Int(result)!
}

func signupdatestring() -> String {
    //  "01012020"
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "ddMMyyyy"
    let result = formatter.string(from: date)
    return result
}
