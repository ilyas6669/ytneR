//
//  Chat.swift
//  Renty
//
//  Created by İlyas Abiyev on 4/22/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit

struct Chat {
var users: [String]
var dictionary: [String: Any] {
return ["users": users]
   }
}

extension Chat {
init?(dictionary: [String:Any]) {
guard let chatUsers = dictionary["users"] as? [String] else {return nil}
self.init(users: chatUsers)
}
}
