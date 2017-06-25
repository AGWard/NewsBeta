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
let menuCellID = "menuCell"



class UserHomePageController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    

    var imageURLS: [String] = []
    var newsHeadline: [String] = []
    var timeStampID: [String] = []
    var imageNames: [String] = []
    var vidNames: [String] = []
    
    let currentID = Auth.auth().currentUser?.uid
    
    let menuNames = ["My News", "BookMarked", "Edit Profile", "Settings"]

    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                                // ***************  Property Views Setup  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    lazy var subCounterLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subscribers"
        return label
    }()
    
    
    lazy var subCounter: UILabel = {
        
       let label = UILabel()
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    lazy var selectedImage: UIImageView = {
        
       let select = UIImageView()
        select.contentMode = .scaleAspectFill
        
        return select
        
    }()
    


//    
//    lazy var backgroundImage1: UIImageView = {
//        
//        let bkImage = UIImageView()
//        bkImage.clipsToBounds = true
//        bkImage.translatesAutoresizingMaskIntoConstraints = false
//        bkImage.contentMode = .scaleAspectFill
//        
//        
//        
//        return bkImage
//    }()
    
    lazy var blackView: UIView = {
        
        let bView = UIView()
        bView.translatesAutoresizingMaskIntoConstraints = false
        bView.backgroundColor = .black
        bView.alpha = 0.7
        
        
        
        return bView
    }()
    
    
    lazy var networkReq: NetworkingService = {
        
       let service = NetworkingService()
        service.userHome = self
        
        return service
    }()
    
    
    
    
    lazy var myNewsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(MyNewsCell.self, forCellWithReuseIdentifier: cellID)
    
        
        return cv
        
    }()
    
    
    lazy var userButtonsCollBar: UICollectionView = {
        
       let layout = UICollectionViewFlowLayout()
    
        layout.minimumInteritemSpacing = 0
        let userView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        userView.translatesAutoresizingMaskIntoConstraints = false
        userView.delegate = self
        userView.dataSource = self
        userView.register(userProfileMenuButtonCell.self, forCellWithReuseIdentifier: menuCellID)
        userView.backgroundColor = .clear
        
        
        
        return userView
    }()
    
    
    
    lazy var reportedNewsButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Your Posts", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 12)
        button.addTarget(self, action: #selector(yourPostsButtonTapped), for: .touchUpInside)
        
        return button
        
    }()
    
    
    
    lazy var bottomView: UIView = {
        
        let rView = UIView()
        rView.translatesAutoresizingMaskIntoConstraints = false
        rView.backgroundColor = .clear
        rView.layer.masksToBounds = true
        
    
        return rView
        
       
    }()
    
    
    
    lazy var topView: UIImageView = {
        
      let lView = UIImageView()
        lView.translatesAutoresizingMaskIntoConstraints = false
        lView.backgroundColor = .blue
        lView.layer.masksToBounds = true
        lView.contentMode = .scaleAspectFill
        
        return lView
        
    }()
        

    
    
    
    lazy var logoutButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "logout"), for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        
        return button
    }()
    
    
    
    lazy var genderLabel: UILabel = {
        
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

    

    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                    // ***************  View Did Load/ Will Layout  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        
        let leftNavButton = UIBarButtonItem(customView: leftBarButton)
        
        
        navigationItem.leftBarButtonItem = leftNavButton
        
       
        
    }
    
    
    
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()        
        
