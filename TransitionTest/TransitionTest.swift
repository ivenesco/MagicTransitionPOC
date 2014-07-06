//
//  TransitionTest.swift
//  TransitionTest
//
//  Created by Maciej Koziel on 05/07/14.
//  Copyright (c) 2014 Maciej Koziel. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class TransitionTest {
    
    var viewFrom: UIView
    var viewTo: UIView
    var mapping: Array<(UIView, UIView)>
    
    init(from: UIView, to: UIView) {
        viewFrom = from
        viewTo = to
        mapping = Array<(UIView, UIView)>()
    }
    
    func keyWindow() -> UIView {
        return UIApplication.sharedApplication().keyWindow
    }
    
    func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates:false)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return snapshotImage;
    }
    
    func generatePlaceholders() -> Array<(UIView, UIView, CGRect, CGRect)> {
        var array = Array<(UIView, UIView, CGRect, CGRect)>()
        
        let view1 = UIView(frame: viewFrom.frame)
        view1.backgroundColor = viewFrom.backgroundColor
        let view2 = UIView(frame: viewTo.frame)
        view2.backgroundColor = viewTo.backgroundColor
//        let view1Frame = view1.frame
//        let view2Frame = view2.frame
        let view1Frame = viewFrom.superview.convertRect(viewFrom.frame, toView: keyWindow())
        let view2Frame = viewTo.superview.convertRect(viewTo.frame, toView: keyWindow())
        array.append((view1, view2, view1Frame, view2Frame))
        
        for (v1, v2) in mapping {
            let i1 = imageWithView(v1)
            let i2 = imageWithView(v2)
            
            let iv1 = UIImageView(image: i1)
            let iv2 = UIImageView(image: i2)
//            let r1 = v1.superview.convertRect(v1.frame, toView: v1.superview.superview)
//            let r2 = v2.superview.convertRect(v2.frame, toView: v2.superview.superview)
            let r1 = v1.superview.convertRect(v1.frame, toView: keyWindow())
            let r2 = v2.superview.convertRect(v2.frame, toView: keyWindow())
            array.append((iv1 as UIView, iv2 as UIView, r1, r2))
        }
        
        return array
    }
    
    func placePlaceholderes(placeholders: Array<(UIView, UIView, CGRect, CGRect)>) {
        for (iv1, iv2, r1, r2) in placeholders {
//            viewFrom.superview.addSubview(iv1)
//            viewFrom.superview.addSubview(iv2)
            keyWindow().addSubview(iv1)
            keyWindow().addSubview(iv2)

        }
    }
    
    func cleanupPlaceholders(placeholders: Array<(UIView, UIView, CGRect, CGRect)>) {
        for (iv1, iv2, r1, r2) in placeholders {
            iv1.removeFromSuperview()
            iv2.removeFromSuperview()
        }
    }
    
    func movePlaceholders(placeholders: Array<(UIView, UIView, CGRect, CGRect)>, duration: NSTimeInterval) {
        for (iv1, iv2, r1, r2) in placeholders {
            iv1.frame = r1
            iv1.alpha = 1.0
            iv2.frame = r1
            iv2.alpha = 0.0
        }
        
        UIView.animateWithDuration(duration/4,
            delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                self.viewFrom.alpha = 0.0
            }, completion:{(x: Bool) in
                
                UIView.animateWithDuration(duration, delay: 0.0,
                    options: UIViewAnimationOptions.BeginFromCurrentState,
                    animations: {
                        for (iv1, iv2, r1, r2) in placeholders {
                            iv1.frame = r2
                            iv2.frame = r2
                            iv1.alpha = 0.0
                            iv2.alpha = 1.0
                        }
                    }, completion:{(x: Bool) in
                        UIView.animateWithDuration(duration/4, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {self.viewTo.alpha = 1.0}, completion: {(x: Bool) in
                            
                            self.cleanupPlaceholders(placeholders)
                            })
                    })
                
            })
    }
    
    func start() {
        let placeholders = generatePlaceholders()
        placePlaceholderes(placeholders)
        movePlaceholders(placeholders, duration: 0.75)
    }
    
    func addMapping(from: UIView, to: UIView) {
        mapping.append((from, to))
    }
}
