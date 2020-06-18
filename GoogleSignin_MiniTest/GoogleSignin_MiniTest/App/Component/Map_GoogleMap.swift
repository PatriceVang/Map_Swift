//
//  Map_GoogleMap.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces


class GoogleMap: GMSMapView {
    var locationManager = CLLocationManager()
    var isSetupCamera: Bool = true
    var currentLocation: CLLocation? {
        didSet {
            if let currentLocation = currentLocation, isSetupCamera == true {
                 setupCamera(coordinate: currentLocation)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //-- set up location
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        //--- After 30s update location once
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { (Timer) in
            self.locationManager.startUpdatingLocation()
        }
        
        //--- Set up MapView
        self.isMyLocationEnabled = true
        self.settings.myLocationButton = true
        
        
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadView() {
        isSetupCamera = true
    }
    private func setupCamera(coordinate: CLLocation) {
        self.camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: coordinate.coordinate.latitude, longitude: coordinate.coordinate.longitude), zoom: 15)
        self.isSetupCamera = false
    }
}

extension GoogleMap: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //--- get User's Location
        guard let userLocation = locations.last else {return}
        self.isMyLocationEnabled = true
    
        //--- make Marker
//        let maker = GMSMarker(position: .init(latitude: (userLocation?.coordinate.latitude)!, longitude: (userLocation?.coordinate.longitude)!))
//        maker.map = self
        
        //--- stop update location
        locationManager.stopUpdatingLocation()
        
        //--- use set up camera
        currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}



