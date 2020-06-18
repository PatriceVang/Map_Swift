//
//  Observable.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/18/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation



class Observable<T> {
    
    typealias Observable = (T) -> Void
    
    var value: T {
        didSet {
            observable?(value)
        }
    }
    
    var observable: Observable?
    
    func bindAndFire(observable: Observable?) {
        self.observable = observable
        observable?(value)
    }
    
    init(value: T) {
        self.value = value
    }
}
 
