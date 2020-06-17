//
//  Model.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/16/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation


struct Coordinate: Codable {
    var name: String?
    var lat: Double?
    var long: Double?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case lat = "Lat"
        case long = "Lng"
    }
    
}
