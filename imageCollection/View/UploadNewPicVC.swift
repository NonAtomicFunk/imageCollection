//
//  UploadNewPicVC.swift
//  imageCollection
//
//  Created by admin2 on 12/20/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import UIKit
import CoreLocation

class UploadNewPicVC: BaseVC {

    @IBOutlet weak var photoBtn: UIButton!
    @IBOutlet weak var descrTxtFld: UITextField!
    @IBOutlet weak var heshTagTxtFld: UITextField!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationSetup()
        self.imagePickerSetup()
        self.setupNav()
        self.bindAll()
    }
    
    func locationSetup() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func imagePickerSetup() {
        // picker delegate
        self.photoBtn.rx.tap
            .subscribe { [weak self] tap in
                (self!.viewModel as! UploadNewPicVM).presentActionSheet(self!)
            }.disposed(by: (self.viewModel as! UploadNewPicVM).bag)
    }

    func setupNav() {
        let checkBtn = UIBarButtonItem(image: UIImage(named: "check-icon")!,
                                       style: .plain,
                                       target: self,
                                       action: #selector(self.checkBtnTapped))
        checkBtn.tintColor = .black
        self.navigationItem.rightBarButtonItem = checkBtn
    }
    
    func bindAll() {
        
    }
    
    @objc func checkBtnTapped() {
        (self.viewModel as! UploadNewPicVM).uploadImage()
    }
}

extension UploadNewPicVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        (self.viewModel as! UploadNewPicVM).storeImage.value = pickedImage
        dismiss(animated: true, completion: nil)
    }
}

extension UploadNewPicVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.first!
        (self.viewModel as! UploadNewPicVM).coords.value.append(location)
    }
}
