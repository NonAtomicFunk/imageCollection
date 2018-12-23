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
        
//        Alamofire
        let decoder = JSONDecoder()
        
//        do {
//            let decoded = try decoder.decode([IcCellDataModel].self, from: data)
//            print(decoded[0].weather)
//        } catch {
//            print("Failed to decode JSON")
//        }
    }
}
