//
//  LoginButtonFunctions.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/9/17.
//  Copyright © 2017 AppCo. All rights reserved.
//


import UIKit
import Firebase



extension LoginController {
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ***************  Button Functions  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    func toggleTapped() {
        
        let title = segmentedLoginRegToggle.titleForSegment(at: segmentedLoginRegToggle.selectedSegmentIndex)
        
        signUpSignInButton.setTitle(title, for: .normal)
        
        
        if segmentedLoginRegToggle.selectedSegmentIndex == 0 {
            
            
            containerViewHeightAnchor?.constant = 120
            userNameViewHeightAnchor?.isActive = false
            genderLabelHeightAnchor?.isActive = false
            emailViewHeightAnchor?.constant = 60
            passwordViewHeightAnchor?.constant = 60
            sepLine2ViewHeightAnchor?.isActive = false
            
            
        }else if segmentedLoginRegToggle.selectedSegmentIndex == 1 {
            
            containerViewHeightAnchor?.constant = 180
            userNameViewHeightAnchor?.isActive = true
            genderLabelHeightAnchor?.isActive = true
            sepLine2ViewHeightAnchor?.isActive = true
            userNameViewHeightAnchor?.constant = 60
            passwordViewHeightAnchor?.constant = 60
            emailViewHeightAnchor?.constant = 60
            
        }
        
        
    }
    
    
    func loginTapped() {
        
        if segmentedLoginRegToggle.selectedSegmentIndex == 0 {
            
            handleLogin()
            
            
            
        } else if segmentedLoginRegToggle.selectedSegmentIndex == 1 {
            
            registerCheck()
        }
    }
    
    
    
    
    
