

import UIKit
import Firebase
import SystemConfiguration

class SplahView: UIViewController {
    
    let logo : UIImageView = {
        let logo = UIImageView(image: #imageLiteral(resourceName: "rentylogo"))
        logo.contentMode = .scaleAspectFill
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.heightAnchor.constraint(equalToConstant: 140).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 230).isActive = true
        return logo
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgraoundGradient()
        view.addSubview(logo)
        
            //        try! Auth.auth().signOut()
        
        
    
        
        if InternetConnectionManager.isConnectedToNetwork(){
            
            if Auth.auth().currentUser != nil { //kayit olunubsa
                
                
                let userID = Auth.auth().currentUser?.uid
                
                let userRef = Database.database().reference().child("user").child(userID!)
                
                userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let accountcomplete = value?["accountcomplete"] as? String ?? ""
                    let blockedadmin = value?["blockedadmin"] as? String ?? ""
                    
                    
                    if(blockedadmin == "false"){//kullanici engellenmemisse
                        
                        if(accountcomplete == "false"){ //profil tamamlanmamissa
                            
                            let profilTamamla = ProfiliTamamlaViewController()
                            profilTamamla.modalPresentationStyle = .fullScreen
                            self.present(profilTamamla, animated: true, completion: nil)
                            
                        }else{
                            
                            let sehir = value?["sehir"] as? String ?? ""
                            Cache.usersehir = sehir
                            //sehir deyistirme yeri haradi ? 
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "TabbBar") as! TabbBarr
                            vc.selectedIndex = 0
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                            
                            
                            
                        }
                        
                    }else{ //kullanici engellenmisse
                        
                        let blockedVieww = BlackedView()
                        blockedVieww.modalPresentationStyle = .fullScreen
                        self.present(blockedVieww, animated: true, completion: nil)
                        
                        
                    }
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
                
                
            } else { //kayit olunmuyubsa
                
                perform(#selector(toGecisControllerr), with: nil,afterDelay: 2)
            }
            
            
            
            
        }else{ //internet yok
            makeAlert(tittle: "Hata", message: "İnternet bağlantınız yok. Lütfen kontrol ediniz.")
        }
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        _ = logo.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 60, bottom: 0, right: 60))
        
    }
    
    
    @objc func toGecisControllerr() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let signUp = GecisController(collectionViewLayout: layout)
        signUp.modalPresentationStyle = .fullScreen
        
        present(signUp, animated: true, completion: nil)
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
    
}


