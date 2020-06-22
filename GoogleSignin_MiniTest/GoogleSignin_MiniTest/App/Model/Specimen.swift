//
//  Specimen.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/21/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import RealmSwift




class Specimen: Object {
    @objc dynamic var name = ""
    @objc dynamic var specimenDescription = ""
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var created = Date()
}
