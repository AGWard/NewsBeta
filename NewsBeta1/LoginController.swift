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
    

    
    ///*************************************************************************CREATING ICONS*****************************************************************************************************//
    
    let emailIcon: UIImageView = {
        
       let iconV = UIImageView()
        iconV.backgroundColor = .clear
        iconV.image = UIImage(named: "EmailIcon")
        
        
        
        iconV.translatesAutoresizingMaskIntoConstraints = false
        
        return iconV
        
        
    }()

    
    let passwordIcons: UIImageView = {
        
        let iconVs = UIImageView()
        iconVs.backgroundColor = .clear
        iconVs.image = UIImage(named: "passwordIcon")
        
        
        
        iconVs.translatesAutoresizingMaskIntoConstraints = false
        
        return iconVs
        
        
    }()

    
    let userIcon: UIImageView = {
        
        let iconVs = UIImageView()
        iconVs.backgroundColor = .clear
        iconVs.image = UIImage(named: "userIcon")
        
        
        
        iconVs.translatesAutoresizingMaskIntoConstraints = false
        
        return iconVs
        
        
    }()
    
    
    
    let appLogo: UIImageView = {
        
       let app = UIImageView()
        app.backgroundColor = .clear
        app.image = UIImage(named: "Dlogo")
        
        app.translatesAutoresizingMaskIntoConstraints = false
        
        return app
    }()
        
        
        

    
    
    
    ///*************************************************************************PROPERTY/VIEWS SETUP*****************************************************************************************************//
    
    
    
    lazy var forgotPassword: UILabel = {
        
       let forgotLabel = UILabel()
        forgotLabel.text = "Forgot your password?"
        forgotLabel.textColor = UIColor(red: 114/255.0, green: 110/255.0, blue: 133/255.0, alpha: 1)
        forgotLabel.font = UIFont(name: "Avenir", size: 12)
        forgotLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return forgotLabel
        
    }()
    
    
    
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
        bkImage.image = UIImage(named: "SignIn")
        bkImage.translatesAutoresizingMaskIntoConstraints = false
        bkImage.contentMode = .scaleAspectFit
        
        
        return bkImage
    }()
    
    
    lazy var continerView: UIView = {
       
        let containV = UIView()
        containV.backgroundColor = .clear
        containV.layer.cornerRadius = 10
        containV.translatesAutoresizingMaskIntoConstraints = false
        containV.layer.masksToBounds = true
        
        
        return containV
    }()
    
    lazy var genderLabel: UITextField = {
        
        let gpicker = UITextField()
        gpicker.backgroundColor = .clear
        gpicker.text = "gender"
        gpicker.font = UIFont.boldSystemFont(ofSize: 12)
        gpicker.textAlignment = .center
        gpicker.delegate = self
        gpicker.textColor = .lightGray
        
        
        
        
        gpicker.translatesAutoresizingMaskIntoConstraints = false
        
        return gpicker
    }()
    
    
    lazy var userNameLabel: UITextField = {
        
        
        var mutableString = NSMutableAttributedString()
        let textEmail = "username"
        mutableString = NSMutableAttributedString(string: textEmail, attributes: [NSFontAttributeName:UIFont(name: "Avenir Next", size: 16)!])
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: NSRange(location: 0, length: textEmail.characters.count))
    
        
        let user = UITextField()
        user.attributedPlaceholder = mutableString
        user.textColor = .white

        user.backgroundColor = .clear
        user.delegate = self

        user.translatesAutoresizingMaskIntoConstraints = false
        
        return user
    }()
    
    
    lazy var passwordLabel: UITextField = {
        
        
        var mutableString = NSMutableAttributedString()
        let textEmail = "password"
        mutableString = NSMutableAttributedString(string: textEmail, attributes: [NSFontAttributeName:UIFont(name: "Avenir Next", size: 16)!])
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: NSRange(location: 0, length: textEmail.characters.count))
        
        let password = UITextField()
        password.attributedPlaceholder = mutableString
        password.isSecureTextEntry = true
        password.backgroundColor = .clear
        password.delegate = self
        password.textColor = .white
       
        password.translatesAutoresizingMaskIntoConstraints = false
        
        return password
    }()
    
    
    lazy var signUpSignInButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 16)
