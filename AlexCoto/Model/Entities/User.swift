//
//  User.swift
//  AlexCoto
//
//  Created by Alexander Coto on 23/11/22.
//

import Foundation

class User: NSObject {
    var userId:Int? = -1
    var name:String? = ""
    var username:String? = ""
    var email:String? = ""
    var address:Address? = nil
    var phone:String = ""
    var website:String = ""
    var companyName:String = ""
    var companyMotto:String = ""
    var companyBS:String = ""
    
    func populateWithDict(_ dict:[String:Any]) {
        self.name = (dict["name"] as? String) ?? ""
        self.username = (dict["username"] as? String) ?? ""
        self.email = (dict["email"] as? String) ?? ""
        self.phone = (dict["phone"] as? String) ?? ""
        let addressDict = dict["address"] as? [String:Any] ?? [:]
        self.address = Address()
        self.address?.street = (addressDict["street"] as? String) ?? ""
        self.address?.city = (addressDict["city"] as? String) ?? ""
        let companyDict = dict["company"] as? [String:Any] ?? [:]
        self.companyName = (companyDict["name"] as? String) ?? ""
    }
}
