//
//  Kategoriler.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/7/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit



class Kategoriler: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    
    let estimateWidth = 160
       var cellMarginSize = 16.0
    
    
    var secilenIndex = 0
    var selectedcategoryname = ""
    
    let data = ["Kamp Malzemeleri","Kutu Oyunları","Elektronik Eşyalar","Spor Ekipmanı","Tamir Aletleri","Kıyafet","Enstrüman","Diğer","Açık Kütüphane"]
    
    let data2 = [UIImage(named: "camp"),UIImage(named: "kutuoyunlari"),UIImage(named: "elektronik"),UIImage(named: "spor"),UIImage(named: "tamir"),UIImage(named: "kiyafet"),UIImage(named: "enstruman"),UIImage(named: "diger"),UIImage(named: "kutuphane")]
    
    let data3 = [UIColor.rgb(red: 4, green: 140, blue: 99),UIColor.rgb(red: 112, green: 182, blue: 44),UIColor.rgb(red: 201, green: 213, blue: 51),UIColor.rgb(red: 4, green: 140, blue: 99),UIColor.rgb(red: 112, green: 182, blue: 44),UIColor.rgb(red: 201, green: 213, blue: 51),UIColor.rgb(red: 4, green: 140, blue: 99),UIColor.rgb(red: 112, green: 182, blue: 44),UIColor.rgb(red: 201, green: 213, blue: 51)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "UrunEkleCell", bundle: nil), forCellWithReuseIdentifier: "UrunEkleCell")
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   //layout.itemSize = CGSize(width: 167, height: 249)
                   
                   layout.minimumLineSpacing = CGFloat(self.cellMarginSize)
                   layout.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
               }
            
        
    }

    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
//        //return CGSize(width: 144, height: 169.1)
//    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return self.data.count
        }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UrunEkleCell", for: indexPath) as! UrunEkleCell
        cell.setData(text: data[indexPath.row], img: self.data2[indexPath.row]!, color: data3[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
        
       performSegue(withIdentifier: "urun", sender: self)

    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "urun" {
            let desVC = (segue.destination as! UINavigationController).viewControllers[0] as! KategoriyeGoreUrun
            desVC.itemcategory = selectedcategoryname
        }


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
