//
//  LoginlVM.swift
//  imageCollection
//
//  Created by admin2 on 12/21/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class LoginlVM: BaseVM {
    
    let bag = DisposeBag()
    
    public var storedImage = Variable<UIImage>(UIImage(named: "take-a-photo")!)
    let userName = Variable<String>("")
    let email = Variable<String>("")
    let password = Variable<String>("")
    let loginOptionChosen = Variable<LoginOptions>(.auth)
    
    func login() {
        if let data = self.storedImage.value.jpegData(compressionQuality: 0.85) {
            
            Rest.shared.authorisation(loginOption: self.loginOptionChosen.value,
                                      userName: self.userName.value,
                                      email: self.email.value,
                                      password: self.password.value,
                                      imageData: data)
//            defer {
//                if Rest.shared.isUpdating.value == false && Rest.shared.storedToken["token"] != "" {
//                    VCRouter.singltone.pushMarkerVC(.picturesLisVC)
//                }
                
//            }
        }
    }
}

//ImagePicker logic
extension LoginlVM {
    
    func presentActionSheet(_ vc: LoginlVC) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.pickCamera(vc)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.pickPhotoLibrary(vc)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    
    func pickCamera(_ vc: LoginlVC) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = vc
            myPickerController.sourceType = .camera
            vc.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func pickPhotoLibrary(_ vc: LoginlVC) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = vc
            myPickerController.sourceType = .photoLibrary
            vc.present(myPickerController, animated: true, completion: nil)
        }
    }
}
