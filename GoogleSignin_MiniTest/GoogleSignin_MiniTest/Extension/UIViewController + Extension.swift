//
//  UIViewController + Extension.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/29/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapOutside))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func onTapOutside() {
        print("tap")
        self.view.endEditing(true)
    }
}


