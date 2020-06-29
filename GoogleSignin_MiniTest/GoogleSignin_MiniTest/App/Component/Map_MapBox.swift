//
//  Map_MapBox.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import Mapbox
import CoreLocation


class MapBox: MGLMapView{
    var isSetupCamera: Bool = true
    var curentLocation: CLLocation? {
        didSet {
            if let currentLocation = curentLocation, isSetupCamera == true {
                setupCamera(currentLocation: currentLocation)
            }
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        //--- Style Map
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        self.styleURL = url
        
//        delegate = self
        
        
        //--- Location Manger
//        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { (Timer) in
            self.locationManager.startUpdatingLocation()
        }
        
        //--- Enable heading tracking mode so that the arrow will appear.
        self.setUserTrackingMode(.followWithHeading, animated: true, completionHandler: nil)
        self.showsUserHeadingIndicator = true
        self.showsUserLocation = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCamera(currentLocation: CLLocation) {
        self.setCamera(MGLMapCamera(lookingAtCenter: curentLocation!.coordinate, altitude: 700, pitch: 15, heading: 0), animated: true)
        isSetupCamera = false
    }
    
    func reloadCamera() {
        isSetupCamera = true
    }
}


//extension MapBox: MGLLocationManagerDelegate {
//
//    func locationManager(_ manager: MGLLocationManager, didUpdate locations: [CLLocation]) {
//        guard let userLocation = locations.last else {return}
//
//        self.showsUserLocation = true
//        self.userTrackingMode = .followWithHeading
//
//
//        //--- Anotation
//        anotaion.coordinate = userLocation.coordinate
//        self.addAnnotation(anotaion)
//
//        //--- Stop update lcation
//        locationManager.stopUpdatingLocation()
//
//        //--- Get curentLocation to  update Camera
//        curentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//    }
//
//    func locationManager(_ manager: MGLLocationManager, didUpdate newHeading: CLHeading) {
//
//    }
//
//    func locationManagerShouldDisplayHeadingCalibration(_ manager: MGLLocationManager) -> Bool {
//        return true
//    }
//
//    func locationManager(_ manager: MGLLocationManager, didFailWithError error: Error) {
//        print("Error: \(error.localizedDescription)")
//    }
//}


//extension MapBox: MGLMapViewDelegate {
//
//}




