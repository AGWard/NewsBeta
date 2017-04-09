//
//  UserHomePageController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 1/29/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase


let cellID = "cellID"


class UserHomePageController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var postedPhotos: [UIImage] = []
    var postedText: [String] = []
    var imageURLS: [String] = []
    var idlist = [String]()
    var reporterList = [String]()

    
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                                // ***************  Property Views Setup  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    var myNewsCollectionViewWidthAnchor: NSLayoutConstraint?
    
    
    
    lazy var myNewsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .yellow
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(myNewsViewCell.self, forCellWithReuseIdentifier: cellID)
        
        
        return cv
        
    }()
    
    
    
    
    lazy var reportedNewsButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Your Posts", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 12)
        button.addTarget(self, action: #selector(yourPosts), for: .touchUpInside)
        
        return button
        
    }()
    
    
    
    let rightView: UIView = {
        
        let rView = UIView()
        rView.translatesAutoresizingMaskIntoConstraints = false
        rView.backgroundColor = .gray
        rView.layer.masksToBounds = true
        
    
        return rView
        
       
    }()
    
    
    
    lazy var leftView: UIView = {
        
      let lView = UIView()
        lView.translatesAutoresizingMaskIntoConstraints = false
        lView.backgroundColor = .clear
        lView.layer.masksToBounds = true
        
        
        
        
        return lView
        
    }()
        

    
    
    
    let logoutButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "logout"), for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        
        return button
    }()
    
    
    
    let genderLabel: UILabel = {
        
       let gender = UILabel()
        
        
        return gender
    }()
    
    
    lazy var profileRealImage: UIImageView = {
        
        let profile = UIImageView()
        profile.translatesAutoresizingMaskIntoConstraints = false
        profile.contentMode = .scaleAspectFill
        profile.layer.borderWidth = 3
        profile.clipsToBounds = true
        profile.image = UIImage(named: "default")
        profile.isUserInteractionEnabled = true
        profile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(choosePic)))
        
        
        
        return profile
    }()
    
    
    
    
    
    
    
    lazy var leftBarButton: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setTitle("News", for: .normal)
        button.titleLabel?.font = UIFont(name: "Palatino", size: 15)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 30) //CGRectMake(0, 0, 30, 30)
        button.addTarget(self, action: #selector(newsButtonTapped), for: .touchUpInside)
        
        
        return button
        
    }()

    
    
    
    var backgroundImage1: UIImageView = {
        
        let bkImage = UIImageView()
        bkImage.clipsToBounds = true
        bkImage.translatesAutoresizingMaskIntoConstraints = false
        bkImage.contentMode = .scaleAspectFill
        
        
        return bkImage
    }()

    
    
    lazy var userNamelabelHolder: UILabel = {
        
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    

    
    
    
    
    
 ///******************************************************************************VIEW DID LOAD*******************************************************************************************************//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let leftNavButton = UIBarButtonItem(customView: leftBarButton)
        
        
        navigationItem.leftBarButtonItem = leftNavButton
        
        getPostedData()
        checkIfUserIsLoggedIn()
        
        

        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()        
        
        backgroundImageConstraints()
        leftRightViewConstraints()
        
        usernameHolderContraints()
        profileRealImageConstraints()
        reportedNewsButtonCOnstraints()
        
        
        
        
        
        setBackgroundBaseOnGender()
        logoutButtonConstraints()
   
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    ////////// COLLECTION VIEW SETUP ///////////////
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLS.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! myNewsViewCell
        cell.backgroundColor = .green
        cell.photoView.sd_setImage(with: URL(string: imageURLS[indexPath.item]))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: rightView.frame.width, height: 100)
    }
    
    
    
    
    
    
    
    
    
    
    
    
///*****************************************************************************VIEW FUNCTIONS*************************************************************************************************//
    
    
    func checkIfUserIsLoggedIn() {
        
    
        
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        } else {
            
            
            self.navigationItem.title = gotUserName
            userNamelabelHolder.text = gotUserName
            if userProfilePicURLString == nil {
                print("empty dude!!")
            } else {
                
                profileRealImage.sd_setImage(with: URL(string: userProfilePicURLString))
            }


            
        }
        
    }
    
    
    
    
    func newsButtonTapped() {
        
        let homeControl = HomeController()
        homeControl.modalPresentationStyle = .overCurrentContext
    
        
        let navC = UINavigationController(rootViewController: homeControl)
    present(navC, animated: true, completion: nil)
    
    }
    
    
    
    
    
    func handleLogout() {
        
        
        do {
            
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            
            print(logoutError)
            return
        }
        
        let loginVC = LoginController()
        loginVC.modalPresentationStyle = .overCurrentContext
        
        present(loginVC, animated: true, completion: nil)
        
    }
    
    
    
    
    
