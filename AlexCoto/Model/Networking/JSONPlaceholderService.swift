//
//  JSONPlaceholderService.swift
//  AlexCoto
//
//  Created by Alexander Coto on 23/11/22.
//

import Foundation
import Alamofire

class JSONPlaceholderService:NSObject {
    fileprivate static var instance = JSONPlaceholderService()
    fileprivate var host = "https://jsonplaceholder.typicode.com/"
    var baseUrl: URL {
        return URL(string: self.host)!
    }
    let sessionManager = Alamofire.Session.default
    
    static func sharedService() -> JSONPlaceholderService {
        return JSONPlaceholderService.instance
    }
    
    func requestWithPath(_ path: String, method: String = "GET", completion:@escaping (Alamofire.DataResponse<Any, AFError>) -> Void) {
        if let url = URL(string: path, relativeTo: self.baseUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            self.sessionManager.request(request).responseJSON(completionHandler: completion)
        }
    }
}
