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
    
    let genders: [String] = ["Male", "Female", "Alien", "Santa", "Kanye West"]
    
    // forgot password screen properties < located @ loginButtonFunctions
    var verifyView: UIView?
    var verifyEmail: UITextField?
    var verifyDetails: UITextField?
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                            // ***************  Icon Creation  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    

    
    
    lazy var emailIcon: UIImageView = {
        
       let iconV = UIImageView()
        iconV.backgroundColor = .clear
        iconV.image = UIImage(named: "EmailIcon")
        
        
        
        iconV.translatesAutoresizingMaskIntoConstraints = false
        
        return iconV
        
        
    }()

    
    lazy var passwordIcons: UIImageView = {
        
        let iconVs = UIImageView()
        iconVs.backgroundColor = .clear
        iconVs.image = UIImage(named: "passwordIcon")
        
        
        
        iconVs.translatesAutoresizingMaskIntoConstraints = false
        
        return iconVs
        
        
    }()

    
    lazy var userIcon: UIImageView = {
        
        let iconVs = UIImageView()
        iconVs.backgroundColor = .clear
        iconVs.image = UIImage(named: "userIcon")
        
        
        
        iconVs.translatesAutoresizingMaskIntoConstraints = false
        
        return iconVs
        
        
    }()
    
    
    
    lazy var appLogo: UIImageView = {
        
       let app = UIImageView()
        app.backgroundColor = .clear
        app.image = UIImage(named: "Dlogo")
        
        app.translatesAutoresizingMaskIntoConstraints = false
        
        return app
    }()
        
        
        

    
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                            // ***************  Porperty/Views  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    
    lazy var forgotPassword: UILabel = {
        
        let forgotLabel = UILabel()
        forgotLabel.text = "Forgot your password?"
        forgotLabel.textColor = UIColor(red: 114/255.0, green: 110/255.0, blue: 133/255.0, alpha: 1)
        forgotLabel.font = UIFont(name: "Avenir", size: 12)
        forgotLabel.translatesAutoresizingMaskIntoConstraints = false
        forgotLabel.isUserInteractionEnabled = true
        forgotLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped)))
        
        return forgotLabel
        
    }()
    
    
    
    lazy var loadingIndicatorText: UILabel = {
        
       let indicatorText = UILabel()
        indicatorText.text = "Loading..."
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

 
    
    
    lazy var getGender: UIPickerView = {
       
        let gendersss = UIPickerView()
        gendersss.delegate = self
        gendersss.dataSource = self
        gendersss.translatesAutoresizingMaskIntoConstraints = false
        
    
        
        
        
        return gendersss
    }()
    
    
    lazy var backgroundImage: UIImageView = {
        
        let bkImage = UIImageView()
        bkImage.image = UIImage(named: "captures")
        bkImage.translatesAutoresizingMaskIntoConstraints = false
        bkImage.contentMode = .scaleAspectFill
        bkImage.isUserInteractionEnabled = true
        bkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
        
        return bkImage
    }()
    
    lazy var backgroundBlur: UIVisualEffectView = {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let views = UIVisualEffectView(effect: blurEffect)
        views.translatesAutoresizingMaskIntoConstraints = false
        views.isHidden = false
        views.alpha = 0.6
        
        
        return views
        
        
        
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
        password.returnKeyType = .go
        password.clearsOnBeginEditing = true
        
        
        
        return password
    }()
    
    
    lazy var signUpSignInButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 16)
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
        email.returnKeyType = .continue
        email.clearsOnInsertion = true
        email.keyboardType = UIKeyboardType.emailAddress

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
    
    
    
    

    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                            // ***************  View Did Load  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        view.isUserInteractionEnabled = true
        indicatorContainerView.isHidden = true
        activityIndicator.stopAnimating()

        
        backgroundConstrainst()
        segmentedLoginRegToggle.removeBorders()
        containerContstraint()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        genderLabel.inputView = getGender
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("*******MEMORY WARNING IN LOGIN CONTROLLER*********")
       
    }
    
    
    
     

}






