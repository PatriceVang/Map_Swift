//
//  Map_MapBox.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import Mapbox


class MapBox: MGLMapView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        self.setCenter(CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), zoomLevel: 9, animated: false)
        self.styleURL = url

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
