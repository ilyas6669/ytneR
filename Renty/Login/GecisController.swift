//
//  GecisController.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/21/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class GecisController : UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let goruntuler = ["re","n","ty"]
    let basliklar = ["Merheba!","Tüketimi azaltip dogayi korumaya var misin?","Ayni zamanda ek gelir elde etmeye ne dersin?"]
    
    let btnAtla : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("ATLA", for: .normal)
        btn.setTitleColor(.rgb(red: 83, green: 105, blue: 196), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
         btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
     btn.widthAnchor.constraint(equalToConstant: 112).isActive = true
        btn.addTarget(self, action: #selector(btnAtlaClicked), for: .touchUpInside)
        return btn
    }()
    
    let btnSonraki : UIButton = {
              let btn = UIButton(type: .system)
              btn.setTitle("SONRAKI", for: .normal)
              btn.setTitleColor(.rgb(red: 112, green: 182, blue: 44), for: .normal)
              btn.backgroundColor = .white
              btn.layer.cornerRadius = 15
              btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
               btn.widthAnchor.constraint(equalToConstant: 112).isActive = true
           btn.addTarget(self, action: #selector(btnSonrakiClicked), for: .touchUpInside)
              return btn
          }()
    
    let btnHadiBaslayim : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("HADI BASLAYALIM!", for: .normal)
        btn.setTitleColor(.rgb(red: 83, green: 105, blue: 196), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.heightAnchor.constraint(equalToConstant: 33).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 172).isActive = true
        btn.addTarget(self, action: #selector(hadibaslayalimAction), for: .touchUpInside)
        return btn
        
    }()
    
    let pageController : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = UIColor.rgb(red: 112, green: 182, blue: 44)
        pc.pageIndicatorTintColor = UIColor.white
        return pc
    
    }()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageController.currentPage = Int(x / view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.backgroundColor = .green
        
        let btSV = UIStackView(arrangedSubviews: [btnAtla,btnSonraki])
               btSV.distribution = .fillEqually
               btSV.spacing = 100
        
        view.addSubview(btSV)
        view.addSubview(pageController)
        view.addSubview(btnHadiBaslayim)
        
        btnHadiBaslayim.isHidden = true
        
        collectionView.register(WelcomeSayfa.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
        
        _ = btSV.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 35, right: 20))
              
        _ = pageController.anchor(top: nil, bottom: btSV.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        _ = btnHadiBaslayim.anchor(top: pageController.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 100, bottom: 10, right: 100))
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goruntuler.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WelcomeSayfa
        cell.image1.image = UIImage(named: goruntuler[indexPath.row])
        cell.lbl1.text = basliklar[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func btnSonrakiClicked() {
        pageController.currentPage += 1
        let indexpath = IndexPath(item: pageController.currentPage, section: 0)
        collectionView.scrollToItem(at: indexpath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
       
        
        if pageController.currentPage == 2 {
            btnSonraki.isHidden = true
            btnAtla.isHidden = true
            btnHadiBaslayim.isHidden = false
        }

       }
       
       
       @objc func btnAtlaClicked() {
           let signup = SignUp()
        signup.modalPresentationStyle = .fullScreen
        self.present(signup, animated: true, completion: nil)
       }
    
    
    @objc func hadibaslayalimAction() {
        let signup = SignUp()
        signup.modalPresentationStyle = .fullScreen
        self.present(signup, animated: true, completion: nil)
    }
    
    
}
