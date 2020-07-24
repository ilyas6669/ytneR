//
//  FotorafEkle1.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/4/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import ImageSlideshow

class FotorafEkle1: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let popUpError : PopUpError = {
        let view = PopUpError()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    let imageSlideShow = ImageSlideshow()
    
    var imageArray : [UIImage] = []
    
    var pageControl = UIPageControl()
    
    var imageclickcontrol = ""
    
    var item : item?
    
    var itemcategory = ""
    
    let imgFotorafekle = UIImageView(image: #imageLiteral(resourceName: "lineurunekle2"))
    
    let lblFotorafEkle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Fotoğraf Ekle"
        lbl.textColor = .white
        return lbl
    }()
    
    let btnFotoSec: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "addphoto"), for: .normal)
        btn.addTarget(self, action: #selector(imgSecAction0), for: .touchUpInside)
        return btn
    }()
    
    let btnFotoSec1: UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "addphoto"), for: .normal)
        btn.addTarget(self, action: #selector(imgSecAction1), for: .touchUpInside)
        return btn
    }()
    
    let btnFotoSec2: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "addphoto"), for: .normal)
        btn.addTarget(self, action: #selector(imgSecAction2), for: .touchUpInside)
        return btn
    }()
    
    let btnFotoSec3: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "addphoto"), for: .normal)
        btn.addTarget(self, action: #selector(imgSecAction3), for: .touchUpInside)
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutDuzenle()
       
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(gestureREcongizer)
        
        
        imageSlideShow.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        imageSlideShow.contentScaleMode = .scaleToFill
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "tick-2"), style: .done, target: self, action: #selector(kecUrunEkle))
        
        
    }
    
    
    
    func layoutDuzenle() {
        let imgSv = UIStackView(arrangedSubviews: [btnFotoSec,btnFotoSec1,btnFotoSec2,btnFotoSec3])
        imgSv.spacing = 8
        
        //imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
        
        view.addSubview(imgFotorafekle)
        view.addSubview(lblFotorafEkle)
        view.addSubview(imgSv)
        view.addSubview(imageSlideShow)
       
        
        
        imgFotorafekle.heightAnchor.constraint(equalToConstant: 22).isActive = true
        _ = imgFotorafekle.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        lblFotorafEkle.merkezXSuperView()
        lblFotorafEkle.topAnchor.constraint(equalTo: imgFotorafekle.bottomAnchor,constant: 10).isActive = true
        
        imgSv.merkezXSuperView()
        imgSv.topAnchor.constraint(equalTo: lblFotorafEkle.bottomAnchor,constant: 10).isActive = true
        
        
        
        imageSlideShow.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageSlideShow.backgroundColor = .white
        _ = imageSlideShow.anchor(top: btnFotoSec.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        
        
        btnFotoSec.heightAnchor.constraint(equalToConstant: 79).isActive = true
        btnFotoSec.widthAnchor.constraint(equalToConstant: 76).isActive = true
        btnFotoSec1.heightAnchor.constraint(equalToConstant: 79).isActive = true
        btnFotoSec1.widthAnchor.constraint(equalToConstant: 76).isActive = true
        btnFotoSec2.heightAnchor.constraint(equalToConstant: 79).isActive = true
        btnFotoSec2.widthAnchor.constraint(equalToConstant: 76).isActive = true
        btnFotoSec3.heightAnchor.constraint(equalToConstant: 79).isActive = true
        btnFotoSec3.widthAnchor.constraint(equalToConstant: 76).isActive = true
        
      
    }
    
    @objc func testAction() {
        print("testaction")
    }
    
    @objc func kecUrunEkle() {
        if(imageArray.count != 0){
            
            let uruneklson = UrunEkleSon()
            uruneklson.itemcategory = itemcategory
            uruneklson.imageArray = imageArray
            navigationController?.pushViewController(uruneklson, animated: true)
            
        }else{
            //luften minumum 1 fotograf ekleyin
            
        }
        
    }
    
    
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpError.alpha = 0
            self.popUpError.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpError.removeFromSuperview()
        }
    }
    
    @objc func imgSecAction0() {
        print("test")
        imageclickcontrol = "0"
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    @objc func imgSecAction1() {
        imageclickcontrol = "1"
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    @objc func imgSecAction2() {
        imageclickcontrol = "2"
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    @objc func imgSecAction3() {
        imageclickcontrol = "3"
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var image: UIImage?
        if let edited =  info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = edited
           
        } else if let nonEdited = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = nonEdited
         
            
        }
        
        imageArray.append(image!) 
        
        
        if imageclickcontrol == "0" {
            btnFotoSec.isHidden = true
            
        }else if imageclickcontrol == "1" {
            btnFotoSec1.isHidden = true
            
        }else if imageclickcontrol == "2" {
            btnFotoSec2.isHidden = true
            
        }else if imageclickcontrol == "3" {
            btnFotoSec3.isHidden = true
            
        }
        
        
        
        
        if(imageArray.count == 1){
            imageSlideShow.setImageInputs([
                ImageSource(image: imageArray[0])
            ])
        }else if(imageArray.count == 2){
            imageSlideShow.setImageInputs([
                ImageSource(image: imageArray[0]),
                ImageSource(image: imageArray[1])
            ])
        }else if(imageArray.count == 3){
            imageSlideShow.setImageInputs([
                ImageSource(image: imageArray[0]),
                ImageSource(image: imageArray[1]),
                ImageSource(image: imageArray[2])
            ])
        }else if(imageArray.count == 4){
            imageSlideShow.setImageInputs([
                ImageSource(image: imageArray[0]),
                ImageSource(image: imageArray[1]),
                ImageSource(image: imageArray[2]),
                ImageSource(image: imageArray[3])
            ])
        }else{
            
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
}


