//
//  NetworkingService.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/9/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import Foundation
import Firebase
import SVProgressHUD


var registeredEmail: String?
var registeredGender: String?
var registeredName: String?
var registeredPassword: String?
var registeredPicURL: String?
var registeredSubCount: String?
var registeredSubscriptions: [String: String]?
var list: String?

var articlesArray: [Articles]?
var reveredReadArray = [String]()

var reveresSubscripArray = [DatabaseProperties]()

class NetworkingService {
    
    //properties
    
    let id = Auth.auth().currentUser?.uid
    
    var loginC: LoginController?
    var deletePost: DeletePostsController?
    var feedCell: FeedCell?
    var userHome: UserHomePageController?
    var trinicell: TriniNewsCell?
    var dataProperties: DatabaseProperties?
    var subscrip: SubscriptionsCell?
    var subscripFeed: SubscriptionsFeedCell?
    var mainstream: MainStreamCell?
    
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
                
                
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    
                    switch errCode {
                        
                    case .invalidEmail:
                        let alert = UIAlertController(title: "Invalid Email", message: "Kindly ensure a valid email is entered with the correct spelling", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.view.isUserInteractionEnabled = true
                        SVProgressHUD.dismiss()
                        
                        return
                        
                    case .wrongPassword:
                        let alert = UIAlertController(title: "Password Incorrect", message: "Kindly recheck your password", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.view.isUserInteractionEnabled = true
                        SVProgressHUD.dismiss()
                        
                        return
                        
                    case .userNotFound:
                        let alert = UIAlertController(title: "User Not Found", message: "Please ensure this is the email address you signed up with", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.view.isUserInteractionEnabled = true
                        SVProgressHUD.dismiss()
                        
                        return
                        
                    case .emailAlreadyInUse:
                        let alert = UIAlertController(title: "Email Already In Use", message: "Do you have an account with us already?", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.view.isUserInteractionEnabled = true
                        SVProgressHUD.dismiss()
                        
                        return
                        
                        
                    default:
                        let alert = UIAlertController(title: "Invalid Email/Password", message: "Error - \(error!)", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)

                        self.loginC?.present(alert, animated: true, completion: nil)
                        self.loginC?.view.isUserInteractionEnabled = true
                        SVProgressHUD.dismiss()
                        
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
        let imagePath = "posted\(imageName).jpg"
        
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
                
                let uploadData = UIImageJPEGRepresentation(image!, 0.1)
                
                
                
                
                self.storage.child(folder).child(userName).child(subPicFolder).child(imagePath).putData(uploadData!, metadata: nil, completion: { (metadat, err) in
                    
                    if err != nil {
                        
                        print("There is an error with the posted pic storage to firebase - \(err!)")
                        return
                        
                    }
                    
                    self.postData(videoMeta: metadata, imageMetadata: metadat, uid: uid, headlines: headlines, newsBody: newsBody, timestamp: timestamp, timeUTC: timeUTC, reporterName: reporterName, userPorfileImage: userPorfileImage, videoName: videoName, imageName: imagePath)
                    
                })

                
            })
            
            
        } else {
            
            let uploadData = UIImageJPEGRepresentation(image!, 0.1)
            
            
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
            
            
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                

                
                
                registeredEmail = dictionary[firebaseEmailString] as? String
                registeredName = dictionary[firebaseUsernameString] as? String
                registeredGender = dictionary[firebaseGenderString] as? String
                registeredPicURL = dictionary[firebaseProfileImageURLString] as? String
                registeredSubCount = dictionary[firebaseSubscribers] as? String
                registeredSubscriptions = dictionary["subscriptions"] as? [String : String]
                
                
      
                if screen == "login" {
                    
                    self.loginC?.presentUserHomeController()
                    
                } else if screen == "home" {
                    
                    
                    self.loginC?.presentMainFeed()
                }
                
                
            }
            
            
        }, withCancel: nil)
        
    }
    
    
    func getPostedData(area: String?) {
        
        var arraysN: [DatabaseProperties] = []
        
        var cellCounterColl: [DatabaseProperties] = []
      
            let ref = database.child("PostedData")
            ref.observe(.childAdded, with: { (snapshot) in
                
                
                if let dictionary = snapshot.value as? [String: AnyObject] {

                    let dbProperties = DatabaseProperties()
                    dbProperties.setValuesForKeys(dictionary)
                    
                        
                        arraysN.append(dbProperties)
                        reveredArrays = arraysN.reversed()
                        self.refreshReadCount()
                        
                        
                        self.feedCell?.collectionViews.reloadData()
                    
                    if area == "DeletePost" {
                        
                        self.deletePost?.presentUserHomePage()
                        
                    }

                    
                    if registeredSubscriptions == nil {
                        
                        reveresSubscripArray = []
                        return
                    }
                        
                        for (key, _ ) in registeredSubscriptions! {
                            
                            if key == dbProperties.userID {
                                
                                cellCounterColl.append(dbProperties)
                                reveresSubscripArray = cellCounterColl.reversed()
            
                            }
                            
                        }
                    
                }
                
                
            }, withCancel: nil)
            
            
        
    }

    
    
    
    
    func setUserProfilePic(profileImage: UIImage, uid: String, identifier: String) {
        
        
        
        
        let imagePath = "\(id!).jpg"
        let folder = "Profile Pics"
        
        if let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
            
            
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
                    self.loginC?.emailLabel.shake()

                    self.loginC?.view.isUserInteractionEnabled = true
                    SVProgressHUD.dismiss()
                    
                    return
                    
                case .wrongPassword:
                    self.loginC?.passwordLabel.shake()
                    self.loginC?.view.isUserInteractionEnabled = true
                    SVProgressHUD.dismiss()
                    
                    return
                    
                case .userNotFound:
                    self.loginC?.emailLabel.shake()
                    self.loginC?.view.isUserInteractionEnabled = true
                    SVProgressHUD.dismiss()
                    
                    return
                    
                case .emailAlreadyInUse:
                    self.loginC?.emailLabel.shake()
                    self.loginC?.view.isUserInteractionEnabled = true
                    SVProgressHUD.dismiss()
                    
                    return
                    
                    
                default:
                    self.loginC?.emailLabel.shake()
                    self.loginC?.view.isUserInteractionEnabled = true
                    SVProgressHUD.dismiss()
                    
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
        self.getPostedData(area: "DeletePost")
        
        if videoName == "No Video Name Required" {
            
            let imageRef = storage.child(folder).child(userID).child(subPicFolder).child(imageName!)
            imageRef.delete(completion: { (error) in
                if error != nil {
                    
                    print("There was an error deleting the image storage - \(error!)")
                } else {
                    
                    print("Image storage deleted successfully")

                    
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
    
    
    func readPost(userID: String) {
        
        //do some enable/diable button here
        
        let ref = database.child("PostedData/\(userID)")
        let keytoPost = ref.child(firebaseParentPostedData).childByAutoId().key
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
  
            if (snapshot.value as? [String : AnyObject]) != nil {
                
                let updateRead: [String : Any] = ["pplWhoRead/\(keytoPost)" : self.id!]
                
                ref.updateChildValues(updateRead, withCompletionBlock: { (error, ref) in
                    
        
                    if error == nil {
                        
                        
                        ref.observeSingleEvent(of: .value, with: { (snap) in
                            

                            if let properties = snap.value as? [String : AnyObject] {
                                
                                
                                if let reads = properties["pplWhoRead"] as? [String : AnyObject] {
                                    
                                    let count = "\(reads.count)"
                                    self.trinicell?.readCounter.text = "\(count) reads"
                                    
                                    
                                    let update = ["reads" : count]
                                    ref.updateChildValues(update)
                                    self.getPostedData(area: nil)
                                    
                                    
                                    //hide make visble read/unread button here & enable/disable
                                    
                                }
                                
                            }
                            
                            
                        })
                        
                        
                    } else {
                        
                        print("read post did not receive properly")
                        
                    }
                    
                    
                    
                })
                
            }
            
        })
        
        ref.removeAllObservers()
        
        
        
    }
    
    
    func unreadPost(userId: String) {
        
        //add button hidden enabled here
        
        let ref = database.child("PostedData/\(userId)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let properties = snapshot.value as? [String : AnyObject] {
                
                if let peopleWhoRead = properties["pplWhoRead"] as? [String : AnyObject] {
            
                    for (ids, person) in peopleWhoRead {
                        
                        if person as? String == self.id! {
                            
                            ref.child("pplWhoRead/\(ids)").removeValue(completionBlock: { (error, ref) in
                                
                                if error == nil {
                                    
                                    self.database.child("PostedData/\(userId)").observeSingleEvent(of: .value, with: { (snap) in
                                        
                                        if let prop = snap.value as? [String : AnyObject] {
                                            
                                            
                                            if let reads = prop["pplWhoRead"] as? [String : AnyObject] {
                                                let count = "\(reads.count)"
                                                self.trinicell?.readCounter.text = "\(count) reads"
                                                let update = ["reads" : count]
                                                self.database.child("PostedData/\(userId)").updateChildValues(update)
                                                self.getPostedData(area: nil)
                                                
                                            }else {
                                                
                                                self.trinicell?.readCounter.text = "0 reads"
                                                let updates = ["reads" : "0"]
                                                self.database.child("PostedData/\(userId)").updateChildValues(updates)
                                                self.getPostedData(area: nil)
                                            }
                                            
                                        }
                                    })
                                    
                                }
                                
                                
                            })
                            // add hidden features here
                            break
                        }
                        
                    }
                    
                }
                
            } 
            
        })
        
        
    }
    
    
    
    private func refreshReadCount() {
        
        var readArray: [DatabaseProperties] = []
        
        let ref = database.child("PostedData")
        ref.observe(.value, with: { (snap) in
            
            if let dictionary = snap.value as? [String: Any] {
                
                let readProperties = DatabaseProperties()
                readProperties.reads = dictionary["reads"] as? String
                readArray.append(readProperties)
                    
                
                
                reversedReads = readArray.reversed()
                
                
                
            }
            
        })
        
        
    }
    
    
    func subscribe(user: String) {
        
        if user == id {
            
            return
        }
        
        let ref = database.child("Users/\(user)")
        let keytoPost = ref.child(firebaseParentPostedData).childByAutoId().key
        let subScripRef = database.child("Users/\(id!)")
        
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if (snapshot.value as? [String: AnyObject]) != nil {
                
                let values = ["subscribers/\(self.id!)" : keytoPost]
                ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if error == nil {
                        
                        ref.observeSingleEvent(of: .value, with: { (snap) in
                            if let property = snap.value as? [String : AnyObject] {
                                
                                if let subCount = property["subscribers"] as? [String : AnyObject] {
                                    
                                    
                                    let count = "\(subCount.count)"
                                    
                                    let update = ["subscriberCount" : count]
                                    ref.updateChildValues(update)
                                    let subValues = ["subscriptions/\(user)" : keytoPost]
                                    subScripRef.updateChildValues(subValues, withCompletionBlock: { (error, reference) in
                                        if error == nil {
                                            
                                            subScripRef.observeSingleEvent(of: .value, with: { (dataSnap) in
                                                if let files = dataSnap.value as? [String : AnyObject] {
                                                    
                                                    
                                                    if let count1 = files["subscriptions"] as? [String : AnyObject]  {
                                                        
                                                        let subscriptionCount = "\(count1.count)"
                                                        let subscripValues = ["subscriptionCount" : subscriptionCount]
                                                        subScripRef.updateChildValues(subscripValues)
                                                        
                                                    }
                                                }
                                            })
                                            
                                        }
                                    })
                                    
                                    
                                    
                                }
                            }
                        })
                        
                    } else {
                        
                        print("subcriptions error $$$$$$$$$$ - \(error!)")
                    }
                })
                
                
                
            }
            
        })
        subScripRef.removeAllObservers()
        ref.removeAllObservers()

        
    }
    
    func unsubscribe(userID: String) {
        
        let subscriberRef = database.child("Users/\(userID)").child("subscribers").child(id!)
        subscriberRef.removeValue { (error, data) in
            if error == nil {
                
                let subRef = self.database.child("Users/\(userID)")
                subRef.observeSingleEvent(of: .value, with: { (dataSnap) in
                    if let property = dataSnap.value as? [String : AnyObject] {
                        
                        if let subscibers = property["subscribers"] as? [String : AnyObject] {
                            
                            let subscriberCount = "\(subscibers.count)"
                            let values = ["subscriberCount" : subscriberCount]
                            subRef.updateChildValues(values)
                        }
                        
                    }
                
                
                let subscriptionRef = self.database.child("Users/\(self.id!)").child("subscriptions").child(userID)
                
                subscriptionRef.removeValue(completionBlock: { (err, ref) in
                    if err == nil {
                        
                        
                        let ref = self.database.child("Users/\(self.id!)")
                        ref.observeSingleEvent(of: .value, with: { (data) in
                            if let prop = data.value as? [String : AnyObject] {
                                
                                if let subscrptions = prop["subscriptions"] as? [String : AnyObject] {
                                    
                                    let count = "\(subscrptions.count)"
                                    let updateValues = ["subscriptionCount" : count]
                                    ref.updateChildValues(updateValues)
                                    self.getPostedData(area: nil)
                                    
                                }
                            }
                        })
                        
                      ref.removeAllObservers()
                        
                    }
                })
                subscriptionRef.removeAllObservers()
            })
            subscriberRef.removeAllObservers()
               
            }
        }

        
    }
    
    
    func postAbuseReport(byUser: String, postID: String, abuseDetails: String) {
        
        let key = database.childByAutoId().key
        let ref = database.child("Reports").child("\(postID)-\(key)")
        
        
        let values = ["ReportedByUser": byUser, "PostNumber": postID, "Details": abuseDetails]
        
        ref.updateChildValues(values)
        
        
    }
    
    
    
    func fetchArticles() {
       
        articlesArray = [Articles]()
        
        if let url = URL(string: "https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=f131445c16ac414988f2f0963817136a") {
            
            let urlRequest = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                if error != nil {
                    
                    print("there was an error retrieving the BBC Data Anthony - \(error!)")
                    return
                }

                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                        for articleJson in articlesFromJson {
                            
                            let articleProperties = Articles()
                            if let title = articleJson["title"] as? String, let author = articleJson["author"] as? String, let url = articleJson["url"] as? String, let publishTime = articleJson["publishedAt"] as? String, let imageURL = articleJson["urlToImage"] as? String {
                            
                                articleProperties.author = author
                                articleProperties.title = title
                                articleProperties.url = url
                                articleProperties.publishedAt = publishTime
                                articleProperties.urlToImage = imageURL
                                
                            }
                            
                            articlesArray?.append(articleProperties)
                            
                        }
     
                    }
                        DispatchQueue.main.async {
                        self.mainstream?.mainStramCollectionV.reloadData()
                    }
                    
                } catch let error {
                    
                    print(error)
                }
                
            })
            
            task.resume()
            
        } else {
            
            print("Invalid URL Address")
            return
        }

        
        
    }
    
    
    
    
}
