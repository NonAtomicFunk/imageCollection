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
        
//        var params: [String: Any] = [:]
        var paramz: [String: String]!
        
        let urlComponent = loginOption.rawValue
        let strUrl = Constants().baseURL+urlComponent
        let url = URL(string: strUrl)!
        
        switch loginOption {
        case .auth:
            
            paramz = [:]

            guard let dataSrtEncoded = imageData?.base64EncodedString() else {
                print("data is not converted")
                return
            }
            
            paramz = ["username": userName,
                      "email": email!,
                      "password": password,
                      "avatar": dataSrtEncoded]
            
        case .login:
            
            paramz = [:]
            paramz = ["email": email!,
                      "password": password]
        }
        
        Alamofire.upload(multipartFormData: { (multipartFromData) in
            guard imageData != nil else {
                print("image data is nil")
                return
            }
            multipartFromData.append(imageData!, withName: "avatar")
            
            //HARD CODE FORTEST
//            multipartFromData.append(publiclyStoredImage.jpegData(compressionQuality: 0.85)!, withName: "avatar")
            
            
            for (key, value) in paramz {
//                multipartFromData.append(, withName: key)
                multipartFromData.append(value.data(using: .utf8)!, withName: key)
                
            }
        },
                         to: url) { (mpEncodingResult) in
                            
                            switch mpEncodingResult {
                            case .success(let upload, _, _):
                                upload.responseString { response in
                                    debugPrint(response)
                                    }
                                    .uploadProgress { progress in //has to go in main queue by default
                                        
                                        print("Upload Progress: \(progress.fractionCompleted)")
                                }
                                return
                            case .failure(let encodingError):
                                
                                print("ERROR in Mulrypart: ", encodingError)
                            }
        }
    }
        
//        Alamofire.request(url, method: .post, parameters: paramz, encoding: JSONEncoding.default, headers: nil).responseJSON {(response) in
//                        print(response)
//                    }
        
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(imageData!, withName: "avatar")
//
//            for (key, value) in paramz {
//                multipartFormData.append(value.data(using: .utf8)!, withName: key)
//            }
//        }, usingThreshold: UInt64.init(),
//           to: url,
//           method: .post,
//           headers: nil) { (response) in
//
//            switch response {
//            case .success(let upload, _, _):
//
//                upload.responseJSON { response in
//
//                    print("request: ", response.request, "@nds")  // original URL request
//                    print("response: ", response.response, "@nds") // URL response
//                    print("data: ", response.data, "@nds")     // server data
//                    print("result: ", response.result, "@nds")   // result of response serialization
//
//                    if let JSON = response.result.value {
//                        print("JSON: \(JSON)")
//                    }
//                }
//
//            case .failure(let encodingError):
//                //self.delegate?.showFailAlert()
//                print(encodingError, "oh really?! MP error")
//            }
//        }
        
//        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON {(response) in
//            print(response)
//        }
        
//        Alamofire.request(url).responseJSON { response in
        
//        Alamofire.request(url, method: .post, parameters: params, encoding: .JSONEncoding.default, headers: nil).responseJSON{ (response) in
//            if response.result.isSuccess {
//                print(response)
//            } else {
//                print(response)
//            }
//        }
}

