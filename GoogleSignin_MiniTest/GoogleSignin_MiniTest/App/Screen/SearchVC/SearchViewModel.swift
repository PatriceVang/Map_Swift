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
    func fetchDataPOI(currentLocation: CLLocation, text: String) {
        APICaller.getMethod(ResultJson.self, url: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&radius=3000&type=\(text)&keyword=cruise&key=AIzaSyDzZ2ixVoy_vDGRrc52Axw45YifTu0qvQQ") { resultJson,err  in
            if err != nil {
                print(err?.localizedDescription as Any)
            } else {
                
                print(resultJson?.coordinate?.map { $0.address})
                
                let dataLocation: [AnyHashable: Any]? = ["markerPOI": resultJson?.coordinate as Any, "markerType": "\(text)"]
                NotificationCenter.default.post(name: .markerPOI, object: nil, userInfo: dataLocation)
            }
        }
    }
}

