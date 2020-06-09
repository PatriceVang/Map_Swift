//
//  LoginVC.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/9/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController {
    @IBOutlet weak var googleSignIn_Btn: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        goolgeSignIn()
        customElement()
    }
    //MARK: Custom Element
    private func customElement() {
        googleSignIn_Btn.setRadius(for: googleSignIn_Btn, radius: googleSignIn_Btn.frame.height / 2)
        googleSignIn_Btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapGoogleSignInBtn)))
        googleSignIn_Btn.isUserInteractionEnabled = true
    }
    
    //MARK: Google SignIn
    private func goolgeSignIn() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @objc private func onTapGoogleSignInBtn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
}


extension LoginVC: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        } else {
            print("login success")
            
        }
    }
}
