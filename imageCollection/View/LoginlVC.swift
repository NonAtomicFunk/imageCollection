//
//  LoginlVC.swift
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
    
    @IBOutlet weak var okBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginlVM()
        
        self.hardCode()
        
        self.bindAll()
        self.hideKeyBoard()
        self.uiSetup()
    }
    
    func hardCode() {
        self.userNameTxtFld.text = "userName"
        self.emailTxtFld.text = "email@user.com"
        self.passWordTxtFld.text = "pass"
        self.confirmPassWordTxtLfld.text = "pass"
    }
    
    func uiSetup() {
        self.dropAvatarBtn.setImage(UIImage(named: "closeIcon"), for: .normal)
        
        self.loginOptionsSwitcher.selectedSegmentIndex = 0
        self.matchWarningLbl.isHidden = true
        self.loginOptionsSwitcher.setTitle("Register", forSegmentAt: 0)
        self.loginOptionsSwitcher.setTitle("Login", forSegmentAt: 1)
        
        self.okBtn.layer.cornerRadius = 12
        self.okBtn.backgroundColor = .lightGray
        
        self.emailTxtFld.isHidden = false
        self.emailTxtFld.isUserInteractionEnabled = true
        self.confirmPassWordTxtLfld.isHidden = false
        self.confirmPassWordTxtLfld.isUserInteractionEnabled = true
        self.userNameTxtFld.isHidden = false
        self.userNameTxtFld.isUserInteractionEnabled = true 
        
        avatarBtn.tintColor = .black
        dropAvatarBtn.tintColor = .black
        loginOptionsSwitcher.tintColor = .black
        
        self.avatarBtn.isHidden = false
        self.avatarBtn.isUserInteractionEnabled = true
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
            
            self.userNameTxtFld.isHidden = !self.userNameTxtFld.isHidden
            self.userNameTxtFld.isUserInteractionEnabled = !self.userNameTxtFld.isUserInteractionEnabled
            self.confirmPassWordTxtLfld.isUserInteractionEnabled = !self.confirmPassWordTxtLfld.isUserInteractionEnabled
            self.confirmPassWordTxtLfld.isHidden = !self.confirmPassWordTxtLfld.isHidden
            self.avatarBtn.isHidden = !self.avatarBtn.isHidden
            self.avatarBtn.isUserInteractionEnabled = !self.avatarBtn.isUserInteractionEnabled
            
            if self.loginOptionsSwitcher.selectedSegmentIndex == 1 {
                self.dropAvatarBtn.isHidden = true
                self.dropAvatarBtn.isUserInteractionEnabled = false
                self.viewModel.loginOptionChosen.value = LoginOptions.login
            } else if self.loginOptionsSwitcher.selectedSegmentIndex == 0 && self.avatarBtn.imageView!.image != UIImage(named: "take-a-photo")! {
                self.dropAvatarBtn.isHidden = false
                self.dropAvatarBtn.isUserInteractionEnabled = true
                self.viewModel.loginOptionChosen.value = LoginOptions.auth
            } else if self.loginOptionsSwitcher.selectedSegmentIndex == 0 {
                self.viewModel.loginOptionChosen.value = LoginOptions.auth
            }
            
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
        }.disposed(by: self.viewModel.bag)
        
        //scroll up TODO
//        self.passWordTxtFld.rx.didBeginEditing.subscribe({ n in
//
//        }).disposed(by: self.vm.bag)
//        self.passWordTxtFld.rx.didEndEditing.subscribe { _ in
//
//        }.disposed(by: self.vm.bag)
    }
    
    func hideKeyBoard() {
        
        
    }
    
    @IBAction func okBtnTapped(_ sender: Any) {
        self.viewModel.login()
//        defer {
//            self.viewModel.goto(.picturesLisVC)
//        }
    }
}

// image and camera pickers logic goes here
extension LoginlVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        print("картінка есть ", pickedImage)
        self.viewModel.storedImage.value = pickedImage
        
        defer {
            dismiss(animated: true, completion: nil)
        }
    }
}
