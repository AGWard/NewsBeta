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
        
        collectionVw.register(FeedCell.self, forCellWithReuseIdentifier: feedCellID)
        collectionVw.register(MainStreamCell.self, forCellWithReuseIdentifier: mainStreamID)
        collectionVw.register(ServicesCell.self, forCellWithReuseIdentifier: policeID)
        collectionVw.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsID)
        collectionVw.register(KIPCell.self, forCellWithReuseIdentifier: kIPsID)
        view.addSubview(collectionVw)
        
        collectionVw.frame = view.frame
        
        
    }
    
    
    
    
    func menuBarConstraints() {
        
        view.addSubview(menuBar)
        
        navigationController?.hidesBarsOnSwipe = false
        
        
        //        menuBar.widthAnchor.constraint(equalToConstant: 380).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        
        
    }
    
    
    
    
    
    
    
    
}

