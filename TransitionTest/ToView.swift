//
//  ToView.swift
//  TransitionTest
//
//  Created by Maciej Koziel on 05/07/14.
//  Copyright (c) 2014 Maciej Koziel. All rights reserved.
//

import UIKit

class ToView: UIView {

    let titleLabel = UILabel(frame: CGRectZero)
    let subtitleLabel = UILabel(frame: CGRectZero)
    let titleImage = UIImageView(image: UIImage(named: "logo"))
    let textLabel = UILabel(frame: CGRectZero)
    
    init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.font = UIFont(name: "Helvetica", size: 15)
        titleLabel.text = "Title"
        addSubview(titleLabel)
        
        subtitleLabel.textAlignment = NSTextAlignment.Left
        subtitleLabel.font = UIFont(name: "Helvetica", size: 15)
        subtitleLabel.text = "Subtitle label"
        addSubview(subtitleLabel)
        
        addSubview(titleImage)
        
        textLabel.numberOfLines = 0
        textLabel.text = "Lorem Swiftum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        addSubview(textLabel)
        
        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.sizeToFit()
        titleLabel.frame = CGRectMake(5, 25, titleLabel.frame.size.width, titleLabel.frame.size.height)
        
        subtitleLabel.sizeToFit()
        subtitleLabel.frame = CGRectMake(frame.maxX - subtitleLabel.frame.width - 5, 25,
            subtitleLabel.frame.size.width, subtitleLabel.frame.size.height)
        
        titleImage.frame = CGRectMake(frame.width/2 - 30, 25, 60, 60)
        
        textLabel.frame = CGRectMake(5, titleLabel.frame.maxY + 40, 310, 300)
    }


}
