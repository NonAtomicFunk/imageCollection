//
//  UploadNewPicVM.swift
//  imageCollection
//
//  Created by admin2 on 12/23/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation

final class UploadNewPicVM: BaseVM {
    
    let bag = DisposeBag()
    
    let storeImage = Variable<UIImage>(UIImage(named: "taking-a-shot")!)
    let descrToPass = Variable<String>("")
    let hashagToPass = Variable<String>("")
    let coords = Variable<[CLLocation]>([])
    
    func uploadImage() {
        
        let dataToPass = self.storeImage.value.jpegData(compressionQuality: 0.85)
        
        Rest.shared.postImage(image: dataToPass!,
                              description: self.descrToPass.value,
                              hashtag: self.hashagToPass.value,
                              latitude: self.coords.value.last!.coordinate.latitude,
                              longitude: self.coords.value.last!.coordinate.longitude)
    }
}

//ImagePicker logic
extension UploadNewPicVM {
    
    func presentActionSheet(_ vc: UploadNewPicVC) {
        
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
    
    
    func pickCamera(_ vc: UploadNewPicVC) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = vc
            myPickerController.sourceType = .camera
            vc.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func pickPhotoLibrary(_ vc: UploadNewPicVC) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = vc
            myPickerController.sourceType = .photoLibrary
            vc.present(myPickerController, animated: true, completion: nil)
        }
    }
}
