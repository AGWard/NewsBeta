//
//  PostingPageController.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 3/21/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices
import AVFoundation
import SVProgressHUD


class PostingPageController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let currentID = Auth.auth().currentUser?.uid
    
    fileprivate let area = ["Arima", "Arouca/Maloney", "Barataria/San Juan", "Black Rock", "Bon Air", "Cambee", "Caroni", "Chaguanas", "Charlotteville", "Couva", "Crown Point", "Cumuto", "D'Abadie/O'Meara", "Diego Martin", "Fyzabad", "La Brea", "La Horquette", "Laventille", "Lopinot", "Manzanilla", "Mayaro", "Moruga/Tableland", "Naparima", "Oropouche", "Point Fortin", "Pointe-A-Pierre", "Port Of Spain", "Princess Town", "Scarborough", "San Fernando", "Siparia", "St.Anns", "St.Augustine", "St.Joseph", "Tabaquite", "Toco", "Tunapuna", "International"]
    
    
    lazy var date = Date()
    
    var selectedVidURL: URL?
    
    
    
     lazy var areaSelection: UIPickerView = {
        
       let area = UIPickerView()
        area.delegate = self
        area.dataSource = self
        area.translatesAutoresizingMaskIntoConstraints = false
        
        return area
    }()
    
    lazy var areaLabel: UITextField = {
        
        let gpicker = UITextField()
        
        gpicker.backgroundColor = .lightGray
        gpicker.text = "Area of News"
        gpicker.font = UIFont.boldSystemFont(ofSize: 16)
        gpicker.textAlignment = .center
        gpicker.delegate = self
        gpicker.textColor = .darkText
        
        
        
        
        
        gpicker.translatesAutoresizingMaskIntoConstraints = false
        
        return gpicker
    }()

    
    
    lazy var bottomView: UIView = {
        
       let views = UIView()
        views.translatesAutoresizingMaskIntoConstraints = false
        views.backgroundColor = .white
    
        return views
        
    }()
    
 
    
    lazy var newsTypeLabel: UILabel = {
        
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .darkText
        lable.text = "News Type -"
        lable.font = UIFont(name: "Avenir Next", size: 13)

        
        return lable
        
    }()
    
    
    
    lazy var goodBadSeg: UISegmentedControl = {
        
        let sc = UISegmentedControl(items: ["None", "👎🏼", "👍🏼"])
        sc.tintColor = .white
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(goodBadSegTapped), for: .valueChanged)
        
        return sc
        
    }()
    
    
    
    
    lazy var formatter: DateFormatter = {
        
        let matter = DateFormatter()
        matter.locale = Locale(identifier: "en_US_POSIX")
        matter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        matter.timeZone = TimeZone(abbreviation: "UTC")
        
        
        return matter
    }()
    
    
    lazy var newsHeadline: UITextField = {
        
       let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = " NEWS HEADLINES HERE"
        field.font = UIFont(name: "American Typewriter", size: 18)
        field.textColor = .black
        field.backgroundColor = .white
        field.delegate = self
        field.autocapitalizationType = .allCharacters
        field.delegate = self
        field.autocorrectionType = .yes
        field.textAlignment = .center

        
        return field
    }()
    
    

    
    lazy var postButton: UIButton = {
        
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "post"), for: .normal)
        button.addTarget(self, action: #selector(postNews), for: .touchUpInside)
        button.isEnabled = true
        
        return button
    }()
    
    
    lazy var postedTextLabel: UILabel = {
        
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .darkText
        lable.textAlignment = .center
        lable.text = "Tell us more about your story"
        lable.font = UIFont.boldSystemFont(ofSize: 13)
        lable.backgroundColor = .white
        
        return lable
        
    }()
    
    
    lazy var postTextField: UITextView = {
        
       let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.autocorrectionType = .yes
        field.autocapitalizationType = .sentences
        field.delegate = self

        
        
        return field
    }()
    
    
    
    lazy var selectedPic: UIImageView = {
        
       let pic = UIImageView()
        pic.image = UIImage(named: "selectPicSquare")
        pic.contentMode = .scaleAspectFill
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.clipsToBounds = true
        pic.isUserInteractionEnabled = true
        pic.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectVideo)))
        
        
        return pic
        
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        newsHeadlineConstraints()
        postButton.isEnabled = true
        postedPicConstraints()
        postedTextLabelConstraints()
        postedTextFieldConstraints()
        goodBadSegConstraints()
        newsTypeLabelConstraints()
        bottomViewConstraints()
        areaLabelConstraints()
        postButtonConstraints()
        
        
        areaLabel.inputView = areaSelection
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(postNews))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPosting))
        navigationItem.title = "NewsFeed"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)

        
        
       

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        print("MEMORY WARNING IN POSTING PAGE ****************")
        
    }
    
    func newsHeadlineConstraints() {
        
        view.addSubview(newsHeadline)
        
        newsHeadline.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 5).isActive = true
        newsHeadline.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        newsHeadline.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/16).isActive = true
        
        
        
    }

    
    
    func postedPicConstraints() {
        
        view.addSubview(selectedPic)
        
        let width = view.frame.width / 4
                
        selectedPic.widthAnchor.constraint(equalToConstant: width).isActive = true
        selectedPic.heightAnchor.constraint(equalToConstant: width).isActive = true
        selectedPic.topAnchor.constraint(equalTo: newsHeadline.bottomAnchor, constant: 5).isActive = true
        selectedPic.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        
    }
    
    func postedTextLabelConstraints() {
        
        view.addSubview(postedTextLabel)
        
        postedTextLabel.topAnchor.constraint(equalTo: selectedPic.bottomAnchor, constant: 10).isActive = true
        postedTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        postedTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        
    }

    
    
    func postedTextFieldConstraints() {
        
        view.addSubview(postTextField)
        
        postTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        postTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7).isActive = true
        postTextField.topAnchor.constraint(equalTo: postedTextLabel.bottomAnchor, constant: 1).isActive = true
        
        
    }
    
    
    func goodBadSegConstraints() {
        
        
        view.addSubview(goodBadSeg)
        
        
        goodBadSeg.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        goodBadSeg.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/18).isActive = true
        goodBadSeg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        goodBadSeg.topAnchor.constraint(equalTo: postTextField.bottomAnchor, constant: 5).isActive = true
        
        
    }
    
    
    func newsTypeLabelConstraints() {
        
        view.addSubview(newsTypeLabel)
        
        newsTypeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        newsTypeLabel.centerYAnchor.constraint(equalTo: goodBadSeg.centerYAnchor).isActive = true
        
        
        
    }
    
    
    
    func bottomViewConstraints() {
        view.addSubview(bottomView)
        
        
        bottomView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: goodBadSeg.bottomAnchor, constant: 5).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func postButtonConstraints() {
        
        bottomView.addSubview(postButton)
        
        postButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/8).isActive = true
        postButton.heightAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/8).isActive = true
        postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        
    }
    
    func areaLabelConstraints() {
        
        
        bottomView.addSubview(areaLabel)
        
        
        areaLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5).isActive = true
        areaLabel.widthAnchor.constraint(equalTo: bottomView.widthAnchor).isActive = true
        areaLabel.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/6).isActive = true
        
        
        
    }
    
    
    
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Header (aka NewsHeadline) character limit
        
        guard let text = textField.text else {
            
            return true
            
        }
        
        let newLengths = text.characters.count + string.characters.count - range.length
        
        return newLengths <=  25
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // News Body (aka postedTextField) character limit
        
        guard let textv = textView.text else {
            
            return true
        }
        
        let newLength = textv.characters.count + text.characters.count - range.length
        return newLength <= 300

        
    }
    

    
    @objc func cancelPosting() {
        
        dismiss(animated: true, completion: nil)
    }
    


    
    
    @objc func postNews() {
        
        print("Posting.............")
        

        postButton.isEnabled = false
        
        if selectedPic.image == nil || selectedPic.image == UIImage(named: "selectPicSquare") {
            
            let alert = UIAlertController(title: "Picture Required", message: "Share your news via a picture", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            postButton.isEnabled = true
            return
            
            
        }

        
        
        if newsHeadline.text == "" {
            
            let alert = UIAlertController(title: "Headline Required", message: "Enter some context about your news", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            postButton.isEnabled = true
            return

            
        }
        
        
        if goodBadSeg.selectedSegmentIndex == 0 {
            
            let alert = UIAlertController(title: "News Type Missing", message: "Please select a valid news type other than 'none'", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            postButton.isEnabled = true
            return
            
        }
        
        SVProgressHUD.showSuccess(withStatus: "Article Published")
        
        let utcTimeZoneStr = String(describing: date)
        let timestamp = Int(Date().timeIntervalSince1970)
        let timestampstring = String(timestamp)
        
        
        guard let textEntered = postTextField.text, let newsHeadlines = newsHeadline.text else {
            
            print("no data entered")  //TODO: <<<< eventually add a modal view to prompt user to enter both Headine and Body *********************************************************************
            return
            
        }
        
        let networkRequest = NetworkingService()
        networkRequest.saveNewsFeed(currentID!, headlines: newsHeadlines, newsBody: textEntered, image: selectedPic.image, videoImageURL: selectedVidURL, timestamp: timestampstring, timeUTC: utcTimeZoneStr, reporterName: registeredName!, userPorfileImage: registeredPicURL!)
        
        perform(#selector(dismissPostScreen), with: nil, afterDelay: 2)
    
    }
    
    
    @objc func dismissPostScreen() {
        
        dismiss(animated: true) {
            SVProgressHUD.dismiss()
        }
        
    }
    
    
    @objc func goodBadSegTapped() {

        switch goodBadSeg.selectedSegmentIndex {
        case 0:
            newsTypeLabel.text = "News Type -"
            print("select a type")
        case 1:
            newsTypeLabel.text = "News Type - 'Bad News'"
            print("Bad")
        case 2:
            newsTypeLabel.text = "News Type - 'Good News'"
            print("Good")
        default:
            print("segmented option missing")
            return
        }

    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return area.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return area[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        areaLabel.text = area[row]
        self.view.endEditing(true)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.areaLabel {
            
            self.areaSelection.isHidden = false
            textField.endEditing(true)
            
        }
        
    }
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ***************  Settings for show/hide keyboard when on a text field  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newsHeadline.resignFirstResponder()
        postTextField.resignFirstResponder()

        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
    
            self.view.layoutIfNeeded()
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        

            self.view.layoutIfNeeded()
        }
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ***************  Select pic or video functions  *********** //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    @objc func selectVideo() {
        
        SVProgressHUD.show(withStatus: "fetching photos")
        print("videos selected")
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
            
            self.present(imagePicker, animated: true, completion: nil)
            SVProgressHUD.dismiss()
            
        } else {
            
            print("not getting access to photo library")
        }
        
        
    }
    
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        SVProgressHUD.dismiss()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let videoURL = info[UIImagePickerControllerMediaURL] as? URL{
            
            
            selectedPic.image = videoPreviewImage(filename: videoURL)
            selectedVidURL = videoURL
            
            
            dismiss(animated: true, completion: nil)
            
        }
        
        
        
        
        
        var selectedImageFromPicker: UIImage?
        
        if let editImage = info [UIImagePickerControllerEditedImage] as? UIImage {
            
            selectedImageFromPicker = editImage
            
        } else if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            selectedImageFromPicker = chosenImage
            
            
        }
        
        if let selectedImage = selectedImageFromPicker {
            
            selectedPic.image = selectedImage
            
            
            dismiss(animated: true, completion: nil)
        }
        
    }

    
    func videoPreviewImage(filename: URL) -> UIImage? {
        
        
        let asset = AVURLAsset(url: filename)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 2, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
        
        
        
    }




    
}
