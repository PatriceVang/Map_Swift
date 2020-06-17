//
//  Factory.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import UIKit


protocol MapFactory {
    func makeGoogleMap() -> GoogleMap
    func makeMapBox() -> MapBox
}

class ContainerFactory {
    //--- Use for Map
    var frame: CGRect?
}

extension ContainerFactory: MapFactory {
    //--- Create Google Map
    func makeGoogleMap() -> GoogleMap {
        return GoogleMap(frame: frame!)
    }
    //--- Create MapBox
    func makeMapBox() -> MapBox {
        return MapBox(frame: frame!)
    }
}



