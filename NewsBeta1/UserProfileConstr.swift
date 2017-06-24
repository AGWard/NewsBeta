//
//  UserProfileConstr.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 3/5/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit


extension UserHomePageController {
    
    
    ///*****************************************************************************CONSTRAINT FUNCTIONS*************************************************************************************************//
    

    
    
    func logoutButtonConstraints() {
        
        view.addSubview(logoutButton)
        
        logoutButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    
    
    
//    func backgroundImageConstraints() {
//        
//        view.addSubview(backgroundImage1)
//        
//        backgroundImage1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        backgroundImage1.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//    }
    
    
    
    func profileRealImageConstraints() {
        
        
        view.addSubview(profileRealImage)
        
        
        profileRealImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5).isActive = true
        profileRealImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5).isActive = true
        profileRealImage.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 70).isActive = true
        profileRealImage.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        //added the corner radius(aka making the frame edges curve) in the constraints so I can have access to "view"
        
        profileRealImage.layer.cornerRadius = (view.frame.width * 1/5) * 0.5
        
        
        
    }
    
    
    func userButtonsCollBarConstraints() {
        
        view.addSubview(userButtonsCollBar)
        
        userButtonsCollBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        userButtonsCollBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/14).isActive = true
        userButtonsCollBar.topAnchor.constraint(equalTo: profileRealImage.bottomAnchor, constant: 5).isActive = true
        
        
        
    }
    
    
    
    
    func topViewConstraints() {
        
        
        view.addSubview(topView)

        topView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//        topView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
 
        
    }
    
    
    
    
    func subCountLabelConstraints() {
        
        view.addSubview(subCounter)
        view.addSubview(subCounterLabel)
        
        subCounter.bottomAnchor.constraint(equalTo: profileRealImage.topAnchor, constant: -5).isActive = true
        subCounter.centerXAnchor.constraint(equalTo: profileRealImage.centerXAnchor).isActive = true
        
        subCounterLabel.centerXAnchor.constraint(equalTo: subCounter.centerXAnchor).isActive = true
        subCounterLabel.bottomAnchor.constraint(equalTo: subCounter.topAnchor, constant: -5).isActive = true
        
    }
    
    
    func reportedNewsButtonCOnstraints() {
        
        topView.addSubview(reportedNewsButton)
        
        reportedNewsButton.widthAnchor.constraint(equalTo: topView.widthAnchor).isActive = true
        reportedNewsButton.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        reportedNewsButton.topAnchor.constraint(equalTo: profileRealImage.bottomAnchor, constant: 10).isActive = true
        
        
    }
    
    
    
    
    func myNewsCollectionViewConstraints() {
        
        bottomView.addSubview(myNewsCollectionView)
        
        myNewsCollectionView.widthAnchor.constraint(equalTo: bottomView.widthAnchor).isActive = true
        myNewsCollectionView.heightAnchor.constraint(equalTo: bottomView.heightAnchor).isActive = true
        myNewsCollectionView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        myNewsCollectionView.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        
    }
    
    func bottomViewConstraints() {
        
        view.addSubview(bottomView)
        
        bottomView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: userButtonsCollBar.bottomAnchor, constant: 5).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
    func blackViewCOnstraints() {
        
        topView.addSubview(blackView)
        
        blackView.frame = topView.frame
        
    }
    

 
    
}
