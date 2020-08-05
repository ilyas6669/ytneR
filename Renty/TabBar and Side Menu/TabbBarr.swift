//
//  TabbBarr.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/29/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class TabbBarr: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .white
        
    }
    
    func sendnotification(userid:String,title:String,body:String){
           //bidene rentydekini yoxla bildirimi gozde
           let tokenRef = Database.database().reference().child("Tokens").child(userid)
           tokenRef.observeSingleEvent(of: .value, with: { (snapshot) in
               let value = snapshot.value as? NSDictionary
               
               let token = value?["token"] as? String ?? ""
               
               let sender = PushNotificationSender()
               sender.sendPushNotification(to: token,title: title,body: body)
               
           }) { (error) in
               print(error.localizedDescription)
           }
       }
    

    

}
