//
//  LoginController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 1/29/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
///*************************************************************************PROPERTY/VIEWS SETUP*****************************************************************************************************//
    
    
    lazy var loadingIndicatorText: UILabel = {
        
       let indicatorText = UILabel()
        indicatorText.text = "LOADING"
        indicatorText.textColor = .white
        indicatorText.font = UIFont(name: "Avenir Next", size: 13)
        indicatorText.translatesAutoresizingMaskIntoConstraints = false
        indicatorText.textAlignment = .center
        indicatorText.clipsToBounds = true
        
        return indicatorText
    }()
    
    
    lazy var indicatorContainerView: UIView = {
        let activityView = UIView()
        activityView.backgroundColor = .clear
        
        
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        return activityView
    }()
    
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.clipsToBounds = true
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        
       return indicator
    }()


    
    let genders = ["Male", "Female", "Alien", "Santa", "Kanye West"]
    
    
    
    
    lazy var getGender: UIPickerView = {
       
        let gendersss = UIPickerView()
        gendersss.delegate = self
        gendersss.dataSource = self
        gendersss.translatesAutoresizingMaskIntoConstraints = false
        
    
        
        
        
        return gendersss
    }()
    
    
    var backgroundImage: UIImageView = {
        
        let bkImage = UIImageView()
        bkImage.image = UIImage(named: "Tobago")
        bkImage.translatesAutoresizingMaskIntoConstraints = false
        bkImage.contentMode = .scaleAspectFit
        
        
        return bkImage
    }()
    
    
    lazy var continerView: UIView = {
       
        let containV = UIView()
        containV.backgroundColor = .blue
        containV.layer.cornerRadius = 10
        containV.translatesAutoresizingMaskIntoConstraints = false
        containV.layer.masksToBounds = true
        
        
        return containV
    }()
    
    lazy var genderLabel: UITextField = {
        
        let gpicker = UITextField()
        gpicker.backgroundColor = .gray
        gpicker.text = "gender"
        gpicker.font = UIFont.boldSystemFont(ofSize: 12)
        gpicker.textAlignment = .center
        gpicker.delegate = self
        gpicker.textColor = .lightGray
        
        
        
        
        gpicker.translatesAutoresizingMaskIntoConstraints = false
        
        return gpicker
    }()
    
    
    lazy var userNameLabel: UITextField = {
        
        let user = UITextField()
        user.placeholder = "username"
        user.backgroundColor = .gray
        user.delegate = self

        user.translatesAutoresizingMaskIntoConstraints = false
        
        return user
    }()
    
    
    lazy var passwordLabel: UITextField = {
        
        let password = UITextField()
        password.placeholder = "password"
        password.isSecureTextEntry = true
        password.backgroundColor = .gray
        password.delegate = self
       
        password.translatesAutoresizingMaskIntoConstraints = false
        
        return password
    }()
    
    
    lazy var loginRegisterButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var seperatorLine: UIView = {
       
        let line = UIView()
        line.backgroundColor = .white
        line.layer.cornerRadius = 3
        line.translatesAutoresizingMaskIntoConstraints = false
        
        
        return line
    }()
    
    
    lazy var segmentedLoginRegToggle: UISegmentedControl = {
        
       let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.tintColor = .white
        sc.layer.borderColor = UIColor.white.cgColor
        sc.layer.borderWidth = 1
        sc.selectedSegmentIndex = 0
        
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(toggleTapped), for: .valueChanged)
        
        return sc
    }()
    
    lazy var emailLabel: UITextField = {
        
        let email = UITextField()
        email.placeholder = "email"
        email.backgroundColor = .gray
        email.delegate = self
        
        email.translatesAutoresizingMaskIntoConstraints = false
        
        return email
    }()
    
    lazy var seperatorLine2: UIView = {
        
        let line = UIView()
        line.backgroundColor = .white
        line.layer.cornerRadius = 3
        line.translatesAutoresizingMaskIntoConstraints = false
        
        
        return line
    }()
    
    



    
    
