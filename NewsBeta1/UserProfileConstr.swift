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
    
    func selectedPicActivityIndicatorConstraints() {
        
        view.addSubview(selectedPictureActivityIndicator)
        
        selectedPictureActivityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        selectedPictureActivityIndicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        selectedPictureActivityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }
    

    
    
    
    
    func logoutButtonConstraints() {
        
        view.addSubview(logoutButton)
        
        logoutButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    
    
    
    func backgroundImageConstraints() {
        
        view.addSubview(backgroundImage1)
        
        backgroundImage1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage1.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    
    
    func profileRealImageConstraints() {
        
        
        leftView.addSubview(profileRealImage)
        
        profileRealImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/6).isActive = true
        profileRealImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/6).isActive = true
        profileRealImage.topAnchor.constraint(equalTo: userNamelabelHolder.bottomAnchor, constant: 20).isActive = true
        profileRealImage.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 1).isActive = true
        
        //added the corner radius(aka making the frame edges curve) in the constraints so I can have access to "view"
        
        profileRealImage.layer.cornerRadius = (view.frame.width * 1/6) * 0.5
        
    }
    
    
    func usernameHolderContraints() {
        
        
        leftView.addSubview(userNamelabelHolder)
        
        
        userNamelabelHolder.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        userNamelabelHolder.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userNamelabelHolder.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        userNamelabelHolder.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 1).isActive = true
        
    }
    
    
    func leftRightViewConstraints() {
        
        
        view.addSubview(leftView)
        view.addSubview(rightView)
    
        let newHeight = view.frame.height-topLayoutGuide.length
       
        
        leftView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        leftView.heightAnchor.constraint(equalToConstant: CGFloat(view.frame.height) - topLayoutGuide.length).isActive = true
        leftView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        
        rightView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        rightView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        rightView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        rightView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    func reportedNewsButtonCOnstraints() {
        
        leftView.addSubview(reportedNewsButton)
        
        reportedNewsButton.widthAnchor.constraint(equalTo: leftView.widthAnchor).isActive = true
        reportedNewsButton.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        reportedNewsButton.topAnchor.constraint(equalTo: profileRealImage.bottomAnchor, constant: 10).isActive = true
        
        
    }
    
    
    
    
    func myNewsCollectionViewConstraints() {
        
        rightView.addSubview(myNewsCollectionView)
        
        myNewsCollectionView.frame = CGRect(x: view.frame.width, y: 0, width: rightView.frame.width, height: rightView.frame.height)
        
        
    }
    
    
}
