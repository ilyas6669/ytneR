//
//  ForgotPassword.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/18/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class ForgotPassword: UIViewController ,UITextFieldDelegate{
    
    let logo : UIImageView = {
        let logo = UIImageView(image: #imageLiteral(resourceName: "rentylogo"))
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    let yasil : UIImageView = {
            let yasil = UIImageView(image: #imageLiteral(resourceName: "Group 14"))
            yasil.contentMode = .scaleAspectFill
            return yasil
    }()
    
    let lblEmail : UILabel = {
        let lbl = UILabel()
        lbl.text = "Email"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return lbl
    }()
    
    let txtEmail : OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
       txt.attributedPlaceholder = NSAttributedString(string: "johndoe@mail.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        txt.keyboardType = .emailAddress
        txt.layer.cornerRadius = 15
        return txt
    }()
    
    let kayitOl : UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.setTitle("Şifremi Unuttum", for: .normal)
        return button
    }()
    
    let sifremiSifirla: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("ŞİFREMİ SIFIRLA", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.rgb(red: 83, green: 105, blue: 196), for: .normal)
        btn.layer.cornerRadius = 15
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        btn.addTarget(self, action: #selector(KayitOLAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return btn
    }()
    
    let geri : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "left"), for: .normal)
        btn.layer.cornerRadius = 0.5 * btn.bounds.size.width
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(sifremiSifirlaa), for: .touchUpInside)
        return btn
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgraoundGradient()
        layoutDuzenle()
        
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureREcongizer)

    }
    
    fileprivate func layoutDuzenle() {
        
        txtEmail.delegate = self
        
        //MARK: addSubView
        view.addSubview(yasil)
        view.addSubview(logo)
        view.addSubview(kayitOl)
        view.addSubview(txtEmail)
        view.addSubview(sifremiSifirla)
        view.addSubview(geri)
        view.addSubview(txtEmail)
        view.addSubview(lblEmail)
        
        //MARK: add constraint
        _ = logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 80, bottom: 0, right: 80),boyut: .init(width: 230, height: 140))
        _ = yasil.anchor(top: logo.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 40, left: 20, bottom: 0, right: 0),boyut: .init(width: 360, height: 450))
        _ = kayitOl.anchor(top: yasil.topAnchor, bottom: nil, leading: yasil.leadingAnchor, trailing: yasil.trailingAnchor,padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        _ = txtEmail.anchor(top: kayitOl.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 45, bottom: 0, right: 45))
        _ = sifremiSifirla.anchor(top: txtEmail.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 80, bottom: 0, right: 80))
        _ = geri.anchor(top: sifremiSifirla.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 5, left: 80, bottom: 0, right: 80),boyut: .init(width: 60, height: 60))
        _ = lblEmail.anchor(top: txtEmail.topAnchor, bottom: txtEmail.bottomAnchor, leading: nil, trailing: txtEmail.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 10))
    }
    
    
    @objc func sifremiSifirlaa() {
        let login = Login()
        login.modalPresentationStyle = .fullScreen
        self.present(login, animated: true, completion: nil)
    }
    
    //MARK: DataBase Sifremi Unuttum Kontreller
    @objc func KayitOLAction() {
        
        if txtEmail.text == "" {
            self.makeAlert(tittle: "Error", message: "Lütfen email adresinizi girniz")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { error in
            self.makeAlert(tittle: "Başarılı", message: "Email adresinize gönderdiğimiz linke tıklıyarak şifrenizi değişebilirsiniz")
        }
        
       }
    
    
    //MARK: Arti Funksiyonlar
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func makeAlert(tittle: String, message : String) {
            let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
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
