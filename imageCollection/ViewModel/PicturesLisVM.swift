//
//  PicturesLisVM.swift
//  imageCollection
//
//  Created by admin2 on 12/23/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import AlamofireImage

final class PicturesLisVM: BaseVM {
    
    let bag = DisposeBag()
    
    let dataModelsArray = Variable<[IcCellDataModel]>([])
    
    func getAll() {
        print(self, "HELLO")
        Rest.shared.getAll({(array) in
            let arrayToStore = array
            self.dataModelsArray.value = array
        })        
    }
}
