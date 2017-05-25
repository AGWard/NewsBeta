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


protocol RefreshDataDelegate: class {
    func refreshData()
    func refresh2()
}


class NetworkingService {
    
    //properties
    
    let id = Auth.auth().currentUser?.uid
    
    var loginC: LoginController?
    var myView: myNewsViewCell?
    var feedCell: FeedCell?
    var userHome: UserHomePageController?
    
    
    
    var userInfoArray = [UserInfoDatabase]()
    
    
    var database: DatabaseReference {
        return Database.database().reference()
    }
    
    var storage: StorageReference {
        return Storage.storage().reference()
    }
    
    weak var delegate: RefreshDataDelegate?
    
    
    
    
    //register a new user
    
    func signUpNewUser(username: String, email: String, password: String, gender: String) {
        
        
        
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            
            if error == nil {
                
                self.setUserInfo(user: user!, username: username, email: email, password: password, gender: gender)
                
                
                
            } else {
                
                
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    
                    switch errCode {
                        
                    case .invalidEmail:
                        let alert = UIAlertController(title: "Invalid Email", message: "Kindly ensure a valid email is entered with the correct spelling", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.indicatorContainerView.isHidden = true
                        self.loginC?.view.isUserInteractionEnabled = true
                        self.loginC?.activityIndicator.stopAnimating()
                        
                        return
                        
                    case .wrongPassword:
                        let alert = UIAlertController(title: "Password Incorrect", message: "Kindly recheck your password", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.indicatorContainerView.isHidden = true
                        self.loginC?.view.isUserInteractionEnabled = true
                        self.loginC?.activityIndicator.stopAnimating()
                        
                        return
                        
                    case .userNotFound:
                        let alert = UIAlertController(title: "User Not Found", message: "Please ensure this is the email address you signed up with", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.indicatorContainerView.isHidden = true
                        self.loginC?.view.isUserInteractionEnabled = true
                        self.loginC?.activityIndicator.stopAnimating()
                        
                        return
                        
                    case .emailAlreadyInUse:
                        let alert = UIAlertController(title: "Email Already In Use", message: "Do you have an account with us already?", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.indicatorContainerView.isHidden = true
                        self.loginC?.view.isUserInteractionEnabled = true
                        self.loginC?.activityIndicator.stopAnimating()
                        
                        return
                        
                        
                    default:
                        let alert = UIAlertController(title: "Invalid Email/Password", message: "Error - \(error!)", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        
                        
                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.indicatorContainerView.isHidden = true
                        self.loginC?.view.isUserInteractionEnabled = true
                        self.loginC?.activityIndicator.stopAnimating()
                        
                        return

                    
                        
                    }

                }
                
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
        let imagePath = "posted\(imageName).png"
        
        let folder = "NewsFeed"
        let userName = id!
        let subPicFolder = "Pics"
        let subVidFolder = "Videos"
    
        
        if videoImageURL != nil {
            
            let videoName = "\(videoImageURL!).mov"
            
            storage.child(folder).child(userName).child(subVidFolder).child(videoName).putFile(from: videoImageURL!, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    
                    print("failed upload of video \(error!)")
                    return
                    
                    
                }
                
                let uploadData = UIImagePNGRepresentation(image!)
                
                
                
                
                self.storage.child(folder).child(userName).child(subPicFolder).child(imagePath).putData(uploadData!, metadata: nil, completion: { (metadat, err) in
                    
                    if err != nil {
                        
                        print("There is an error with the posted pic storage to firebase - \(err!)")
                        return
                        
                    }
                    
                    self.postData(videoMeta: metadata, imageMetadata: metadat, uid: uid, headlines: headlines, newsBody: newsBody, timestamp: timestamp, timeUTC: timeUTC, reporterName: reporterName, userPorfileImage: userPorfileImage, videoName: videoName, imageName: imagePath)
                    
                })

                
            })
            
            
        } else {
            
            let uploadData = UIImagePNGRepresentation(image!)
            
            
            self.storage.child(folder).child(userName).child(subPicFolder).child(imagePath).putData(uploadData!, metadata: nil, completion: { (metadat, err) in
                
                if err != nil {
                    
                    print("There is an error with the posted pic storage to firebase - \(err!)")
                    return
                    
                }
                
                self.postData(videoMeta: nil, imageMetadata: metadat, uid: uid, headlines: headlines, newsBody: newsBody, timestamp: timestamp, timeUTC: timeUTC, reporterName: reporterName, userPorfileImage: userPorfileImage, videoName: nil, imageName: imagePath)
                
            })
            
        }

    }
    
    
   
    
    private func postData(videoMeta: StorageMetadata?, imageMetadata: StorageMetadata?, uid: String, headlines: String, newsBody: String, timestamp: String, timeUTC: String, reporterName: String, userPorfileImage: String, videoName: String?, imageName: String) {
        
        
        let ref = Database.database().reference(fromURL: "https://news-cc704.firebaseio.com/")

        let postedReference = ref.child("PostedData")
        let autoID = postedReference.child(timestamp)
        
        let vidStorageURL = videoMeta?.downloadURL()?.absoluteString
        
        let imageStorageURL = imageMetadata?.downloadURL()?.absoluteString
        let noVidName = "No Video Name Required"

        
        if videoMeta != nil {
            
            guard let vidName = videoName else {
                print("videoName missing")
                return }
            
            let values = ["postedPicURL": imageStorageURL!, "postedText": newsBody, "timestamp": timestamp, "timeUTC": timeUTC, "reporterName": reporterName, "userImage": userPorfileImage, "newsHeadlines": headlines, "postedVideoURL": vidStorageURL!, "userID": uid, "videoName": vidName, "imageName": imageName] as [String : Any]
            
            
            autoID.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                
                if err != nil {
                    
                    print(err!)
                    return
                }
                
                print("News picture & text saved")
                
                
            })
            
        
            
        } else {
            
            let values = ["postedPicURL": imageStorageURL!, "postedText": newsBody, "timestamp": timestamp, "timeUTC": timeUTC, "reporterName": reporterName, "userImage": userPorfileImage, "newsHeadlines": headlines, "postedVideoURL": "NoVids", "userID": uid, "videoName": noVidName, "imageName": imageName] as [String : Any]
            
            
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
                    
                } else if screen == "home" {
                    
                    
                    self.loginC?.presentMainFeed()
                }
                
                
            }
            
            
        }, withCancel: nil)
        
    }
    
    
    func getPostedData() {
        
        var arraysN: [DatabaseProperties] = []
        
        let ref = database.child("PostedData")
        ref.observe(.childAdded, with: { (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                
                
                let dbProperties = DatabaseProperties()
                dbProperties.setValuesForKeys(dictionary)
                
                
                
                arraysN.append(dbProperties)
                //                        reveredArrays.insert(dbProperties, at: 0)
                reveredArrays = arraysN.reversed()
                
                
                print("I am here")
                self.feedCell?.collectionViews.reloadData()
                
                
            }
            
            self.delegate?.refreshData()
            
        }, withCancel: nil)
        
        
    }

    
    
    
    
    func setUserProfilePic(profileImage: UIImage, uid: String, identifier: String) {
        
        
        
        
        let imagePath = "\(id!).png"
        let folder = "Profile Pics"
        
        
        if let uploadData = UIImagePNGRepresentation(profileImage) {
            
            
            
            storage.child(folder).child(imagePath).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
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
    
    
    func handleLogin(email: String, password: String) {
      Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
        
        if error != nil {
            
            if let errCode = AuthErrorCode(rawValue: error!._code) {
                
                switch errCode {
                    
                case .invalidEmail:
                    let alert = UIAlertController(title: "Invalid Email", message: "Kindly ensure a valid email is entered with the correct spelling", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    
                    self.loginC?.present(alert, animated: true, completion: nil)
                    self.loginC?.indicatorContainerView.isHidden = true
                    self.loginC?.view.isUserInteractionEnabled = true
                    self.loginC?.activityIndicator.stopAnimating()
                    
                    return
                    
                case .wrongPassword:
                    let alert = UIAlertController(title: "Password Incorrect", message: "Kindly recheck your password", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    
                    self.loginC?.present(alert, animated: true, completion: nil)
                    self.loginC?.indicatorContainerView.isHidden = true
                    self.loginC?.view.isUserInteractionEnabled = true
                    self.loginC?.activityIndicator.stopAnimating()
                    
                    return
                    
                case .userNotFound:
                    let alert = UIAlertController(title: "User Not Found", message: "Please ensure this is the email address you signed up with", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    
                    self.loginC?.present(alert, animated: true, completion: nil)
                    self.loginC?.indicatorContainerView.isHidden = true
                    self.loginC?.view.isUserInteractionEnabled = true
                    self.loginC?.activityIndicator.stopAnimating()
                    
                    return
                    
                case .emailAlreadyInUse:
                    let alert = UIAlertController(title: "Email Already In Use", message: "Do you have an account with us already?", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    
                    self.loginC?.present(alert, animated: true, completion: nil)
                    self.loginC?.indicatorContainerView.isHidden = true
                    self.loginC?.view.isUserInteractionEnabled = true
                    self.loginC?.activityIndicator.stopAnimating()
                    
                    return
                    
                    
                default:
                    let alert = UIAlertController(title: "Invalid Email/Password", message: "Error - \(error!)", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    
                    self.loginC?.present(alert, animated: true, completion: nil)
                    self.loginC?.indicatorContainerView.isHidden = true
                    self.loginC?.view.isUserInteractionEnabled = true
                    self.loginC?.activityIndicator.stopAnimating()
                    
                    return
                    
                }
                
            }
        
        }
        
        let uid = Auth.auth().currentUser?.uid
        
        self.getUserInfo(parentRef: firebaseParentUser, childRef: uid!, screen: "home")
        
        
        }
        
    }
    
    func deletePosts(feedpath: String, imageName: String?, videoName: String?) {
        
        
        let folder = "NewsFeed"
        let userID = id!
        let subPicFolder = "Pics"
        let subVidFolder = "Videos"
        
        let storage = Storage.storage().reference(forURL: "gs://news-cc704.appspot.com/")


        database.child(firebaseParentPostedData).child(feedpath).removeValue()
        self.getPostedData()
        
        if videoName == "No Video Name Required" {
            
            let imageRef = storage.child(folder).child(userID).child(subPicFolder).child(imageName!)
            imageRef.delete(completion: { (error) in
                if error != nil {
                    
                    print("There was an error deleting the image storage - \(error!)")
                } else {
                    
                    print("Image storage deleted successfully")
                    
                    self.delegate?.refresh2()
                    
                }
            })
            
        } else {
            
            let imageRef = storage.child(folder).child(userID).child(subPicFolder).child(imageName!)
            imageRef.delete(completion: { (error) in
                if error != nil {
                    
                    print("There was an error deleting the image storage - \(error!)")
                } else {
                    
                    let vidRef = storage.child(folder).child(userID).child(subVidFolder).child(videoName!)
                    vidRef.delete(completion: { (err) in
                        if err != nil {
                            
                            print("There was an error deleting the video storage - \(err!)")
                            
                            
                        } else {
                            
                            print("evrything Deleted succesfully!")
                            
                            
                            
                        }
                    })
                    
                }
            })

            
            
            
        }
        
        
        
       
        
        
    }
    
    
    
}