///******************************************************************************VIEW DID LOAD*******************************************************************************************************//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        indicatorContainerView.isHidden = true
        activityIndicator.stopAnimating()
        
        backgroundConstrainst()
        containerContstraint()
        textFieldContraints()
        loginRegisButtonConstraints()
        segmentedToggleContraints()
        indicatorConstraints()
        indicatorActivityContainerConstraints()
        loadingIndicatorTextConstraints()

        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        genderLabel.inputView = getGender
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
///*****************************************************************************CONSTRAINT FUNCTIONS*************************************************************************************************//
   
    
    func loadingIndicatorTextConstraints() {
        
        indicatorContainerView.addSubview(loadingIndicatorText)
        
        loadingIndicatorText.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10).isActive = true
        loadingIndicatorText.widthAnchor.constraint(equalTo: indicatorContainerView.widthAnchor).isActive = true
        loadingIndicatorText.centerXAnchor.constraint(equalTo: indicatorContainerView.centerXAnchor).isActive = true
        
        
        
        
    }
    
    

    func indicatorActivityContainerConstraints() {
        
        view.addSubview(indicatorContainerView)
        indicatorContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        indicatorContainerView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        indicatorContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        indicatorContainerView.bottomAnchor.constraint(equalTo: segmentedLoginRegToggle.topAnchor, constant: -5).isActive = true
        
        
    }
    
    
    func indicatorConstraints() {
        
        
        indicatorContainerView.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: indicatorContainerView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: indicatorContainerView.centerYAnchor, constant: -20).isActive = true
        
    }

    
    func backgroundConstrainst() {
        
        view.addSubview(backgroundImage)
        
        backgroundImage.frame = view.frame
        
    }
    
    var containerViewHeightAnchor: NSLayoutConstraint?
    var containerViewTop: NSLayoutConstraint?
    var containerViewYPriority: NSLayoutConstraint?
    
    func containerContstraint() {
        
        view.addSubview(continerView)
        
        containerViewTop = continerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300)
        containerViewTop?.isActive = false
        containerViewHeightAnchor = continerView.heightAnchor.constraint(equalToConstant: 80)
        containerViewHeightAnchor?.isActive = true
        containerViewHeightAnchor?.priority = 1000
        continerView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 10).isActive = true
        continerView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -10).isActive = true
        continerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerViewYPriority = continerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        containerViewYPriority?.isActive = true
        
        
        
        
        
    }
    
    var emailViewHeightAnchor: NSLayoutConstraint?
    var sepLine2ViewHeightAnchor: NSLayoutConstraint?
    var userNameViewHeightAnchor: NSLayoutConstraint?
    var passwordViewHeightAnchor: NSLayoutConstraint?
    var genderLabelHeightAnchor: NSLayoutConstraint?
    
    
    func textFieldContraints() {
        
        continerView.addSubview(userNameLabel)
        continerView.addSubview(passwordLabel)
        continerView.addSubview(seperatorLine)
        continerView.addSubview(emailLabel)
        continerView.addSubview(seperatorLine2)
        continerView.addSubview(genderLabel)
        
        
        userNameLabel.widthAnchor.constraint(equalTo: continerView.widthAnchor, multiplier: 3/4).isActive = true
        userNameViewHeightAnchor = userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        userNameViewHeightAnchor?.isActive = false
        userNameLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: continerView.leftAnchor).isActive = true
        
        
        passwordLabel.widthAnchor.constraint(equalTo: continerView.widthAnchor).isActive = true
        passwordViewHeightAnchor = passwordLabel.heightAnchor.constraint(equalToConstant: 40)
        passwordViewHeightAnchor?.isActive = true
        passwordLabel.bottomAnchor.constraint(equalTo: continerView.bottomAnchor).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: continerView.leftAnchor).isActive = true
        
        
        seperatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        seperatorLine.topAnchor.constraint(equalTo: emailLabel.bottomAnchor).isActive = true
        seperatorLine.leftAnchor.constraint(equalTo: continerView.leftAnchor, constant: 8).isActive = true
        seperatorLine.rightAnchor.constraint(equalTo: continerView.rightAnchor, constant: -8).isActive = true
        
        
        emailLabel.widthAnchor.constraint(equalTo: continerView.widthAnchor).isActive = true
        emailViewHeightAnchor = emailLabel.heightAnchor.constraint(equalToConstant: 40)
        emailViewHeightAnchor?.isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: passwordLabel.topAnchor).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: continerView.leftAnchor).isActive = true

        
        sepLine2ViewHeightAnchor = seperatorLine2.heightAnchor.constraint(equalToConstant: 1)
        sepLine2ViewHeightAnchor?.isActive = false
        seperatorLine2.topAnchor.constraint(equalTo: emailLabel.topAnchor).isActive = true
        seperatorLine2.leftAnchor.constraint(equalTo: continerView.leftAnchor, constant: 8).isActive = true
        seperatorLine2.rightAnchor.constraint(equalTo: continerView.rightAnchor, constant: -8).isActive = true
        
        genderLabelHeightAnchor = genderLabel.heightAnchor.constraint(equalToConstant: 40)
        genderLabelHeightAnchor?.isActive = false
        genderLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor).isActive = true
        genderLabel.rightAnchor.constraint(equalTo: continerView.rightAnchor).isActive = true
        genderLabel.widthAnchor.constraint(equalTo: continerView.widthAnchor, multiplier: 1/4).isActive = true
        
        
       
        
    }
    
    
    func loginRegisButtonConstraints() {
        
        view.addSubview(loginRegisterButton)
        
        loginRegisterButton.widthAnchor.constraint(equalTo: continerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: continerView.bottomAnchor, constant: 10).isActive = true
        
    
    }
    
    
    func segmentedToggleContraints() {
        
        view.addSubview(segmentedLoginRegToggle)
        
        segmentedLoginRegToggle.bottomAnchor.constraint(equalTo: continerView.topAnchor, constant: -10).isActive = true
        segmentedLoginRegToggle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedLoginRegToggle.widthAnchor.constraint(equalTo: continerView.widthAnchor).isActive = true
        segmentedLoginRegToggle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    

    
    
    
    
///*********************************************************************************BUTTON FUNCTIONS*************************************************************************************************//
    
    func toggleTapped() {
        
        let title = segmentedLoginRegToggle.titleForSegment(at: segmentedLoginRegToggle.selectedSegmentIndex)
        
        loginRegisterButton.setTitle(title, for: .normal)
        
        
        if segmentedLoginRegToggle.selectedSegmentIndex == 0 {
            
            
            containerViewHeightAnchor?.constant = 80
            userNameViewHeightAnchor?.isActive = false
            genderLabelHeightAnchor?.isActive = false
            emailViewHeightAnchor?.constant = 40
            passwordViewHeightAnchor?.constant = 40
            sepLine2ViewHeightAnchor?.isActive = false
            
            
        }else if segmentedLoginRegToggle.selectedSegmentIndex == 1 {
            
            containerViewHeightAnchor?.constant = 120
            userNameViewHeightAnchor?.isActive = true
            genderLabelHeightAnchor?.isActive = true
            sepLine2ViewHeightAnchor?.isActive = true
            userNameViewHeightAnchor?.constant = 40
            passwordViewHeightAnchor?.constant = 40
            emailViewHeightAnchor?.constant = 40
            
        }
        
        
    }
    
    
    func loginTapped() {
        
        if segmentedLoginRegToggle.selectedSegmentIndex == 0 {
        
            handleLogin()
            
            
            
        } else if segmentedLoginRegToggle.selectedSegmentIndex == 1 {
            
            registerCheck()
        }
    }
    
    
    
///********************************************************************************FIREBASE FUNCTIONS************************************************************************************************//

    
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
                    
               ///******************************CREATION OF USER IN DATABASE*********************************//
                    
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
                        
                        if error != nil {
                            //add alert for Email invalid/Duplicate/PasswordIncorrect
                            
                            let alert = UIAlertController(title: "Password/Email Invalid", message: "Error - \(error)", preferredStyle: .alert)
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
                        
                        let ref = FIRDatabase.database().reference(fromURL: "https://news-cc704.firebaseio.com/")
                        let userRef = ref.child("Users").child(uid)
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
                        
                    })
                    
    ///***************************************************************************************************************//
                    
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
            
            
            
            //prompt for not selected gender
            
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
            
            let alert = UIAlertController(title: "Invalid Email/Password", message: "Error - \(error)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
                
            
            
            self.present(alert, animated: true, completion: nil)
            self.indicatorContainerView.isHidden = true
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
                
            return
            }
            
            print("login in successful")
            
            let home = HomeController()
            home.modalPresentationStyle = .overCurrentContext
            
            let navController = UINavigationController(rootViewController: home)
            
            self.present(navController, animated: true, completion: nil)
            
            self.indicatorContainerView.isHidden = true
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()

            
        })
        
    }
    
    
    ///*************************************************************************UIPICKER FUNCTIONS*****************************************************************************************************//
    
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
    
    
    
    
///********************************************************************************VIEW FUNCTIONS************************************************************************************************//
    
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
            self.containerViewTop?.isActive = true
            self.containerViewTop?.constant = 130
            self.containerViewYPriority?.isActive = false
            self.view.layoutIfNeeded()
        }
        
        
        
        
        
    }
    
    func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.8) {
            
            self.containerViewTop?.isActive = false
            self.containerViewYPriority?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    


}






