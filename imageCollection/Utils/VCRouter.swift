//
//  VCRouter.swift
//  imageCollection
//
//  Created by admin2 on 12/20/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import UIKit

enum VcType: String {
    
    case picturesLisVC = "PicturesLisVC"
    case uploadNewPicVC = "UploadNewPicVC"
    case gifGeneratorVC = "GifGeneratorVC"
}

final class VCRouter: NSObject {
    
    static let singltone = VCRouter()
    
    var storyBoard: UIStoryboard!
    var navigationSontroller: UINavigationController!
    var window: UIWindow!
    
    override init() {
        super.init()
        
        self.storyBoard = UIStoryboard(name: "Main", bundle: nil)
        self.navigationSontroller = storyBoard.instantiateInitialViewController() as? UINavigationController
        self.navigationSontroller.navigationBar.tintColor = .black
        let uiWindow: UIWindow = UIApplication.shared.delegate!.window!!
        uiWindow.rootViewController = navigationSontroller
    }
    
    
    func pushMarkerVC(_ vc: VcType) {
        print("should go to : ", vc)
        
        let vcToGo: BaseVC!
        
        switch vc {
        case .picturesLisVC:
            vcToGo = storyBoard.instantiateViewController(withIdentifier: vc.rawValue) as! PicturesLisVC
            vcToGo.viewModel = PicturesLisVM()
            vcToGo.navigationItem.hidesBackButton = true
            
        case .uploadNewPicVC :
            vcToGo = storyBoard.instantiateViewController(withIdentifier: vc.rawValue) as! UploadNewPicVC
            vcToGo.viewModel = UploadNewPicVM()
            
        case .gifGeneratorVC:
            vcToGo = storyBoard.instantiateViewController(withIdentifier: vc.rawValue) as! GifGeneratorVC
            vcToGo.viewModel = GifGeneratorVM()
        }
        
        self.navigationSontroller.pushViewController(vcToGo, animated: true)
    }
    
    func popBack() {
        self.navigationSontroller.popViewController(animated: true)
    }
}


