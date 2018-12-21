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

    public func getAll(loginOptionChosen: LoginOptions,
                       userName: String,
                       email: String?,
                       password: String,
                       imageData: Data?) {
        
    }
    
    
    func authorisation(_ loginOption: LoginOptions) {
        var params: [String: Any] = [:]
        
        let urlComponent = loginOption.rawValue
        let strUrl = Constants().baseURL+urlComponent
        let url = URL(string: strUrl)!
        
        switch loginOption {
        case .auth:
            params = ["username": "?",
                      "email": "!",
                      "password": "!",
                      "avatar": "imageData!"]
            
        case .login:
            params = ["email": "!",
                      "password": "!"]
        }
        
        Alamofire.request(url).responseJSON { response in
            print(response)
        }
    }
}
