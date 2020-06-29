//
//  Validate.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/29/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation

class Validate {
    
    //--- Convert text from user input to param to call Api
    static func isValidateTypeOfText(text: String) -> String {
        let arrTextOfMapHotel = ["hotel", "hotels", "khach san", "khách sạn"]
        let arrTextOfMapBus = ["xe buyt", "xe buýt", "bus", "tram xe buyt", "trạm xe buýt", "xe bus"]
        let arrTextOfMapCafe = ["coffee", "quan cafe", "quán cafe", "quán cà phê", "ca phe"]
        for item in arrTextOfMapHotel {
            if text.lowercased() == item {
                return "hotels"
            }
        }
        for item in arrTextOfMapBus {
            if text.lowercased() == item {
                return "bus_station"
            }
        }
        for item in arrTextOfMapCafe {
            if text.lowercased() == item {
                return "cafe"
            }
        }
        return text
    }
}

