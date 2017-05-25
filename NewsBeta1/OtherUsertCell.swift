//
//  OtherUsertCell.swift
//  NewsBeta1
//
//  Created by Anthony Ward on 5/15/17.
//  Copyright © 2017 AppCo. All rights reserved.
//

import UIKit
import AVFoundation

class OtherUsertCell: BaseCell {
    
    var dataBaseCells: DatabaseProperties?
    
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        
        
        return indicator
        
    }()
    
    
    
    
    lazy var playButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "newPlayButton")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        button.addTarget(self, action: #selector(playotherUserVideo), for: .touchUpInside)
        button.tintColor = .red
        
        return button
        
    }()
    
    

    
    
    lazy var postedImageView: UIImageView = {
        
        let postedView = UIImageView()
        postedView.translatesAutoresizingMaskIntoConstraints = false
        postedView.backgroundColor = .white
        postedView.contentMode = .scaleAspectFill
        postedView.clipsToBounds = true

        
        return postedView
    }()
    
    lazy var newsHeadingLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.font = UIFont(name: "American Typewriter", size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    
        
    }()
    
    lazy var postedTextView: UITextView = {
        
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        field.backgroundColor = .clear
        field.autocorrectionType = .yes
        field.autocapitalizationType = .sentences
        field.isUserInteractionEnabled = false
        field.textColor = .blue
        
        return field
        
    }()

    
    override func setupViews() {
        super.setupViews()
       
        addConstraints()
      
        
    }
    
    
    func addConstraints() {
        
        addSubview(postedImageView)
        addSubview(newsHeadingLabel)
        addSubview(postedTextView)
        postedImageView.addSubview(playButton)
        
    
        
        postedImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        postedImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        postedImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3/4).isActive = true
        postedImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2).isActive = true
        
        newsHeadingLabel.leftAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: 5).isActive = true
        newsHeadingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        newsHeadingLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        newsHeadingLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/4).isActive = true
        
        postedTextView.topAnchor.constraint(equalTo: newsHeadingLabel.bottomAnchor, constant: 5).isActive = true
        postedTextView.leftAnchor.constraint(equalTo: postedImageView.rightAnchor, constant: 5).isActive = true
        postedTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        postedTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true

        playButton.centerYAnchor.constraint(equalTo: postedImageView.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: postedImageView.centerXAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    }
    
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    
    
    func playotherUserVideo() {
        

        print("anything")
        
        if let videoURLString = dataBaseCells?.postedVideoURL {
            
            if videoURLString != "NoVids" {
                
                let url = URL(string: (videoURLString))
                
                player = AVPlayer(url: url!)
                
                playerLayer = AVPlayerLayer(player: player)
                playerLayer?.frame = postedImageView.bounds
                postedImageView.layer.addSublayer(playerLayer!)
                
                
                
                player?.play()
                activityIndicator.startAnimating()
                playButton.isHidden = true
                
                print("attempt to play video")
                
            }
            
        }
        
        
        
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        activityIndicator.stopAnimating()
        playButton.isHidden = false
        
        
    }


    
}
