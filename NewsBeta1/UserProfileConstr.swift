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
    
    
    
    
    func backgroundImageConstraints() {
        
        view.addSubview(backgroundImage1)
        
        backgroundImage1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage1.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    
    
    func profileRealImageConstraints() {
        
        view.addSubview(profileRealImage)
        
        profileRealImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        profileRealImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        profileRealImage.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 100).isActive = true
        profileRealImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //added the corner radius(aka making the frame edges curve) in the constraints so I can have access to "view"
        
        profileRealImage.layer.cornerRadius = (view.frame.width * 1/3) * 0.5
        
    }
    
    
    func usernameHolderContraints() {
        
        view.addSubview(userNamelabelHolder)
        
        
        userNamelabelHolder.widthAnchor.constraint(equalToConstant: 200).isActive = true
        userNamelabelHolder.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userNamelabelHolder.bottomAnchor.constraint(equalTo: profileRealImage.topAnchor, constant: -2).isActive = true
        userNamelabelHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    
    
    
    
    
    
    
    
}
