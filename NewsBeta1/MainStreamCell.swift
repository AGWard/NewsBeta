//
//  MainStreamCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/14/17.
//  Copyright © 2017 AppCo. All rights reserved.
//



let mainstreamID = "cellID"
let mainstreamHeaderID = "headerID"

import UIKit

class MainStreamCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    lazy var mainStramCollectionV: UICollectionView = {
        
       let layout = UICollectionViewFlowLayout()
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
        
    }()


    
    override func setupViews() {
        super.setupViews()
        mainStreamCollectionViewConstraints()

        
    }

    
    func mainStreamCollectionViewConstraints() {
        
        addSubview(mainStramCollectionV)
        
        
        mainStramCollectionV.register(SubMainstreamCells.self, forCellWithReuseIdentifier: mainstreamID)
        mainStramCollectionV.register(MainstreamHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: mainstreamHeaderID)
        
        mainStramCollectionV.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        mainStramCollectionV.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        mainStramCollectionV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainstreamID, for: indexPath) as! SubMainstreamCells
        cell.backgroundColor = .lightGray
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height / 6)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: mainstreamHeaderID, for: indexPath) as! MainstreamHeaderCell
        header.backgroundColor = .white
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: frame.height / 2)
    }
    
    

}
