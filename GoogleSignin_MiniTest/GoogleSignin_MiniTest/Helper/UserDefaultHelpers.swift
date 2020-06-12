//
//  UserDefaultHelpers.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation

enum UserDefaultKeys: String {
    case switchMap = "switchMap"
}

class UserDefaultHelpers {
    static let shared = UserDefaultHelpers()
    
    //--- Use to Switch Map
    var useGoogleMap: Bool {
        set {
            saveObjet(object: newValue, key: .switchMap)
        }
        get {
            let currentValue =  loadObject(Bool.self, key: .switchMap)
            return currentValue ?? false
        }
    }
    
    //MARK:--- Save
    private func saveObjet(object: Any, key: UserDefaultKeys) {
        UserDefaults.standard.set(object, forKey: key.rawValue )
    }
    //MARK:--- Load
    private func loadObject<T>(_ : T.Type, key: UserDefaultKeys) -> T? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
}
