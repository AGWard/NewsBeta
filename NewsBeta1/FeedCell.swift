//
//  FeedCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/19/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    
    let cellID = "cellID"
    
    
    lazy var collectionViews: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collection  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .darkText
        collection.dataSource = self
        collection.delegate = self
        
        
        return collection
        
    }()
    
    override func setupViews() {
        super.setupViews()
        
        
        backgroundColor = .brown
        collectionViewContraints()
        

        
    }
    
    
    func collectionViewContraints() {
        
        addSubview(collectionViews)
        collectionViews.register(TriniNewsCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionViews.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        collectionViews.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        collectionViews.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionViews.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TriniNewsCell
        cell.backgroundColor = .red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let height = (frame.width - 16 - 16) * 9 / 16
//        return CGSize(width: frame.width, height: height + 16 + 88)
        
        return CGSize(width: frame.width, height: 210)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
