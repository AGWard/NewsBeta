//
//  PoliceAlertCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/14/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class ServicesCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let servicesCellID = "servicesID"
    
    
    
    
    lazy var serviceAlertsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.backgroundColor = .red
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        collectionV.delegate = self
        collectionV.dataSource = self
        
        return collectionV
        
    }()
    
    
    
    override func setupViews() {
        backgroundColor = .black
        
        serviceAlertCollectionViewConstraints()
        
        
    }
    
    
    func serviceAlertCollectionViewConstraints() {
        
        addSubview(serviceAlertsCollectionView)
        serviceAlertsCollectionView.register(ServicesNewsCell.self, forCellWithReuseIdentifier: servicesCellID)
        
        
        serviceAlertsCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        serviceAlertsCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        serviceAlertsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: servicesCellID, for: indexPath) as! ServicesNewsCell
        
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 110)
    }




}
