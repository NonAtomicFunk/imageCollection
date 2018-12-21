//
//  Rest.swift
//  imageCollection
//
//  Created by admin2 on 12/21/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import RxSwift
import RxCocoa

class Rest {
    static let shared = Rest()

    public func getAll(/*loginOptionChosen: LoginOptions,
                       userName: String,
                       email: String?,
                       password: String,
                       imageData: Data?*/) {
    }
    
    
    func authorisation(loginOption: LoginOptions,
                       userName: String,
                       email: String?,
                       password: String,
                       imageData: Data?) {
        
        var params: [String: Any] = [:]
        
        let urlComponent = loginOption.rawValue
        let strUrl = Constants().baseURL+urlComponent
        let url = URL(string: strUrl)!
        
        switch loginOption {
        case .auth:
            params = ["username": userName,
                      "email": email!,
                      "password": password,
                      "avatar": imageData!]
            
        case .login:
            params = ["email": email,
                      "password": password]
        }
        
        
//        Alamofire.request(url).responseJSON { response in
        
        Alamofire.request(url,
                          method: HTTPMethod.post,
                          parameters: params!,
                          encoding: .jsonEncoding,
                          headers: nil).responseJSON { response in
            print("RESPONSE: ", response, "@ends Response. \n resose result value", response.result.value)
        }
    }
}
