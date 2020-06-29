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
    var coordinate: [Coordinate]?
    enum CodingKeys: String, CodingKey {
        case coordinate = "results"
    }
}

struct Coordinate: Codable {
    var name: String?
    var rating: Double?
    var street: String?
    var lat: Double?
    var lng: Double?
    var address: String {
//      city =  "RM9P+R7 Phường 4, Gò Vấp, Ho Chi Minh City"
        //--- Delete RM9P+R7
        let newCity = city?.components(separatedBy: " ")
        var result = ""
        for i in 0..<newCity!.count {
            if result != nil {
                result += " "
            }
            if i > 0 {
                result += newCity![i]
            }
        }
        return "\(street ?? "")\(result)"
    }
    private var city: String?
    private var location: Location?
    
    enum CoordinateKeys: String, CodingKey {
        case name
        case rating
        case geometry = "geometry"
        case plusCode = "plus_code"
        case street = "vicinity"
    }
    
    enum AddressKeys: String, CodingKey {
        case city = "compound_code"
    }
    
    enum GeometryKeys: String, CodingKey {
        case location = "location"
    }
    
    enum LocationKeys: String, CodingKey {
        case lat
        case lng
    }
    
    init(from decoder: Decoder) throws {
        if let coordinateContainer = try? decoder.container(keyedBy: CoordinateKeys.self) {
            self.name = try coordinateContainer.decode(String.self, forKey: .name)
            self.rating = try coordinateContainer.decode(Double.self, forKey: .rating)
            self.street = try coordinateContainer.decode(String.self, forKey: .street)
            
            if let addressContainer = try? coordinateContainer.nestedContainer(keyedBy: AddressKeys.self, forKey: .plusCode) {
                self.city = try addressContainer.decode(String.self, forKey: .city)
            }
            
            if let geoContainer = try? coordinateContainer.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry) {
                self.location = try geoContainer.decode(Location.self, forKey: .location)
                
                if let locationContainer = try? geoContainer.nestedContainer(keyedBy: LocationKeys.self, forKey: .location) {
                    self.lng = try locationContainer.decode(Double.self, forKey: .lng)
                    self.lat = try locationContainer.decode(Double.self, forKey: .lat)
                }
            }
        }
    }
}

struct Location: Codable {
    var lat: Double?
    var lng: Double?
}
///

//"results": [
//     {
//        "business_status": "OPERATIONAL",
//        "geometry": {
//           "location": {
//              "lat": 10.8196051,
//              "lng": 106.6856857
