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
//    var firstLocation = Observable<CLLocation>(value: .init(latitude: 0, longitude: 0))
    
    init() {}
    //--- Call API
    func fetchData(currentLocation: CLLocation) {
        let lat2 = 106.6352
        let log2 = 10.7481
        APICaller.getMethod([Coordinate].self, url: "http://api.openfpt.vn/fbusinfo/businfo/getstopsinbounds/\(currentLocation.coordinate.longitude)/\(currentLocation.coordinate.latitude)/\(lat2)/\(log2)") { (coor) in
            DispatchQueue.main.async {
                print(coor.map{ $0.lat})
            }
        }
    }
}
