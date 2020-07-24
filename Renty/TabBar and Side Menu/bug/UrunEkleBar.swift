//
//  UrunEkleBar.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

struct CustomData {
    var label : String
    var image : UIImage
    
}

class UrunEkleBar: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var secilenIndex = 0
    var selectedcategoryname = ""
    
    let data = ["Kamp Malzemeleri","Kutu Oyunları","Elektronik Eşyalar","Spor Ekipmanı","Tamir Aletleri","Kıyafet","Enstrüman","Diğer","Açık Kütüphane"]
    
    let data2 = [UIImage(named: "camp"),UIImage(named: "kutuoyunlari"),UIImage(named: "elektronik"),UIImage(named: "spor"),UIImage(named: "tamir"),UIImage(named: "kiyafet"),UIImage(named: "enstruman"),UIImage(named: "diger"),UIImage(named: "kutuphane")]
    
    let data3 = [UIColor.rgb(red: 4, green: 140, blue: 99),UIColor.rgb(red: 112, green: 182, blue: 44),UIColor.rgb(red: 201, green: 213, blue: 51),UIColor.rgb(red: 4, green: 140, blue: 99),UIColor.rgb(red: 112, green: 182, blue: 44),UIColor.rgb(red: 201, green: 213, blue: 51),UIColor.rgb(red: 4, green: 140, blue: 99),UIColor.rgb(red: 112, green: 182, blue: 44),UIColor.rgb(red: 201, green: 213, blue: 51)]
    
    let img = UIImageView(image: #imageLiteral(resourceName: "lineurunekle"))

    let lbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Kategori Seç"
        lbl.textColor = .white
        return lbl
    }()
    
    
    let estimateWidth = 160
    var cellMarginSize = 16.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layouDuzenle()
        let logo = UIImage(named: "Component 1 – 1")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
     
       
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "UrunEkleCell", bundle: nil), forCellWithReuseIdentifier: "UrunEkleCell")
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //layout.itemSize = CGSize(width: 167, height: 249)
            
            layout.minimumLineSpacing = CGFloat(self.cellMarginSize)
            layout.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        }
        
    }
    
    func layouDuzenle() {
    view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        
    view.addSubview(img)
    view.addSubview(lbl)
               
    img.heightAnchor.constraint(equalToConstant: 22).isActive = true
    _ = img.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 15, left: 10, bottom: 0, right: 10))
    _ = lbl.anchor(top: img.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 13, bottom: 0, right: 0))
        
    }
    
   
    
    

}


extension UrunEkleBar : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 144, height: 169.1)
//    }
//
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UrunEkleCell", for: indexPath) as! UrunEkleCell
        cell.setData(text: data[indexPath.row], img: self.data2[indexPath.row]!, color: data3[indexPath.row])
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        secilenIndex = indexPath.row
        
        switch secilenIndex {
        case 0:
            selectedcategoryname = "kampmalzemeleri"
        case 1:
            selectedcategoryname = "kutuoyunlari"
        case 2:
            selectedcategoryname = "elektronik"
        case 3:
            selectedcategoryname = "sporekipmani"
        case 4:
            selectedcategoryname = "tamiraletleri"
        case 5:
            selectedcategoryname = "kiyafet"
        case 6:
            selectedcategoryname = "enstruman"
        case 7:
            selectedcategoryname = "diger"
        case 8:
            selectedcategoryname = "kitap"
        default:
            selectedcategoryname = "null"
        }
        
        performSegue(withIdentifier: "fotorafEkle", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fotorafekle : FotorafEkle1 = segue.destination as! FotorafEkle1
        fotorafekle.itemcategory = selectedcategoryname

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = self.calculateWith()
        return CGSize(width: width, height: width)
       }
       
       func calculateWith() -> CGFloat {
           let estimadeWidth = CGFloat(estimateWidth)
           let cellCount = floor(CGFloat(self.view.frame.size.width / estimadeWidth))
           let margin = CGFloat(cellMarginSize * 2)
           let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
           return width
       }
    
}