//        button.layer.cornerRadius = 60 * 0.5
       button.backgroundColor = UIColor(red: 72/255.0, green: 68/255.0, blue: 86/255.0, alpha: 1)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var seperatorLine: UIView = {
       
        let line = UIView()
        line.backgroundColor = UIColor(red: 165/255.0, green: 163/255.0, blue: 173/255.0, alpha: 1)
        line.layer.cornerRadius = 3
        line.translatesAutoresizingMaskIntoConstraints = false
        
        
        return line
    }()
    
    
    lazy var segmentedLoginRegToggle: UISegmentedControl = {
        
       let sc = UISegmentedControl(items: ["Sign In", "Sign Up"])
        sc.tintColor = .white
        sc.selectedSegmentIndex = 0
        
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(toggleTapped), for: .valueChanged)
        
        return sc
    }()
    
    lazy var emailLabel: UITextField = {
        
        var mutableString = NSMutableAttributedString()
        let textEmail = "email"
        mutableString = NSMutableAttributedString(string: textEmail, attributes: [NSFontAttributeName:UIFont(name: "Avenir Next", size: 14)!])
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: NSRange(location: 0, length: textEmail.characters.count))
        
        let email = UITextField()
        email.attributedPlaceholder = mutableString
        email.backgroundColor = .clear
        email.delegate = self
        email.textColor = .white
        
        
        
        
        email.translatesAutoresizingMaskIntoConstraints = false
        
        return email
    }()
    
    lazy var seperatorLine2: UIView = {
        
        let line = UIView()
        line.backgroundColor = UIColor(red: 165/255.0, green: 163/255.0, blue: 173/255.0, alpha: 1)
        line.layer.cornerRadius = 3
        line.translatesAutoresizingMaskIntoConstraints = false
        
        
        return line
    }()
    
    lazy var seperatorLine3: UIView = {
        
        let line = UIView()
        line.backgroundColor = UIColor(red: 165/255.0, green: 163/255.0, blue: 173/255.0, alpha: 1)
        line.layer.cornerRadius = 3
        line.translatesAutoresizingMaskIntoConstraints = false
        
        
        return line
    }()


    var containerViewHeightAnchor: NSLayoutConstraint?
    var containerViewTop: NSLayoutConstraint?
    var containerViewYPriority: NSLayoutConstraint?

    
    var emailViewHeightAnchor: NSLayoutConstraint?
    var sepLine2ViewHeightAnchor: NSLayoutConstraint?
    var userNameViewHeightAnchor: NSLayoutConstraint?
    var passwordViewHeightAnchor: NSLayoutConstraint?
    var genderLabelHeightAnchor: NSLayoutConstraint?

    
    
///******************************************************************************VIEW DID LOAD*******************************************************************************************************//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        segmentedLoginRegToggle.removeBorders()
        UIApplication.shared.statusBarStyle = .lightContent
        view.backgroundColor = UIColor(red: 77/255.0, green: 74/255.0, blue: 92/255.0, alpha: 1)
        
        view.isUserInteractionEnabled = true
        indicatorContainerView.isHidden = true
        activityIndicator.stopAnimating()
        
//        backgroundConstrainst()
        containerContstraint()
        textFieldContraints()
        loginRegisButtonConstraints()
        segmentedToggleContraints()
        indicatorConstraints()
        indicatorActivityContainerConstraints()
        loadingIndicatorTextConstraints()
        forgotPasswordConstraints()
        appLogoConstraints()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        genderLabel.inputView = getGender
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    
    
    
    
///*********************************************************************************BUTTON FUNCTIONS*************************************************************************************************//
    
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






