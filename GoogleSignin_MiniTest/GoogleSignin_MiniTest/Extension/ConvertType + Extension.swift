//
//  ConvertType.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/22/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit
import CoreLocation

extension Double {
    func convertDegree() -> CLLocationDegrees {
        return CLLocationDegrees(exactly: self)!
    }
}




