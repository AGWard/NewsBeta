//
//  NetworkingService.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/9/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import Foundation
import Firebase


var registeredEmail: String?
var registeredGender: String?
var registeredName: String?
var registeredPassword: String?
var registeredPicURL: String?
var assignedUid: String?


class NetworkingService {
    
    //properties
    
    var loginC: LoginController?
    var UserHomeC: UserHomePageController?
    
    
    var userInfoArray = [UserInfoDatabase]()
    
    
    var database: DatabaseReference {
        return Database.database().reference()
    }
    
    var storage: StorageReference {
        return Storage.storage().reference()
    }
    
    
    
    //register a new user
    
    func signUpNewUser(username: String, email: String, password: String, gender: String) {
        
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            
            if error == nil {
                
                self.setUserInfo(user: user!, username: username, email: email, password: password, gender: gender)
                
                
                
            } else {
                
                print(error!.localizedDescription)
                
            }
        })
        
        
        
    }
    
    
    private func setUserInfo(user: User, username: String, email: String, password: String, gender: String) {
        

        
        
        let chnageRequest = user.createProfileChangeRequest()
        chnageRequest.displayName = username

        chnageRequest.commitChanges { (err) in
            
            if err == nil {
                
                self.saveInfo(user: user, username: username, email: email, password: password, gender: gender)
                
            } else {
                
                print(err!.localizedDescription)
                
            }
        }
        
        
        
        
    }
    
    
    private func saveInfo(user: User, username: String, email: String, password: String, gender: String) {
        
        
        let userInfo = ["name": username, "email": user.email, "password": password, "gender": gender, "uid": user.uid]
        
        let userRef = database.child(firebaseParentUser).child(user.uid)
        
        userRef.setValue(userInfo)
        
        print("User info has been saved @ firebase")
        
 
        getUserInfo(parentRef: firebaseParentUser, childRef: user.uid, screen: "login")
        
    }
    
    
    
    func saveNewsFeed(uid: String, headlines: String, newsBody: String, image: UIImage?, videoImageURL: URL?, timestamp: String, timeUTC: String, reporterName: String, userPorfileImage: String) {
        
        let imageName = NSUUID().uuidString
        let imagePath = "profileImage\(imageName).png"
        
        let folder = "NewsVideos/Pics"
    
        
        if videoImageURL != nil {
            
            let videoName = "\(videoImageURL!).mov"
            
            storage.child(folder).child(videoName).putFile(from: videoImageURL!, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    
                    print("failed upload of video \(error!)")
                    return
                    
                    
                }
                
                let uploadData = UIImagePNGRepresentation(image!)
                
                
                
                
                self.storage.child(folder).child(imagePath).putData(uploadData!, metadata: nil, completion: { (metadat, err) in
                    
                    if err != nil {
                        
                        print("There is an error with the posted pic storage to firebase - \(err!)")
                        return
                        
                    }
                    
                    self.postData(videoMeta: metadata, imageMetadata: metadat, uid: uid, headlines: headlines, newsBody: newsBody, timestamp: timestamp, timeUTC: timeUTC, reporterName: reporterName, userPorfileImage: userPorfileImage)
                    
                })

                
            })
            
            
        } else {
            
            let uploadData = UIImagePNGRepresentation(image!)
            
            
            self.storage.child(folder).child(imagePath).putData(uploadData!, metadata: nil, completion: { (metadat, err) in
                
                if err != nil {
                    
                    print("There is an error with the posted pic storage to firebase - \(err!)")
                    return
                    
                }
                
                self.postData(videoMeta: nil, imageMetadata: metadat, uid: uid, headlines: headlines, newsBody: newsBody, timestamp: timestamp, timeUTC: timeUTC, reporterName: reporterName, userPorfileImage: userPorfileImage)
                
            })
            

            
            
            
        }
            
        
        

    }
    
    
   
    
    private func postData(videoMeta: StorageMetadata?, imageMetadata: StorageMetadata?, uid: String, headlines: String, newsBody: String, timestamp: String, timeUTC: String, reporterName: String, userPorfileImage: String) {
        
        
        let ref = Database.database().reference(fromURL: "https://news-cc704.firebaseio.com/")

        let postedReference = ref.child("PostedData")
        let autoID = postedReference.child(timestamp)
        
        let vidStorageURL = videoMeta?.downloadURL()?.absoluteString
        
        let imageStorageURL = imageMetadata?.downloadURL()?.absoluteString
        
        
        
        if videoMeta != nil {
            
            let values = ["postedPicURL": imageStorageURL!, "postedText": newsBody, "timestamp": timestamp, "timeUTC": timeUTC, "reporterName": reporterName, "userImage": userPorfileImage, "newsHeadlines": headlines, "postedVideoURL": vidStorageURL!, "userID": uid] as [String : Any]
            
            
            autoID.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                
                if err != nil {
                    
                    print(err!)
                    return
                }
                
                print("News picture & text saved")
                
                
            })
            
        
            
        } else {
            
            let values = ["postedPicURL": imageStorageURL!, "postedText": newsBody, "timestamp": timestamp, "timeUTC": timeUTC, "reporterName": reporterName, "userImage": userPorfileImage, "newsHeadlines": headlines, "postedVideoURL": "NoVids", "userID": uid] as [String : Any]
            
            
            autoID.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    
                    print(err!)
                    return
                }
                
                print("News picture & text saved without Vid")
                
                
            })

            
            
        }
        
        
        
    }
    
    
    
    func getUserInfo(parentRef: String, childRef: String, screen: String) {
        
        let ref = database.child(parentRef).child(childRef)
        
        ref.observe(.value, with: { (snapshot) in
            
            
            
            if let dictionary = snapshot.value as? [String: String] {
                

                
                
                registeredEmail = dictionary[firebaseEmailString]
                registeredName = dictionary[firebaseUsernameString]
                registeredGender = dictionary[firebaseGenderString]
                registeredPicURL = dictionary[firebaseProfileImageURLString]
                
                if screen == "login" {
                    
                    self.loginC?.presentUserHomeController()
                    
                }
                
                
            }
            
            
        }, withCancel: nil)
        
    }
    
    
    
    
    func setUserProfilePic(profileImage: UIImage, uid: String, identifier: String) {
        
        
        
        let imageName = NSUUID().uuidString
        let imagePath = "profileImage\(imageName).png"
        
        
        
        if let uploadData = UIImagePNGRepresentation(profileImage) {
            
            
            
            storage.child(imagePath).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if err != nil {
                    
                    print("There is an error with the profile pic storage to firebase - \(err!)")
                    return
                    
                }
                
                
                if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                    
                    
                    let ref = Database.database().reference(fromURL: "https://news-cc704.firebaseio.com/")
                    let userRef = ref.child(firebaseParentUser).child(uid)
                    let values = ["profileImageURL": profileImageURL]
                    
                    userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                        
                        if err != nil {
                            print("there was an error with the updating of the profil URL to firebase - \(err!)")
                            return
                            
                        }
                        
                        print("profile pic saved @ firebase")
                        
                        self.getUserInfo(parentRef: firebaseParentUser, childRef: uid, screen: "user")
                        
                    })
               
                    
                    
                    
                    
                    
                }
 
                
                
            })
            
            
        }
        
    
        
        
    }
    

    
    
}
