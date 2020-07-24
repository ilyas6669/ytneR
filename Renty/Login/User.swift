//
//  User.swift
//  Renty
//
//  Created by İlyas Abiyev on 2/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation

class Userrr {
        
    private(set) var userid : String!
    private(set) var accountcomplete : String!
    private(set) var email : String!
    private(set) var namesurname : String!
    private(set) var profilepicture : String!
    private(set) var userrate : String!
    private(set) var sehir : String!
    private(set) var il : String!
     private(set) var acikadres : String!
     private(set) var phonenumber : String!
     private(set) var blockedadmin : String!
     private(set) var signupdate : String!
    private(set) var signupdateint : Int!
    private(set) var signupdatestring : String!
    

  
    
    init(userid: String, accountcomplete : String, email : String,namesurname : String, profilepicture : String,userrate: String,sehir:String,il:String, acikadres:String,phonenumber:String,blockedadmin:String,signupdate:String,signupdateint:Int,signupdatestring:String){
        
        
        
        self.userid = userid
        self.accountcomplete = accountcomplete
        self.email = email
        self.namesurname = namesurname
        self.profilepicture = profilepicture
        self.userrate = userrate
        self.sehir = sehir
        self.il = il
        self.acikadres = acikadres
        self.phonenumber = phonenumber
        self.blockedadmin = blockedadmin
        self.signupdate = signupdate
        self.signupdateint = signupdateint
        self.signupdatestring = signupdatestring
        
    }
    
}


