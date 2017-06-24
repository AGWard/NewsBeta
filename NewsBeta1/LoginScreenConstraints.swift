//
//  Constraints.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 1/29/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

extension LoginController {
    
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ***************  Constraints for all subviews on the loginScreen (re loginController)  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    
    func containerContstraint() {
        
        view.addSubview(continerView)
        
        containerViewTop = continerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300)
        containerViewTop?.isActive = false
        containerViewHeightAnchor = continerView.heightAnchor.constraint(equalToConstant: 120)
        containerViewHeightAnchor?.isActive = true
        containerViewHeightAnchor?.priority = UILayoutPriority(rawValue: 1000)
        continerView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 10).isActive = true
        continerView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -10).isActive = true
        continerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerViewYPriority = continerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        containerViewYPriority?.isActive = true
        
        
        
        continerView.addSubview(userNameLabel)
        continerView.addSubview(passwordLabel)
        continerView.addSubview(seperatorLine)
        continerView.addSubview(emailLabel)
        continerView.addSubview(seperatorLine2)
        continerView.addSubview(genderLabel)
        continerView.addSubview(seperatorLine3)
        continerView.addSubview(emailIcon)
        continerView.addSubview(passwordIcons)
        continerView.addSubview(userIcon)
        
        
        
        userNameLabel.widthAnchor.constraint(equalTo: continerView.widthAnchor, multiplier: 10/16).isActive = true
        userNameViewHeightAnchor = userNameLabel.heightAnchor.constraint(equalToConstant: 60)
        userNameViewHeightAnchor?.isActive = false
        userNameLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        
        
        passwordLabel.widthAnchor.constraint(equalTo: continerView.widthAnchor, multiplier: 13/15).isActive = true
        passwordViewHeightAnchor = passwordLabel.heightAnchor.constraint(equalToConstant: 60)
        passwordViewHeightAnchor?.isActive = true
        passwordLabel.bottomAnchor.constraint(equalTo: seperatorLine3.topAnchor).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: continerView.rightAnchor).isActive = true
        
        
        seperatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        seperatorLine.topAnchor.constraint(equalTo: emailLabel.bottomAnchor).isActive = true
        seperatorLine.leftAnchor.constraint(equalTo: continerView.leftAnchor, constant: 8).isActive = true
        seperatorLine.rightAnchor.constraint(equalTo: continerView.rightAnchor, constant: -8).isActive = true
        
        
        
        emailLabel.widthAnchor.constraint(equalTo: continerView.widthAnchor, multiplier: 13/15).isActive = true
        emailViewHeightAnchor = emailLabel.heightAnchor.constraint(equalToConstant: 60)
        emailViewHeightAnchor?.isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: passwordLabel.topAnchor).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: continerView.rightAnchor).isActive = true
        
        
        sepLine2ViewHeightAnchor = seperatorLine2.heightAnchor.constraint(equalToConstant: 0.5)
        sepLine2ViewHeightAnchor?.isActive = false
        seperatorLine2.topAnchor.constraint(equalTo: emailLabel.topAnchor).isActive = true
        seperatorLine2.leftAnchor.constraint(equalTo: continerView.leftAnchor, constant: 8).isActive = true
        seperatorLine2.rightAnchor.constraint(equalTo: continerView.rightAnchor, constant: -8).isActive = true
        
        genderLabelHeightAnchor = genderLabel.heightAnchor.constraint(equalToConstant: 40)
        genderLabelHeightAnchor?.isActive = false
        genderLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor).isActive = true
        genderLabel.rightAnchor.constraint(equalTo: continerView.rightAnchor).isActive = true
        genderLabel.widthAnchor.constraint(equalTo: continerView.widthAnchor, multiplier: 1/4).isActive = true
        
        seperatorLine3.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        seperatorLine3.bottomAnchor.constraint(equalTo: continerView.bottomAnchor).isActive = true
        seperatorLine3.leftAnchor.constraint(equalTo: continerView.leftAnchor, constant: 8).isActive = true
        seperatorLine3.rightAnchor.constraint(equalTo: continerView.rightAnchor, constant: -8).isActive = true
        
        
        emailIcon.widthAnchor.constraint(equalTo: continerView.widthAnchor, multiplier: 1/15).isActive = true
        emailIcon.leftAnchor.constraint(equalTo: continerView.leftAnchor).isActive = true
        emailIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        emailIcon.bottomAnchor.constraint(equalTo: seperatorLine.topAnchor, constant: -25).isActive = true
        
        passwordIcons.widthAnchor.constraint(equalTo: continerView.widthAnchor, multiplier: 1/15).isActive = true
        passwordIcons.leftAnchor.constraint(equalTo: continerView.leftAnchor).isActive = true
        passwordIcons.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordIcons.bottomAnchor.constraint(equalTo: seperatorLine3.topAnchor, constant: -20).isActive = true
        
        
        userIcon.widthAnchor.constraint(equalTo: continerView.widthAnchor, multiplier: 1/15).isActive = true
        userIcon.leftAnchor.constraint(equalTo: continerView.leftAnchor).isActive = true
        userIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        userIcon.bottomAnchor.constraint(equalTo: seperatorLine2.topAnchor, constant: -20).isActive = true
        

        
        view.addSubview(signUpSignInButton)
        
        signUpSignInButton.widthAnchor.constraint(equalTo: continerView.widthAnchor).isActive = true
        signUpSignInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpSignInButton.topAnchor.constraint(equalTo: continerView.bottomAnchor, constant: 30).isActive = true
        

        
        view.addSubview(segmentedLoginRegToggle)
        
        
        
        segmentedLoginRegToggle.bottomAnchor.constraint(equalTo: continerView.topAnchor, constant: -20).isActive = true
        segmentedLoginRegToggle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedLoginRegToggle.widthAnchor.constraint(equalTo: continerView.widthAnchor).isActive = true
        segmentedLoginRegToggle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
   
        
        view.addSubview(forgotPassword)
        
        
        forgotPassword.widthAnchor.constraint(equalToConstant: 130).isActive = true
        forgotPassword.heightAnchor.constraint(equalToConstant: 20).isActive = true
        forgotPassword.topAnchor.constraint(equalTo: signUpSignInButton.bottomAnchor, constant: 5).isActive = true
        forgotPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        

        
    }
    

    
    
    func backgroundConstrainst() {
        
        view.addSubview(backgroundImage)
        
        
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        backgroundImage.addSubview(backgroundBlur)
        
        
        backgroundBlur.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor).isActive = true
        backgroundBlur.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor).isActive = true
        
    }
    
 
    
}








    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ***************  Extenstion to remove the border on the signIn/signup segemented toggle  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////







extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: UIColor(red: 77/255.0, green: 74/255.0, blue: 92/255.0, alpha: 1)), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: .white), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: .clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
