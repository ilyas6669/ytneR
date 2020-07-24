//
//  SideMenuHakkinda.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/16/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class SideMenuHakkinda: UIViewController {
    
    
    
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 750)
     
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
    
    
    let lbl1 : UILabel = {
       let lbl = UILabel()
        //lbl.text =  "Renty,paylaşım ve doğayı seven bir grup üniversite öğrencisi tarafından oluşturulan henüz çok yeni,paylaşım ekonimisi tabanlı bir online alışveiş platformu. Daha yaşlanılabilir ve sosyal dengelerin olduğu bir Dünya için sizin de katkılarınızla sağlam adımlarla büyümeyi hedefliyoruz.Daha şimdiden fikir aşamasında katıldığı OTDÜ Teknokent YFYİ yarışmasından finalinde 2 ödül birden kazandı bile."
        lbl.text =       "Renty paylaşımı ve doğayı seven bir grup üniversite öğrencisi tarafından oluşturulan henüz çok yeni, paylaşım ekonomisi tabanlı bir online alışveriş platformu. Daha yaşanılabilir ve sosyal dengelerin olduğu bir Dünya için sizin de katkılarınızla sağlam adımlarla büyümeyi hedefliyoruz. Daha şimdiden fikir aşamasında katıldığı ODTÜ Teknokent YFYİ yarışmasının finalinde 2 ödül birden kazandı bile.\n\nNedir? \n\nRenty, üniversite öğrencilerinin ek gelir elde etme imkanı bulabileceği aynı zamanda uygun fiyata gerekli eşyaları belirli süre temin edebilecekleri için yeni sosyal imkanlar bulabileceği bir pazar yeri uygulamasıdır.\n\nNeler sağlar? \n\n-Bi kenarda duran eşyalarını kiraya vererek ek gelir elde et.\n-İhtiyacın olan eşyaları uygun fiyata başkalarından belirli sürneliğine kirala.\n-Satın almayıp eşya kalabalığından kurtul.\n-Tüketimi azaltıp Dünyanın yeşil kalmasına yardım et.\n\n\nNasıl işler? \n\nBeta sürümünde ödeme yöntemi olmayacak. Sonraki sürümlerde online ödeme yöntemleri, eşyalar için Renty güvencesi, ve lojistik için şehir içi kurye sistemleri olacak. Şuan için eşyalarınızı kiraya verdiğinizde bir kimlik kartı vs. almanızı tavsiye ediyoruz. Sistem şöyle çalışıyor; eşyalarını kiralamak için eklenen ürünlerden ihtiyacınız olanına tıklıyorsunuz. Eşyanın sayfasında sepete ekle butonuna tıklıyorsunuz. Kiralamak istediğiniz tarih aralığını seçiyorsunuz (ilki alacağınız ikincisi teslime edeceğiniz tarih, 25 aralık-26 aralık seçerseniz 1 günlük kiralanır) sonrasında ürün sahibi satış sayfasından eşyanın kırık, yırtık, eksik bir parçası var ise onları giriyor. Ürün sahibine mesaj atıp nereden ürünü alacağınızı vs. soruyorsunuz (eşya sahibinin evinden alınıp kullanıldıktan sonra tekrar evine bırakmak eşyayı alanın sorumluluğundadır). Eşyayı almaya gittiğinizde satış sayfasından ürünü aldığınızı onaylayan butona bastıktan sonra ürün sahibi eşyayı teslim ediyor. Sonra eşyayı geri getirdiğinizde ürün sahibi eşyayı geri aldım butonuna tıkladıktan sonra eşyayı geri teslim ediyorsunuz (yok geri getirdi getirmedi eşyayı bana hiç vermedi gibi sorunlar oluşmasın diye) ve alışveriş tamamlanıyor. Eşyaları pazara eklerken günlük ücretini girmenizi istiyoruz. Ve ürün kiralanırken 1 gün kiralanırsa girdiğiniz tutar oluyor ücreti ama birden fazla gün kiralandığında ücreti belirli oranda düşüyor. Yani daha fazla gün kiralarsanız daha uyguna gelmiş oluyor. Kiralama süresince eşyanın başına bir şey gelmemesi alıcının sorumluluğundadır.\n "
        lbl.textColor = .white
        lbl.numberOfLines = 100
        return lbl
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutDuzenle()
 //backgraoundGradient()
       
        
        let logo = UIImage(named: "hakkimizda")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    
    func layoutDuzenle() {
        backgraoundGradient()
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        containerView.addSubview(lbl1)
        
        
        _ = lbl1.anchor(top: containerView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        
    }
    
    
    @IBAction func leftBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    fileprivate func backgraoundGradient() {
        let gradient = CAGradientLayer()
        let ustRenk = #colorLiteral(red: 0, green: 0.1490196078, blue: 0.1019607843, alpha: 1)
        let alrRenk = #colorLiteral(red: 0.01568627451, green: 0.5490196078, blue: 0.3882352941, alpha: 1)
        gradient.colors = [ustRenk.cgColor,alrRenk.cgColor]
        gradient.locations = [0,1]
        containerView.layer.addSublayer(gradient)
        gradient.frame = containerView.bounds
    }
    

}


