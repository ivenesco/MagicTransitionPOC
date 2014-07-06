//
//  FromView.swift
//  TransitionTest
//
//  Created by Maciej Koziel on 05/07/14.
//  Copyright (c) 2014 Maciej Koziel. All rights reserved.
//

import UIKit

class FromView: UIView {

    let titleLabel = UILabel(frame: CGRectZero)
    let subtitleLabel = UILabel(frame: CGRectZero)
    let titleImage = UIImageView(image: UIImage(named: "logo"))
    
    init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.font = UIFont(name: "Helvetica", size: 15)
        titleLabel.text = "Title label"
        titleLabel.textColor = UIColor.whiteColor()
        addSubview(titleLabel)
        
        subtitleLabel.textAlignment = NSTextAlignment.Left
        subtitleLabel.font = UIFont(name: "Helvetica", size: 13)
        subtitleLabel.text = "subtitle label"
        subtitleLabel.textColor = UIColor.whiteColor()
        addSubview(subtitleLabel)
        
        addSubview(titleImage)

        
//        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.sizeToFit()
        titleLabel.frame = CGRectMake(5, 5, titleLabel.frame.size.width, titleLabel.frame.size.height)
        
        subtitleLabel.sizeToFit()
        subtitleLabel.frame = CGRectMake(5, frame.height - subtitleLabel.frame.height - 5,
            subtitleLabel.frame.size.width, subtitleLabel.frame.size.height)
        
        titleImage.frame = CGRectMake(frame.maxX - 65, frame.height/2 - 25, 50, 50)
    }
}
