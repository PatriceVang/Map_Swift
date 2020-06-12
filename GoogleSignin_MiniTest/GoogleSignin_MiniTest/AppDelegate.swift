//
//  AppDelegate.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/9/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //--- Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "339883821140-2hp2k5cpsr35hr8hc26430b0n3qc672g.apps.googleusercontent.com"
        
        //--- API GoogleMap
        GMSServices.provideAPIKey("AIzaSyDCVVFZnx8eRESiWe2N5pjtuMBOl7ZJBM0")
        GMSPlacesClient.provideAPIKey("AIzaSyDCVVFZnx8eRESiWe2N5pjtuMBOl7ZJBM0")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

