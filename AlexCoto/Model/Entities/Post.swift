//
//  Post.swift
//  AlexCoto
//
//  Created by Alexander Coto on 23/11/22.
//

import Foundation

class Post:NSObject {
    var postId:Int = -1
    var title:String = ""
    var body:String = ""
    var userId:Int = -1
    var favorite:Bool = false
    
    func populateWithDict(_ dict:[String:Any]) {
        self.title = (dict["title"] as? String) ?? ""
        self.body = (dict["body"] as? String) ?? ""
        self.userId = (dict["userId"] as? Int) ?? -1
        self.postId = (dict["id"] as? Int) ?? -1
    }
}
