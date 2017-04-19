//
//  MainStreamCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/14/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class MainStreamCell: BaseCell {
    
    
    lazy var mainStramCollectionV: UICollectionView = {
        
       let layout = UICollectionViewFlowLayout()
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .yellow
        
        
        return collectionView
        
    }()


    
    override func setupViews() {
        super.setupViews()
        mainStreamCollectionViewConstraints()

        
    }

    
    func mainStreamCollectionViewConstraints() {
        
        addSubview(mainStramCollectionV)
        
        
        mainStramCollectionV.frame = contentView.frame
        
    }
    
    
    

}
