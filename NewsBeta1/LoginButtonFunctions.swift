//
//  LoginButtonFunctions.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 4/9/17.
//  Copyright © 2017 AppCo. All rights reserved.
//


import UIKit
import Firebase
import SVProgressHUD



extension LoginController {
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ***************  Button Functions  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    // signup sign in button functions
    
    @objc func toggleTapped() {
        
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
    
    
    @objc func loginTapped() {
        
        if segmentedLoginRegToggle.selectedSegmentIndex == 0 {
            
            
            //log into homescreen
            
            handleLogin()
            
            
            
        } else if segmentedLoginRegToggle.selectedSegmentIndex == 1 {
            
            //register user via sign up sheet then direct to userHome Page
            
            registerCheck()
        }
    }
    

 
    
    
    func registerCheck() {
        
        
        
        if genderLabel.text != "gender" && genderLabel.text != "Alien" && genderLabel.text != "Santa" && genderLabel.text != "Kanye West" {
            
            if emailLabel.text?.isEmpty == false {
                
                if userNameLabel.text?.isEmpty == false {
                    
                    if passwordLabel.text?.isEmpty == false {
                        
                        
                        view.isUserInteractionEnabled = false
                        SVProgressHUD.show(withStatus: "Registering")
                        
                        guard let email = emailLabel.text, let password = passwordLabel.text, let name = userNameLabel.text, let gender = genderLabel.text else {
                            

                            self.view.isUserInteractionEnabled = true
                            SVProgressHUD.dismiss()
                            print("there is an issue with your checks on empty feilds")
                            return
                        }
                        
                        //******************************CREATION OF USER IN DATABASE*********************************//
                    
                        
                        networkRequest.signUpNewUser(name, email: email, password: password, gender: gender)
                        
                                             
                        
                    } else {

                        
                        passwordLabel.shake()
                    }
                    
                    
                } else {

                    userNameLabel.shake()
                }
 
                
            } else {
                
                emailLabel.shake()
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
        
        view.isUserInteractionEnabled = false
        
        
        SVProgressHUD.show(withStatus: "Logging In")
 
        
        guard let email = emailLabel.text, let password = passwordLabel.text else {
            
            print("login details (usernameor password) invalid")
            return
        }
        
        
        networkRequest.handleLogin(email, password: password)
        
    }
    
    
    
    func presentMainFeed() {
        
        
        let home = HomeController()
        home.modalPresentationStyle = .overCurrentContext
        
        let navController = UINavigationController(rootViewController: home)
        
        self.present(navController, animated: true, completion: nil)
        
        self.view.isUserInteractionEnabled = true
        SVProgressHUD.dismiss()

        
        
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
        

        
        return genders[row]
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        genderLabel.text = genders[row]
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        UIView.animate(withDuration: 0.8) {
            
            self.segmentedLoginRegToggle.isHidden = true
            self.appLogo.isHidden = true
            self.containerViewTop?.isActive = true
            self.containerViewTop?.constant = 130
            self.containerViewYPriority?.isActive = false
            self.view.layoutIfNeeded()
        }
        
        
        
        
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.8) {
            
            //            self.containerViewTop?.constant = -170
            self.segmentedLoginRegToggle.isHidden = false
            self.appLogo.isHidden = false
            self.containerViewTop?.isActive = false
            self.containerViewYPriority?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    
    
    
    func presentUserHomeController() {
        
  
            
            let userHomePage = UserHomePageController()
            userHomePage.modalPresentationStyle = .overCurrentContext
            
            let navController = UINavigationController(rootViewController: userHomePage)
            
            
            self.present(navController, animated: true, completion: {
                
                self.view.isUserInteractionEnabled = true
                SVProgressHUD.dismiss()
                
                
                
            })

            
            
        
        
        
        
    }
    
    

    
    
    @objc func forgotPasswordTapped() {
        
        
        forgotPassword.isUserInteractionEnabled = false
        
        
        
        verifyView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        verifyView?.backgroundColor = .white
        verifyView?.alpha = 0
        
        
        
        verifyEmail = UITextField(frame: CGRect(x: (verifyView?.center.x)! / 3 , y: (verifyView?.center.y)!, width: (verifyView?.frame.width)! / 1.5, height: (verifyView?.frame.width)! / 8))
        verifyEmail?.placeholder = "Enter email"
        verifyEmail?.backgroundColor = .clear
        
        verifyDetails = UITextField(frame: CGRect(x: 0, y: (verifyView?.frame.width)! / 6, width: (verifyView?.frame.width)!, height: (verifyView?.frame.width)! / 8))
        verifyDetails?.backgroundColor = .gray
        verifyDetails?.textColor = .black
        verifyDetails?.textAlignment = .center
        verifyDetails?.text = "Forgot Password?"
        
        
        let veryifyButton = UIButton(frame: CGRect(x: (verifyView?.center.x)! / 3, y: (verifyView?.center.y)! + (verifyEmail?.frame.height)! + 20, width: (verifyView?.frame.width)! / 1.5, height: (verifyView?.frame.width)! / 8))
        veryifyButton.setTitle("Submit", for: .normal)
        veryifyButton.setTitleColor(.red, for: .normal)
        veryifyButton.backgroundColor = UIColor(red: 67/255, green: 64/255, blue: 84/255, alpha: 1)
        veryifyButton.addTarget(self, action: #selector(verifyEmailTapped), for: .touchUpInside)
        
        
        let cancelButton = UIButton(frame: CGRect(x: (verifyView?.center.x)! / 3, y: (verifyView?.center.y)! + (verifyEmail?.frame.height)! + 20 + veryifyButton.frame.height + 10, width: (verifyView?.frame.width)! / 1.5, height: (verifyView?.frame.width)! / 8))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.backgroundColor = UIColor(red: 67/255, green: 64/255, blue: 84/255, alpha: 1)
        cancelButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        
        
        
        view.addSubview(verifyView!)
        verifyView?.addSubview(verifyEmail!)
        verifyView?.addSubview(verifyDetails!)
        verifyView?.addSubview(veryifyButton)
        verifyView?.addSubview(cancelButton)
        
        
        
        
        
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
            
            
            self.verifyView?.alpha = 1
            
        }, completion: nil)
        
        
        
        
    }
    
    
    
    
    
    @objc func zoomOut() {
        
        forgotPassword.isUserInteractionEnabled = true
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.verifyView?.alpha = 0
            
        }, completion: nil)
        
        
        
    }
    
    @objc func verifyEmailTapped() {
        
        
        print("FIrebase stuff here")
        
        
        Auth.auth().sendPasswordReset(withEmail: (verifyEmail?.text)!, completion: { (error) in
            
            if error == nil {
                
                print("email verification sent!!!")
                
            } else {
                
                
                
                print("here is the verify erro *** \(error!)")
            }
            
            
            
        })
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Username (aka userNameLabel) character limit
        
        guard let text = textField.text else {
            
            return true
            
        }
        
        if textField == userNameLabel {
            
            let newLengths = text.characters.count + string.characters.count - range.length
            
            return newLengths <= 12
            
        }

        
        return true
    }
    

    
    
}
