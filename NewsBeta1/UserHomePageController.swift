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


class UserHomePageController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    

    var imageURLS: [String] = []
    var newsHeadline: [String] = []
    var timeStampID: [String] = []
    var imageNames: [String] = []
    var vidNames: [String] = []
    
    let currentID = Auth.auth().currentUser?.uid

    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                                // ***************  Property Views Setup  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    lazy var networkReq: NetworkingService = {
        
       let service = NetworkingService()
        service.userHome = self
        
        return service
    }()
    

    
    
    lazy var selectedPictureActivityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        indicator.clipsToBounds = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        return indicator
    }()
    
    
    
    
    lazy var myNewsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
       
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
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
        button.addTarget(self, action: #selector(yourPostsButtonTapped), for: .touchUpInside)
        
        return button
        
    }()
    
    
    
    lazy var rightView: UIView = {
        
        let rView = UIView()
        rView.translatesAutoresizingMaskIntoConstraints = false
        rView.backgroundColor = .clear
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

    
    
    
    lazy var backgroundImage1: UIImageView = {
        
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
        
        backgroundImageConstraints()
        leftRightViewConstraints()
        
        usernameHolderContraints()
        profileRealImageConstraints()
        reportedNewsButtonCOnstraints()
        
        
        
        
        
        setBackgroundBaseOnGender()
        logoutButtonConstraints()
        selectedPicActivityIndicatorConstraints()
        selectedPictureActivityIndicator.startAnimating()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                        // ***************  Collection View Setup (for user posts) *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        var cellCounter = 0

        
        for number in 0..<reveredArrays.count {
            
            print(reveredArrays.count)
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! myNewsViewCell
            cell.userHome = self
            cell.vidNames.text = vidNames[indexPath.item]
            cell.imgNames.text = imageNames[indexPath.item]
            cell.label.text = timeStampID[indexPath.item]
            cell.photoView.sd_setImage(with: URL(string: imageURLS[indexPath.item]))
            cell.newsHeadline.text = newsHeadline[indexPath.item]


        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: rightView.frame.width, height: 100)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    
    
    
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                        // ***************  View Functions  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    func checkIfUserIsLoggedIn() {
        
    
        
        
        if currentID == nil {
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
        } else {
            
            
            self.navigationItem.title = registeredName
            
            userNamelabelHolder.text = registeredName
            
            if registeredPicURL == nil {
                print("no profile picture selected yet!!")
            } else {
                
                profileRealImage.sd_setImage(with: URL(string: registeredPicURL!))  //<<<<<<<<<<<<<<<  remember to link profile PicURL string
            }


            
        }
        
    }
    
    
    
    
    func newsButtonTapped() {
        
        checkIfProfileImageSelected()
        
        let homeControl = HomeController()
        homeControl.modalPresentationStyle = .overCurrentContext
    
        
        let navC = UINavigationController(rootViewController: homeControl)
    present(navC, animated: true, completion: nil)
    
    }
    
    
    
    
    
    func handleLogout() {
        
        
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
            
            if let userID = currentID {
                
                let networkRequest = NetworkingService()
                networkRequest.setUserProfilePic(profileImage: profileRealImage.image!, uid: userID, identifier: "profile")
                
                
                self.dismiss(animated: true, completion: nil)

                
            } else {
                
                
                handleLogout()
            }
            
            
            
        }
    
    }
    
    

    func setBackgroundBaseOnGender() {
        
        
        if registeredGender == "Male" {
            
            self.backgroundImage1.image = UIImage(named: "male")
            self.profileRealImage.layer.borderColor = UIColor(red: 247/255, green: 201/255, blue: 165/255, alpha: 1).cgColor
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 247/255, green: 201/255, blue: 165/255, alpha: 1)
            
        } else if registeredGender == "Female" {
            
            self.backgroundImage1.image = UIImage(named: "femalebk")
            self.profileRealImage.layer.borderColor = UIColor(red: 101/255, green: 49/255, blue: 122/255, alpha: 1).cgColor
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 101/255, green: 49/255, blue: 122/255, alpha: 1)
            
            
        }
        
    }
    
    
    
    func yourPostsButtonTapped() {
       

        myNewsCollectionViewConstraints()
        
        
        UIView.animate(withDuration: 1.0) {
            self.myNewsCollectionView.frame = CGRect(x: 0, y: 0, width: self.rightView.frame.width, height: self.rightView.frame.height)
            self.view.layoutIfNeeded()
            
        }
        
       
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
