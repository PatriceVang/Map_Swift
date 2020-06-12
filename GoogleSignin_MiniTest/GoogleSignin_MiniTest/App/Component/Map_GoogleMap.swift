//
//  Map_GoogleMap.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import GoogleMaps


class GoogleMap: GMSMapView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
