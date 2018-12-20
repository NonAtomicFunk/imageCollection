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
        let uiWindow: UIWindow = UIApplication.shared.delegate!.window!!
        uiWindow.rootViewController = navigationSontroller
    }
    
    
    func pushMarkerVC(_ vc: VcType) {
        
        let navigationSontroller: UINavigationController = storyBoard.instantiateInitialViewController() as! UINavigationController
        let vcToGo: UIViewController!
        
        switch vc {
        case .picturesLisVC:
            vcToGo = storyBoard.instantiateViewController(withIdentifier: vc.rawValue) as! PicturesLisVC
        case .uploadNewPicVC :
            vcToGo = storyBoard.instantiateViewController(withIdentifier: vc.rawValue) as! UploadNewPicVC
        case .gifGeneratorVC:
            vcToGo = storyBoard.instantiateViewController(withIdentifier: vc.rawValue) as! GifGeneratorVC
        }
        
//        vc.navigationItem.hidesBackButton = true
//        vc.vm = ()
//        defer {
//            navigationSontroller.pushViewController(vc, animated: true)
//        }
    }
    
    func popBack() {
        self.navigationSontroller.popViewController(animated: true)
    }
}


