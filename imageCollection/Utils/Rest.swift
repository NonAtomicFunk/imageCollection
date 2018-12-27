//
//  Rest.swift
//  imageCollection
//
//  Created by admin2 on 12/21/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class Rest {
    static let shared = Rest()
    
    let aSessionManager = Alamofire.SessionManager()
    fileprivate var storedToken: [String: String]! // = ["token": ""]
    let isUpdating = Variable<Bool>(false)

    public func getAll(_ completionHandler: @escaping ([IcCellDataModel]) -> Void) -> [IcCellDataModel] {
        print("tokem header: ", self.storedToken, "@Ends roken")
        let strUrl = Constants().baseURL+GetType.all.rawValue
        let url = URL(string: strUrl)!
        print("Get all url: ", strUrl)
        
        self.aSessionManager.request(url,
                                     method: .get,
                                     parameters: nil,
                                     encoding: JSONEncoding.default,
                                     headers: self.storedToken!).responseJSON { response in
            print("getAll response: ", response.result.value, "@Ends getAll")
                                        
            let decoder = JSONDecoder()
    //        do {
    //            let decoded = try decoder.decode([IcCellDataModel].self, from: data)
    //            print(decoded[0].weather)
    //        } catch {
    //            print("Failed to decode JSON")
    //        }
                                        do {
//                                            let parsedResults: IcCellDataModel = try! decoder.decode([IcCellDataModelList].self, from: response.result.value as! Data)
                                            let parsedResults: IcCellDataModelList = try! decoder.decode(IcCellDataModelList.self, from: response.result.value as! Data)
                                            print(parsedResults.images)
//                                            completionHandler([parsedResults])
                                        }
        }
        
        return []
    }
    
    func postImage(imageData: Data,
                   description: String,
                   hashtag: String,
                   latitude: Double,
                   longitude: Double,
                   fileName: String,
                   fileExtension: String/*,
                   completionHandler: @escaping Void*/) {
        
        let paramz = ["description": description,
                      "hashtag": hashtag,
                      "latitude": String(describing: latitude),
                      "longitude": String(describing: longitude)]
        
        let strUrl = Constants().baseURL+GetType.postImage.rawValue
        let url = URL(string: strUrl)!
        
        self.aSessionManager.upload(multipartFormData: { (multipart) in
            multipart.append(imageData, withName: "image", fileName: fileName, mimeType: fileExtension)
            for (key, value) in paramz {
                multipart.append(value.data(using: .utf8)!, withName: key)
            }
        },
                                    usingThreshold: UInt64.init(),
                                    to: url,
                                    method: .post,
                                    headers: self.storedToken!,
                                    queue: nil) { (resuleEncoded) in
                                        
                                        switch resuleEncoded {
                                        case .success(let upload, _, _):
                                            
                                            
                                            upload.responseJSON { response in
                                                print(response.result.value)
                                            }
                                            VCRouter.singltone.popBack()
                                            return
                                            
                                        case .failure(let error):
                                            print("error in uploading image: ", error)
                                        }
        }
        
    }
    
    
    func authorisation(loginOption: LoginOptions,
                       userName: String,
                       email: String?,
                       password: String,
                       imageData: Data?) {
        
        self.isUpdating.value = true
        defer {self.isUpdating.value = false}
        
        var paramz: [String: String]!
        
        let urlComponent = loginOption.rawValue
        let strUrl = Constants().baseURL+urlComponent
        let url = URL(string: strUrl)!
        
        print("Login option? : ", loginOption)
        
        switch loginOption {
        case .login:
            
            paramz = [:]
            paramz = ["email": email!,
                      "password": password]
            
            self.aSessionManager.request(url,
                                         method: .post,
                                         parameters: paramz,
                                         encoding: JSONEncoding.default,
                                         headers: nil).responseJSON { response in
                do {
                    response.result.withValue({ (resultRaw) in
                        if let rawDict = resultRaw as? [String: String] {
                            let token = rawDict["token"]
                            self.storedToken = ["token": token!]
                            print("!!! WE GOT TOKEN", token!, "header: ", self.storedToken)
//                            self.storedToken.updateValue(token!, forKey: "token")
                            if token != nil {
                                defer {VCRouter.singltone.pushMarkerVC(.picturesLisVC)}
                            }
                        }
                    })
                }
            }
            
        case .auth:
            
            paramz = [:]
            
            paramz = ["username": userName,
                      "email": email!,
                      "password": password]
            
            self.aSessionManager.upload(multipartFormData: { (multipartFromData) in
                guard imageData != nil else {
                    print("image data is nil")
                    return
                }
                
                multipartFromData.append(imageData!, withName: "avatar", fileName: "avatarPic", mimeType: "jpeg")
                
                for (key, value) in paramz {
                    multipartFromData.append(value.data(using: .utf8)!, withName: key)
                    
                }
            },
            to: url) { (mpEncodingResult) in
                
                switch mpEncodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in

                        do {
                            response.result.withValue({ (resultRaw) in
                                if let rawDict = resultRaw as? [String: String] {
                                    let token = rawDict["token"]
                                    self.storedToken = ["token": token!]
                                    print("WE GOT TOKEN", token!, "header: ", self.storedToken)
//                                    self.storedToken.updateValue(token!, forKey: "token")
                                    VCRouter.singltone.pushMarkerVC(.picturesLisVC)
                                }
                            })
                        }
                        }
                        .uploadProgress { progress in
                            
                            print("Upload Progress: \(progress.fractionCompleted)")
                    }
                    return
                case .failure(let encodingError):
                    
                    print("ERROR in Mulrypart: ", encodingError)
                }
            }
        }
    }
}

