//
//  Model.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/16/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import CoreLocation


//--- Use POI
struct ResultJson: Codable {
    var results: [Result]?
}

struct Result: Codable {
    var geometry: Geometry?
}

struct Geometry: Codable {
    var location: Location?
}

struct Location: Codable {
    var lat: Double?
    var lng: Double?

}
///

//struct Coordinate: Codable {
//    var name: String?
//    var lat: Double?
//    var long: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case lat = "lat"
//        case long = "Lng"
//    }
//
//}
