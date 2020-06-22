//
//  SearchViewModel.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/18/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import CoreLocation


class SearchViewModel {
    
    init() {}
    
    
    //--- Call API
    func fetchDataPOI(currentLocation: CLLocation, text: TypePOI) {
        APICaller.getMethod(ResultJson.self, url: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&radius=3000&type=\(text.rawValue)&keyword=cruise&key=AIzaSyDzZ2ixVoy_vDGRrc52Axw45YifTu0qvQQ") { resultJson,err  in
            if err != nil {
                print(err?.localizedDescription as Any)
            } else {
                let dataLocation: [AnyHashable: Any]? = ["markerPOI": resultJson?.results?.compactMap {$0.geometry?.location} as Any,
                                                         "markerType": "\(text.rawValue)"]
                NotificationCenter.default.post(name: .markerPOI, object: nil, userInfo: dataLocation)
            }
        }
    }
}

