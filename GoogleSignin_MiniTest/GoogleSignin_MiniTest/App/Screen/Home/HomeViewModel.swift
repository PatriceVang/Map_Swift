//
//  HomeViewModel.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/18/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation


class HomeViewModel {
    
    var stateMap = Observable<Bool>(value: false)
    
    init() {
        self.stateMap.value = UserDefaultHelpers.shared.useGoogleMap
    }
}
