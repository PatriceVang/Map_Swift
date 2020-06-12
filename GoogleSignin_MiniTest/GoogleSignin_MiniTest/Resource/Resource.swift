//
//  Resource.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/9/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit


class Resource {
    
    static let shared = Resource()
    
    //MARK:--- Image
    class Image {
        let google: UIImage = UIImage(named: "google_img")!
        let camera: UIImage = UIImage(named: "cameraWhite_img")!
        let menuSearch: UIImage = UIImage(named: "menuSearch_img")!
        let stack: UIImage = UIImage(named: "stack_img")!
        
    }
    //MARK:--- Color
    class Color {
        let pickerColor: UIColor = #colorLiteral(red: 0.000219328067, green: 0.164696604, blue: 0.49053514, alpha: 1)
    }
    
}
