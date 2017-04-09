//
//  PostingPageController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 3/21/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase



class PostingPageController: UIViewController {
    

    
    let date = Date()
    let formatter: DateFormatter = {
        
        let matter = DateFormatter()
        matter.locale = Locale(identifier: "en_US_POSIX")
        matter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        matter.timeZone = TimeZone(abbreviation: "UTC")
        
        
        return matter
    }()
    
    

    
    lazy var postButton: UIButton = {
        
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("POST", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(postNews), for: .touchUpInside)
        
        
        return button
    }()
    
    
    let postTextField: UITextView = {
        
       let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        field.backgroundColor = .white
        field.autocorrectionType = .yes
        field.autocapitalizationType = .sentences
        
        
        return field
    }()
    
    
    
    let selectedPic: UIImageView = {
        
       let pic = UIImageView()
        pic.backgroundColor = .green
        pic.contentMode = .scaleAspectFill
        pic.translatesAutoresizingMaskIntoConstraints = false
        
        
        return pic
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        postedPicConstraints()
        postedTextFieldConstraints()
        postButtonConstraints()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPosting))
        view.backgroundColor = .yellow
        
        
        
        
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func postedPicConstraints() {
        
        view.addSubview(selectedPic)
                
        selectedPic.widthAnchor.constraint(equalToConstant: 100).isActive = true
        selectedPic.heightAnchor.constraint(equalToConstant: 100).isActive = true
        selectedPic.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    
    func postedTextFieldConstraints() {
        
        view.addSubview(postTextField)
        
        postTextField.leftAnchor.constraint(equalTo: selectedPic.rightAnchor, constant: 0).isActive = true
        postTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        postTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        postTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
    }
    
    func postButtonConstraints() {
        
        view.addSubview(postButton)
        
        postButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        postButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
        
    }
    
    func cancelPosting() {
        
        let userPhotoController = UserPhotoController()
        userPhotoController.modalTransitionStyle = .flipHorizontal
        
        let navConntroller = UINavigationController(rootViewController: userPhotoController)
        
        
        present(navConntroller, animated: true, completion: nil)
    }
    
    func postNews() {
        

        
        
        let utcTimeZoneStr = formatter.string(from: date)
        let timestamp = (Date().timeIntervalSince1970)
        let stringTImestamp = String(timestamp)
        
        
        guard let textEntered = postTextField.text else {
            
            print("no data entered")
            return
            
        }
        
        
        
        let imageName = NSUUID().uuidString
        let uidd = FIRAuth.auth()?.currentUser?.uid
        let storageRef = FIRStorage.storage().reference().child("NewsImages").child(uidd!).child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(self.selectedPic.image!) {
            
            
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    
                    print (error!)
                    return
                }
                
                if let selectedPicURL = metadata?.downloadURL()?.absoluteString {
                    
                    let ref = FIRDatabase.database().reference(fromURL: "https://news-cc704.firebaseio.com/")
                    
                    
                    let userReference = ref.child("Users").child(uidd!).child("PostedDataByUser")
                    let postedReference = ref.child("PostedData")
                    let values = ["postedPicURL": selectedPicURL, "postedText": textEntered, "timestamp": stringTImestamp, "timeUTC": utcTimeZoneStr, "reporterName": gotUserName!, "userImage": userProfilePicURLString!]
                    postedReference.childByAutoId().updateChildValues(values, withCompletionBlock: { (err, ref) in
                        
                        if err != nil {
                            
                            print(err!)
                            return
                        }
                        
                        print("News picture & text saved")
                        
                        
                        
                        
                        
                        
                    })
                    
                    userReference.childByAutoId().updateChildValues(values, withCompletionBlock: { (err, ref) in
                        
                        if err != nil {
                            
                            print(err!)
                            return
                        }
                        
                        print("News picture & text saved")
                        
                        
                        
                        let homeC = HomeController()
                        homeC.modalPresentationStyle = .overFullScreen
                        
                        let navController = UINavigationController(rootViewController: homeC)
                        
                        self.present(navController, animated: true, completion: nil)
                        
                        
                    })

                    
                }
                
                
            })
            
            
        }

        
    }
    


}
