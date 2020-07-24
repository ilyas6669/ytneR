//
//  UserClass.swift
//  Renty
//
//  Created by İlyas Abiyev on 3/12/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class UserClass {
    
    var userid = ""
    var namesurname = ""
    
    init(snap: DataSnapshot) {

        let userDict = snap.value as! [String: Any]

        self.userid = userDict["userid"] as! String
        self.namesurname = userDict["namesurname"] as! String

     
    }
}
