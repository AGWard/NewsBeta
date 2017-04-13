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

    
    
    
    func collectionViewConstraints() {
        
        collectionVw.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        
        view.addSubview(collectionVw)
        
        collectionVw.frame = view.frame
        
    }
    
    
    
    
    func menuBarConstraints() {
        
        view.addSubview(menuBar)
        
        navigationController?.hidesBarsOnSwipe = true
        
        
        //        menuBar.widthAnchor.constraint(equalToConstant: 380).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        
        
    }
    
    
    
    
    
    func rightBarViewConstraints() {
        
        rightButtonView.addSubview(rightbarPic)
        rightButtonView.addSubview(userMenuButton)
        
        
        
        rightbarPic.widthAnchor.constraint(equalToConstant: 30).isActive = true
        rightbarPic.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rightbarPic.rightAnchor.constraint(equalTo: rightButtonView.rightAnchor, constant: -2).isActive = true
        rightbarPic.centerYAnchor.constraint(equalTo: rightButtonView.centerYAnchor).isActive = true
        
        
        
        userMenuButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        userMenuButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userMenuButton.centerYAnchor.constraint(equalTo: rightButtonView.centerYAnchor).isActive = true
        userMenuButton.rightAnchor.constraint(equalTo: rightButtonView.rightAnchor, constant: -2).isActive = true
        
    }
 
    
    
    
    
    
    
}