//        backgroundImageConstraints()
        topViewConstraints()
        setBackgroundBaseOnGender()
        
        profileRealImageConstraints()
        userButtonsCollBarConstraints()
        reportedNewsButtonCOnstraints()
        bottomViewConstraints()
        blackViewCOnstraints()
        logoutButtonConstraints()
        subCountLabelConstraints()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                        // ***************  Collection View Setup (for user posts) *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == myNewsCollectionView {
            
            var cellCounter = 0
            for number in 0..<reveredArrays.count {
                
                
                if currentID == reveredArrays[number].userID{
                    
                    imageNames.append(reveredArrays[number].imageName!)
                    vidNames.append(reveredArrays[number].videoName!)
                    timeStampID.append(reveredArrays[number].timestamp!)
                    imageURLS.append(reveredArrays[number].postedPicURL!)
                    newsHeadline.append(reveredArrays[number].newsHeadlines!)
                    cellCounter += 1
                    
                }
                
            }
            
            
            return cellCounter
            
        }
        
        
        return 4
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == myNewsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MyNewsCell

            
            cell.photoView.sd_setImage(with: URL(string: imageURLS[indexPath.item]))
            
            return cell

            
        }
        
        let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellID, for: indexPath) as! userProfileMenuButtonCell
        menuCell.menulabel.text = menuNames[indexPath.item]
        
        return menuCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == myNewsCollectionView {
            
            return CGSize(width: (bottomView.frame.width / 4) - 1, height: (bottomView.frame.width / 4) - 1)
        }
        
        return CGSize(width: (userButtonsCollBar.frame.width / 4) - 1.5, height: userButtonsCollBar.frame.height)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView != myNewsCollectionView {
            
            switch indexPath.row {
            case 0:
                yourPostsButtonTapped()
                return
            default:
                return
            }
        } else {
            
           
            selectedImage.sd_setImage(with: URL(string: imageURLS[indexPath.item]))
            

            let deletePostC = DeletePostsController()
            deletePostC.postedPic = selectedImage.image
            deletePostC.newsHeadline.text = newsHeadline[indexPath.item]
            deletePostC.videoName = vidNames[indexPath.item]
            deletePostC.imageName = imageNames[indexPath.item]
            deletePostC.timeStamp = timeStampID[indexPath.item]
            deletePostC.modalPresentationStyle = .fullScreen
            
            let navC = UINavigationController(rootViewController: deletePostC)
            
            present(navC, animated: true, completion: { 
                
            })
        }
        
    }
    
    
    
    
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                        // ***************  View Functions  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    func checkIfUserIsLoggedIn() {
        
    
        
        
        if currentID == nil {
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        } else {
            
            
            self.navigationItem.title = registeredName
            
            if registeredSubCount == nil {
                self.subCounter.text = "0"
                
            } else{
            
            self.subCounter.text = registeredSubCount
            }
            
            if registeredPicURL == nil {
                print("no profile picture selected yet!!")
            } else {
                
                profileRealImage.sd_setImage(with: URL(string: registeredPicURL!))  //<<<<<<<<<<<<<<<  remember to link profile PicURL string
            }


            
        }
        
    }
    
    
    
    
    @objc func newsButtonTapped() {
        
        checkIfProfileImageSelected()
        
        let homeControl = HomeController()
        homeControl.modalPresentationStyle = .overCurrentContext
    
        
        let navC = UINavigationController(rootViewController: homeControl)
    present(navC, animated: true, completion: nil)
    
    }
    
    
    
    
    
    @objc func handleLogout() {
        
        
        do {
            
            try Auth.auth().signOut()
        } catch let logoutError {
            
            print(logoutError)
            return
        }
        
        let loginVC = LoginController()
        loginVC.modalPresentationStyle = .overCurrentContext
        
        present(loginVC, animated: true, completion: nil)
        
    }


    
    @objc func choosePic() {
        
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
            
            if let userID = currentID {
                
                let networkRequest = NetworkingService()
                networkRequest.setUserProfilePic(profileRealImage.image!, uid: userID, identifier: "profile")
                
                
                self.dismiss(animated: true, completion: nil)

                
            } else {
                
                
                handleLogout()
            }
            
            
            
        }
    
    }
    
    

    func setBackgroundBaseOnGender() {
        
        
        if registeredGender == "Male" {
            
//            self.backgroundImage1.image = UIImage(named: "male")
            self.topView.image = UIImage(named: "maleSpace2")
            self.profileRealImage.layer.borderColor = UIColor(red: 5/255, green: 34/255, blue: 59/255, alpha: 1).cgColor
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 5/255, green: 34/255, blue: 59/255, alpha: 1)
            
        } else if registeredGender == "Female" {
            
//            self.backgroundImage1.image = UIImage(named: "femalebk")
            self.topView.image = UIImage(named: "femaleSpace")
            self.profileRealImage.layer.borderColor = UIColor(red: 101/255, green: 49/255, blue: 122/255, alpha: 1).cgColor
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 101/255, green: 49/255, blue: 122/255, alpha: 1)
            
            
        }
        
    }
    
    
    
    @objc func yourPostsButtonTapped() {
       

        myNewsCollectionViewConstraints()
        
        
//        UIView.animate(withDuration: 1.0) {
//            self.myNewsCollectionView.frame = CGRect(x: 0, y: 0, width: self.bottomView.frame.width, height: self.bottomView.frame.height)
//            self.view.layoutIfNeeded()
//            
//        }
        
       
    }
    
    
    func checkIfProfileImageSelected() {
        
        if profileRealImage.image == UIImage(named: "default") || profileRealImage.image == nil {
            
            let alert = UIAlertController(title: "Profile Pic Required", message: "Please select a profile pic before moving forward", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Got It", style: .default, handler: nil)
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            return
            
            
        }
        
        
    }
    
    
    
    
}
