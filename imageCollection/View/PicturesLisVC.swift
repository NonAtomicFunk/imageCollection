//
//  PicturesLisVC.swift
//  imageCollection
//
//  Created by admin2 on 12/20/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import AlamofireImage

class PicturesLisVC: BaseVC {

    @IBOutlet weak var colelctionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav()
        self.uiSetup()
        self.bindAll()
    }
    
    func setupNav() {
        let addBtn = UIBarButtonItem(image: UIImage(named: "add-icon"),
                                     style: .plain,
                                     target: self,
                                           action: #selector(self.goToUpload))
        addBtn.tintColor = .black
        let playBtn = UIBarButtonItem(image: UIImage(named: "play-icon"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(self.gotoGif))
        playBtn.tintColor = .black
        self.navigationItem.rightBarButtonItems = [playBtn, addBtn]
    }
    
    func uiSetup()  {
        self.colelctionView.register(UINib(nibName: "IcCell", bundle: nil),
                                     forCellWithReuseIdentifier: "IcCell")
        self.colelctionView.delegate = self
    }
    
    func bindAll() {
        
        (self.viewModel as! PicturesLisVM).dataModelsArray.asObservable()
            .bind(to: self.colelctionView.rx.items(cellIdentifier: "IcCell", cellType: IcCell.self)) { row, model, cell in
                
                cell.adressLbl.text = model.adress
                cell.weatherLbl.text = model.weather
                let url = URL(string: model.imageUrl)!
                cell.imageView.af_setImage(withURL: url)
                
            }.disposed(by: (self.viewModel as! PicturesLisVM).bag)
    }
    
    @objc func goToUpload() {
        self.viewModel.goto(.uploadNewPicVC)
    }
    
    @objc func gotoGif() {
        self.viewModel.goto(.gifGeneratorVC)
    }
}

extension PicturesLisVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width*0.22
        return CGSize(width: width, height: width)
    }
}
