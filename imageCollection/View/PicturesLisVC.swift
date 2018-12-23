//
//  PicturesLisVC.swift
//  imageCollection
//
//  Created by admin2 on 12/20/18.
//  Copyright © 2018 admin2. All rights reserved.
//

import UIKit

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
        
    }
    
    func bindAll() {
        
    }
    
    @objc func goToUpload() {
        self.viewModel.goto(.uploadNewPicVC)
    }
    
    @objc func gotoGif() {
        self.viewModel.goto(.gifGeneratorVC)
    }
}

extension PicturesLisVC: UICollectionViewDelegate {
    
}
