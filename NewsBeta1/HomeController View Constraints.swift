//
//  HomeController View Constraints.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/9/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

extension HomeController {
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ***************  View Did Load/Will Appear *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////

    func blurConstraints() {
        
        view.addSubview(blur)


        
        
    }
    
    
    func collectionViewConstraints() {
        
        collectionVw.register(FeedCell.self, forCellWithReuseIdentifier: feedCellID)
        collectionVw.register(MainStreamCell.self, forCellWithReuseIdentifier: mainStreamID)
        collectionVw.register(PoliceAlertCell.self, forCellWithReuseIdentifier: policeID)
        collectionVw.register(KIPCell.self, forCellWithReuseIdentifier: kIPsID)
        view.addSubview(collectionVw)
        
        collectionVw.frame = view.frame
        
    }
    
    
    
    
    func menuBarConstraints() {
        
        view.addSubview(menuBar)
        
        navigationController?.hidesBarsOnSwipe = false
        
        
        //        menuBar.widthAnchor.constraint(equalToConstant: 380).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        
        
    }
    
    
    
    
    
    func menuBarBlurConstrainsts() {
        
     
        self.blur.addSubview(self.accessUserMenuButton)
        self.blur.addSubview(self.choosePhotoMenuIcon)
        
        accessUserMenuButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        accessUserMenuButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        accessUserMenuButton.topAnchor.constraint(equalTo: blur.topAnchor, constant: 200).isActive = true
        
        choosePhotoMenuIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        choosePhotoMenuIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        choosePhotoMenuIcon.topAnchor.constraint(equalTo: accessUserMenuButton.bottomAnchor, constant: 20).isActive = true


        
    }
 
    
    
    
    
    
    
}

