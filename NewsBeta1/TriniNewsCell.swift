//
//  NewsCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 2/13/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit

class TriniNewsCell: BaseCell {
    
    let reportNameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .blue
        label.font = UIFont(name: "Avenir Next", size: 14)
        
        
        return label
    }()

    
    let reportLabel: UILabel = {
        
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "By reporter"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 10)
        
        
        return label
    }()
    
    
    let postedImageView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        postedView.clipsToBounds = true
        
       return postedView
    }()
    
    
    let postedTextView: UITextView = {
        
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        field.backgroundColor = .white
        field.autocorrectionType = .yes
        field.autocapitalizationType = .sentences
        field.isEditable = false
        
        
        return field
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        postedImageViewConstraints()
        postedTextViewConstraints()
        reporterLabelConstraints()
        
    }
    
    func postedImageViewConstraints() {
        
        addSubview(postedImageView)
        
        postedImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        postedImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3).isActive = true
        postedImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2).isActive = true
        postedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    
    func postedTextViewConstraints() {
        
        addSubview(postedTextView)
        
        postedTextView.leftAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: 5).isActive = true
        postedTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/3).isActive = true
        postedTextView.heightAnchor.constraint(equalTo: postedImageView.heightAnchor).isActive = true
        postedTextView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
    }
    
    func reporterLabelConstraints() {
        
        addSubview(reportLabel)
        addSubview(reportNameLabel)
        
        
        reportLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        reportLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/6).isActive = true
        reportLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/4).isActive = true
        reportLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        reportNameLabel.leftAnchor.constraint(equalTo: reportLabel.rightAnchor, constant: 2).isActive = true
        reportNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/4).isActive = true
        reportNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/4).isActive = true
        reportNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
 
    }
    
    
    
}
