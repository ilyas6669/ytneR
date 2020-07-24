//
//  SideMenuGeriBildirim.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/16/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import MessageUI

class SideMenuGeriBildirim: UIViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        openGmail()

        
   


}
    
    func openGmail() {
        
        guard MFMailComposeViewController.canSendMail() else {
            makeAlertt(tittle: "Geri Bildirim", message: "Bu eylemi hiç bir uyuhgulama gerçekleştiremez")
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["test@gmail.com"])
        composer.setSubject("Hata")
        
        present(composer, animated: true, completion: nil)
        
    }
    
    
    @IBAction func leftAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension SideMenuGeriBildirim  : MFMailComposeViewControllerDelegate{
    
}
