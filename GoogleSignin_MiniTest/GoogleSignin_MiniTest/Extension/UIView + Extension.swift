//
//  UIView + Extension.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/9/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit


extension UIView {
    //MARK:--- Radius
    func addRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    //MARK:--- Shadow
    func addShadow(color: CGColor, opacity: Float, radius: CGFloat, offset: CGSize) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color
        self.layer.shadowRadius =  radius
        self.layer.shadowOffset = offset
        self.layer.masksToBounds = false
    }
    //MARK:--- Tap Gesture
    func addGesture(taget: Any, selector: Selector) {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: taget, action: selector))
    }
}
