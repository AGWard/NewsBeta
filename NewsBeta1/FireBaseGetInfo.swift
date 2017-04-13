//
//  FireBaseUserName.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/3/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase




        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                // ***************  FireBase Properties (to store database info)  *********** //
        //////////////////////////////////////////////////////////////////////////////////////////////////////////



var gotUserName: String!
var userProfilePicURLString: String!
var genderSelected: String!





        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                            // ***************  FireBase Branch Names  *********** //
        //////////////////////////////////////////////////////////////////////////////////////////////////////////







let parentUser = "Users"
let parentPostedData = "PostedData"
let postedByUser = "PostedDataByUser"
let postedPicsURL = "postedPicURL"
let postedTexts = "postedText"
let reporterName = "reporterName"
let timeUTC = "timeUTC"
let timestamp = "timestamp"
let email = "email"
let gender = "gender"
let username = "name"
let password = "password"
let profileImageURL = "profileImageURL"



class FireBaseAquistion {
    
    let userIDNumber: String
    let childRef: String
    let usernameReference: String
    let profileImageRef: String
    var property: String?
    var gender: String?
    
    init (userIDNumber: String, childRef: String, reference: String, profileImageRef: String, property: String, gender: String) {
        self.userIDNumber = userIDNumber
        self.childRef = childRef
        self.usernameReference = reference
        self.profileImageRef = profileImageRef
        self.gender = gender
    }
    
 
    
    convenience init(userIDNumber: String, childRef: String, reference: String, profileImageRef: String) {
        self.init(userIDNumber: userIDNumber, childRef: childRef, reference: reference, profileImageRef: profileImageRef, property: "", gender: "")
    }
    
    
    
    convenience init(userIDNumber: String, childRef: String, usernameReference: String) {
        self.init(userIDNumber: userIDNumber, childRef: childRef, usernameReference: usernameReference)
    }

    
    
    func getUserDetails() {
        
       
      
        
        FIRDatabase.database().reference().child(childRef).child(userIDNumber).observeSingleEvent(of: .value, with: {(snapshot) in
        
        
            if let dictionary = snapshot.value as? [String: AnyObject] {
        
                gotUserName = dictionary[self.usernameReference] as! String
                
                if let profileImageURLString = dictionary[self.profileImageRef] as? String {
                    
                    
                   userProfilePicURLString = profileImageURLString
                    
                    
                }
                
                
            }
        

        
        
        }, withCancel: nil)
        
        
    }
    
    
    func Home() {
        
        FIRDatabase.database().reference().child(childRef).child(userIDNumber).observeSingleEvent(of: .value, with: {(snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                gotUserName = dictionary[self.usernameReference] as! String
                
                if let profileImageURLString = dictionary[self.profileImageRef] as? String {
                    
                    
                    self.property = profileImageURLString
                    
                    
                }
                
                
            }
            
            
            
            
        }, withCancel: nil)
        
        
        
        
    }
    
    
    func getGenderFBData() {
        
        FIRDatabase.database().reference().child(childRef).child(userIDNumber).observeSingleEvent(of: .value, with: {(snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                genderSelected = dictionary[self.usernameReference] as! String
                
                
            }
            
            
            
            
        }, withCancel: nil)
        
        
    }


    
}