//    func getUserNameAndProfilePic() {
//    
//    
//        userNamelabelHolder.text = gotUserName
//        
//        if userProfilePicURLString == nil {
//            
//            
//            print("empty dude!!")
//        } else {
//            
//            
//            profileRealImage.sd_setImage(with: URL(string: userProfilePicURLString))
//        }
//    
//            
//        
//        
//        
////        FIRDatabase.database().reference().child(parentUser).child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
////            
////            if let dictoionary = snapshot.value as? [String: AnyObject] {
////                
////                self.userNamelabelHolder.text = dictoionary[username] as? String
////                if let profileImageUURl = dictoionary[profileImageURL] as? String {
////                    
////                    
////                    
////                    self.profileRealImage.loadImagesUsingCacheWithURLString(urlString: profileImageUURl)
////                    
////                    
////              
////                }
////            }
////            
////            
////        }, withCancel: nil)
//        
//        
//    }
    
    
        

    
    func choosePic() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            
            
            self.present(imagePicker, animated: true, completion: nil)
            
            
        } else {
            
            print("not getting access to photo library")
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
       
        
        var selectedImageFromPicker: UIImage?
        
        if let editImage = info [UIImagePickerControllerEditedImage] as? UIImage {
            
            selectedImageFromPicker = editImage
            
        } else if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            selectedImageFromPicker = chosenImage
            
            
        }
    
        if let selectedImage = selectedImageFromPicker {
            
            profileRealImage.image = selectedImage
            
            
            
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("profilr_Images").child("\(imageName).png")
            
            if let uploadData = UIImagePNGRepresentation(self.profileRealImage.image!) {
                
                
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        
                        print (error!)
                        return
                    }
                    
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                        
                        let ref = FIRDatabase.database().reference(fromURL: "https://news-cc704.firebaseio.com/")
                        let cuid = FIRAuth.auth()?.currentUser?.uid
                        let userReference = ref.child("Users").child(cuid!)
                        let values = ["profileImageURL": profileImageURL]
                        userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            
                            if err != nil {
                                
                                print(err!)
                                return
                            }
                            
                            print("picture saved")
                            
                            let uid = FIRAuth.auth()?.currentUser?.uid
                            
                            let fbAquisition = FireBaseAquistion(userIDNumber: uid!, childRef: parentUser, reference: username, profileImageRef: profileImageURL)
                            
                            fbAquisition.getUserDetails()
                            
                            self.dismiss(animated: true, completion: nil)
                            
                        })
                    }
                    
                    
                })
                
                
            }

            
        }
        

        
        
    
    }
    
    

    func setBackgroundBaseOnGender() {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictoionary = snapshot.value as? [String: AnyObject] {
                
                self.genderLabel.text = dictoionary["gender"] as? String
                
                if self.genderLabel.text == "Male" {
                    
                    self.backgroundImage1.image = UIImage(named: "male")
                    self.profileRealImage.layer.borderColor = UIColor(red: 247/255, green: 201/255, blue: 165/255, alpha: 1).cgColor
                    self.navigationController?.navigationBar.barTintColor = UIColor(red: 247/255, green: 201/255, blue: 165/255, alpha: 1)
                    
                } else if self.genderLabel.text == "Female" {
                    
                    self.backgroundImage1.image = UIImage(named: "femalebk")
                    self.profileRealImage.layer.borderColor = UIColor(red: 101/255, green: 49/255, blue: 122/255, alpha: 1).cgColor
                    self.navigationController?.navigationBar.barTintColor = UIColor(red: 101/255, green: 49/255, blue: 122/255, alpha: 1)
                }
                
                
                
                
                
    
            }
            
            
        }, withCancel: nil)
        
        
        
    
    }
    
    func yourPosts() {
       
        
       
        
        print("tapped")
        myNewsCollectionViewConstraints()
        
        
        UIView.animate(withDuration: 1.0) {
            self.myNewsCollectionView.frame = CGRect(x: 0, y: 0, width: self.rightView.frame.width, height: self.rightView.frame.height)
            self.view.layoutIfNeeded()
            
        }
        
       
    }
    
    func getPostedData() {
        
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        FIRDatabase.database().reference().child("Users").child(uid!).child("PostedDataByUser").observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String: [String : String]] {
                
                
                print("*****THis is user dictionary \(dictionary).")
                
                for info in dictionary {
                    
                    self.idlist.append(info.key)
                    
                    
                    
                    
                }
                
                
                
                for count in 0..<self.idlist.count {
                    
                    if let postedData = dictionary[self.idlist[count]]?["postedPicURL"], let postedInfo = dictionary[self.idlist[count]]?["postedText"], let name = dictionary[self.idlist[count]]?["reporterName"]{
                        
                        self.reporterList.append(name)
                        self.postedText.append(postedInfo)
                        
                        self.imageURLS.append(postedData)
                        
                        print("*******POSTED DATA HERE \(postedData)")
                        
                        print("imageURL count is \(self.imageURLS.count) and data is \(self.imageURLS)")
                        
                        self.myNewsCollectionView.reloadData()
                        
                        
                    }
                }
            }
            
            
            
        }, withCancel: nil)
        
        
        return
        
        
    }
    
    
}
