//
//  BaseVM.swift
//  imageCollection
//
//  Created by admin2 on 12/23/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BaseVM {
    
    func goto(_ vc: VcType) {
        VCRouter.singltone.pushMarkerVC(vc)
    }
}