    func registerCheck() {
        
        
        
        if genderLabel.text != "gender" && genderLabel.text != "Alien" && genderLabel.text != "Santa" && genderLabel.text != "Kanye West" {
            
            if emailLabel.text?.isEmpty == false {
                
                if userNameLabel.text?.isEmpty == false {
                    
                    if passwordLabel.text?.isEmpty == false {
                        
                        indicatorContainerView.isHidden = false
                        view.isUserInteractionEnabled = false
                        activityIndicator.startAnimating()
                        
                        guard let email = emailLabel.text, let password = passwordLabel.text, let name = userNameLabel.text, let gender = genderLabel.text else {
                            
                            self.indicatorContainerView.isHidden = true
                            self.view.isUserInteractionEnabled = true
                            self.activityIndicator.stopAnimating()
                            print("there is an issue with your checks on empty feilds")
                            return
                        }
                        
                        //******************************CREATION OF USER IN DATABASE*********************************//
                        
                        
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
                            
                            if error != nil {
                                
                                
                                let alert = UIAlertController(title: "Password/Email Invalid", message: "Error - \(error!)", preferredStyle: .alert)
                                let ok = UIAlertAction(title: "Got It", style: .default, handler: nil)
                                alert.addAction(ok)
                                
                                self.present(alert, animated: true, completion: nil)
                                self.indicatorContainerView.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                self.activityIndicator.stopAnimating()
                                
                                return
                            }
                            
                            guard let uid = user?.uid else {
                                
                                self.indicatorContainerView.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                self.activityIndicator.stopAnimating()
                                print("issue with user UID")
                                return
                            }
                            
                            
                            let userRef = FIRDatabase.database().reference().child("Users").child(uid)
                            let values = ["name": name, "email": email, "password": password, "gender": gender]
                            userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                                
                                if err != nil {
                                    //add prompt for email already in use
                                    print(err!)
                                    print("AAA")
                                    self.indicatorContainerView.isHidden = true
                                    self.view.isUserInteractionEnabled = true
                                    self.activityIndicator.stopAnimating()
                                    
                                    return
                                }
                                
 
                                
                                print("user info saved")
                                
                                let userHomePage = UserHomePageController()
                                userHomePage.modalPresentationStyle = .overCurrentContext
                                
                                let navController = UINavigationController(rootViewController: userHomePage)
                                
                                self.present(navController, animated: true, completion: nil)
                                self.indicatorContainerView.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                self.activityIndicator.stopAnimating()
                                
                                
                               
                            })
                            
                            
                            let fbAquisition = FireBaseAquistion(userIDNumber: uid, childRef: parentUser, reference: username, profileImageRef: profileImageURL)
                            
                            fbAquisition.getUserDetails()
                            
                        })
                        
                        
                        
                    } else {
                        
                        
                        //prompt for when password feild is empty
                        let alert = UIAlertController(title: "Password Missing", message: "Please enter a password", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Got It", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        present(alert, animated: true, completion: nil)
                        
                        
                    }
                    
                    
                } else {
                    
                    
                    //prompt for when username feild is empty
                    let alert = UIAlertController(title: "Username Required", message: "Please enter a username", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Got It", style: .default, handler: nil)
                    alert.addAction(ok)
                    
                    present(alert, animated: true, completion: nil)
                }
                
                
                
            } else {
                
                
                //prompt for when email feild is empty
                
                let alert = UIAlertController(title: "Email Required", message: "Please enter an email address", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Got It", style: .default, handler: nil)
                alert.addAction(ok)
                
                present(alert, animated: true, completion: nil)
            }
            
        } else {
            
            
            
            //prompt for not selecting gender
            
            switch genderLabel.text! {
            case "Kanye West":
                let alert = UIAlertController(title: "Gender Error", message: "I am sure you want to be Yeezy but lets be honest, he is not a person", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Your right", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            case "Santa":
                let alert = UIAlertController(title: "Gender Error", message: "Merry Christmas to you too but your not Santa", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Your right", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            case "Alien":
                let alert = UIAlertController(title: "Gender Error", message: "If you are an Alien then why do you need a phone?", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Your right", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            case "gender":
                let alert = UIAlertController(title: "Gender Error", message: "Please select a valid gender", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
                
            default:
                break
            }
            
            
        }
    }
    
    
    func handleLogin() {
        
        indicatorContainerView.isHidden = false
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
 
        
        guard let email = emailLabel.text, let password = passwordLabel.text else {
            
            print("login details (usernameor password) invalid")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            
            
            if error != nil {
                
                
                if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                    
                    switch errCode {
                        
                    case .errorCodeInvalidEmail:
                        let alert = UIAlertController(title: "Invalid Email", message: "Kindly ensure a valid email is entered with the correct spelling", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.present(alert, animated: true, completion: nil)
                        self.indicatorContainerView.isHidden = true
                        self.view.isUserInteractionEnabled = true
                        self.activityIndicator.stopAnimating()
                        
                        return
                        
                    case .errorCodeWrongPassword:
                        let alert = UIAlertController(title: "Password Incorrect", message: "Kindly recheck your password", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.present(alert, animated: true, completion: nil)
                        self.indicatorContainerView.isHidden = true
                        self.view.isUserInteractionEnabled = true
                        self.activityIndicator.stopAnimating()
                        
                        return
                        
                    case .errorCodeUserNotFound:
                        let alert = UIAlertController(title: "User Not Found", message: "Please ensure this is the email address you signed up with", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        self.present(alert, animated: true, completion: nil)
                        self.indicatorContainerView.isHidden = true
                        self.view.isUserInteractionEnabled = true
                        self.activityIndicator.stopAnimating()
                        
                        return
                        
                    default:
                        let alert = UIAlertController(title: "Invalid Email/Password", message: "Error - \(error!)", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        
                        
                        
                        self.present(alert, animated: true, completion: nil)
                        self.indicatorContainerView.isHidden = true
                        self.view.isUserInteractionEnabled = true
                        self.activityIndicator.stopAnimating()
                        
                        return
                        
                    }
                    
                    
                }
                
                
            }
            
          
            
            
            print("login in successful")
            
            let home = HomeController()
            home.modalPresentationStyle = .overCurrentContext
            
            let navController = UINavigationController(rootViewController: home)
            
            self.present(navController, animated: true, completion: nil)
            
            self.indicatorContainerView.isHidden = true
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
            
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            
            let fbAquisition = FireBaseAquistion(userIDNumber: uid!, childRef: parentUser, reference: username, profileImageRef: profileImageURL)
            
            fbAquisition.getUserDetails()
            
        })
        
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ***************  Gender setup (via UIPICKER) *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //        self.view.endEditing(true)
        
        
        return genders[row]
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        genderLabel.text = genders[row]
        //        self.getGender.isHidden = true
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.genderLabel {
            
            self.getGender.isHidden = false
            textField.endEditing(true)
        }
    }
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ***************  Settings for show/hide keyboard when on a text field  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailLabel.resignFirstResponder()
        userNameLabel.resignFirstResponder()
        passwordLabel.resignFirstResponder()
        
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func keyboardWillShow(notification: Notification) {
        
        UIView.animate(withDuration: 0.8) {
            
            self.segmentedLoginRegToggle.isHidden = true
            self.appLogo.isHidden = true
            self.containerViewTop?.isActive = true
            self.containerViewTop?.constant = 130
            self.containerViewYPriority?.isActive = false
            self.view.layoutIfNeeded()
        }
        
        
        
        
        
    }
    
    func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.8) {
            
            //            self.containerViewTop?.constant = -170
            self.segmentedLoginRegToggle.isHidden = false
            self.appLogo.isHidden = false
            self.containerViewTop?.isActive = false
            self.containerViewYPriority?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    

    

    
    
}
