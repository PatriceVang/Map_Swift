//
//  UIView + Extension.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/9/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit


extension UIView {
    func setRadius(for view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
}
