//
//  OriginalVC.swift
//  imageCollection
//
//  Created by admin2 on 12/20/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginlVC: UIViewController {

    var viewModel: LoginlVM!
    
    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passWordTxtFld: UITextField!
    
    @IBOutlet weak var confirmPassWordTxtLfld: UITextField!
    @IBOutlet weak var avatarBtn: UIButton!
    @IBOutlet weak var dropAvatarBtn: UIButton!
    
    @IBOutlet weak var matchWarningLbl: UILabel!
    
    @IBOutlet weak var loginOptionsSwitcher: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginlVM()
        self.uiSetup()
        self.bindAll()
    }
    
    func uiSetup() {
        self.dropAvatarBtn.setImage(UIImage(named: "closeIcon"), for: .normal)
        
        self.matchWarningLbl.isHidden = false
        self.loginOptionsSwitcher.setTitle("Login", forSegmentAt: 0)
        self.loginOptionsSwitcher.setTitle("Register", forSegmentAt: 1)
    }
    
    func bindAll() {
        
        self.userNameTxtFld.rx.text.orEmpty.bind(to: self.viewModel.userName)
            .disposed(by:self.viewModel.bag)
        self.emailTxtFld.rx.text.orEmpty.bind(to: self.viewModel.email)
            .disposed(by:self.viewModel.bag)
        self.passWordTxtFld.rx.text.orEmpty.bind(to: self.viewModel.password)
            .disposed(by:self.viewModel.bag)
        
        
        self.loginOptionsSwitcher.rx.selectedSegmentIndex.subscribe { indexSelected in
            print(indexSelected)

            self.navigationItem.title = self.loginOptionsSwitcher.titleForSegment(at: indexSelected.element ?? 0)
        }.disposed(by: self.viewModel.bag)
        
        self.viewModel.storedImage.asObservable().subscribe{ imageChange in
            self.avatarBtn.setImage(self.viewModel.storedImage.value, for: .normal)
            
            if self.viewModel.storedImage.value == UIImage(named: "take-a-photo") {
                self.dropAvatarBtn.isHidden = true
                self.dropAvatarBtn.isUserInteractionEnabled = false
            } else {
                self.dropAvatarBtn.isHidden = false
                self.dropAvatarBtn.isUserInteractionEnabled = true
            }
            
            }.disposed(by: self.viewModel.bag)
        
        self.dropAvatarBtn.rx.tap.subscribe { _ in
            self.viewModel.storedImage.value = UIImage(named: "take-a-photo")!
            self.dropAvatarBtn.isHidden = true
            self.dropAvatarBtn.isUserInteractionEnabled = true
        }.disposed(by: self.viewModel.bag)
        
        //picking image action
        self.avatarBtn.rx.tap
            .subscribe { tap in
                self.viewModel.presentActionSheet(self)
        }.disposed(by: self.viewModel.bag)
        
        //pass and confirmPass MATCHING logic:
        self.confirmPassWordTxtLfld.rx.controlEvent(UIControlEvents.editingDidEnd).subscribe { _ in
            if self.confirmPassWordTxtLfld.text! != self.passWordTxtFld.text! {
                self.matchWarningLbl.isHidden = false
            }
        }
        
        //scroll up TODO
//        self.passWordTxtFld.rx.didBeginEditing.subscribe({ n in
//
//        }).disposed(by: self.vm.bag)
//        self.passWordTxtFld.rx.didEndEditing.subscribe { _ in
//
//        }.disposed(by: self.vm.bag)
    }
}

// image and camera pickers logic goes here
extension LoginlVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        self.viewModel.storedImage.value = pickedImage
        dismiss(animated: true, completion: nil)
    }
}
