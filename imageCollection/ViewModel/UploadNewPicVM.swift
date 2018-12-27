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
    let coords = Variable<[CLLocation]>([]) //Can't figure out how to get Photo's gep tag as ALAssetsLibrary has been deprecated in Swift 4, and i kinda missed that
    
    func uploadImage() {
        
        let assetName = "asset_"+String(describing: Date())
        
        print("ASSET NAME: ", assetName)
        print("coords? ", coords.value.first!.coordinate.latitude)
        let dataToPass = self.storeImage.value.jpegData(compressionQuality: 0.5)
        
        Rest.shared.postImage(imageData: dataToPass!,
                              description: self.descrToPass.value,
                              hashtag: self.hashagToPass.value,
                              latitude: self.coords.value.first!.coordinate.latitude,
                              longitude: self.coords.value.first!.coordinate.longitude,
                              fileName: assetName,
                              fileExtension: "JPG"/*,
                              completionHandler: VCRouter.singltone.popBack()*/)
        
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
