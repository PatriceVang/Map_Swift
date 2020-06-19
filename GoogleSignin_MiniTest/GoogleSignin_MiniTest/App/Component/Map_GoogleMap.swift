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
    let marker = GMSMarker()
    let circleLocation = GMSCircle()
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
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (Timer) in
            self.locationManager.startUpdatingLocation()
        }
        
        //--- Set up current location MapView
        delegate = self
  
        setupCircleLocation()
        setupMarker()
    }
    
    func setupMarker() {
        let marketV = UIView()
        marketV.backgroundColor = Resource.Color.pickerColor
        marketV.frame.size = .init(width: 25, height: 25)
        marketV.addRadius(radius: marketV.frame.height / 2)
        let markerImg = UIImageView()
        markerImg.frame.size = .init(width: 20, height: 20)
        markerImg.center = marketV.center
        markerImg.contentMode = .scaleAspectFill
        markerImg.image = Resource.Image.maker
        marketV.addSubview(markerImg)
        marker.iconView = marketV
        marker.isTappable = false
        marker.map = self
    }
    func setupCircleLocation() {
        circleLocation.radius = 130
        circleLocation.fillColor = UIColor(white: 0.7, alpha: 0.5)
        circleLocation.strokeColor = Resource.Color.circleLocationColor
        DispatchQueue.main.async {
            self.circleLocation.map = self
        }
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

        //--- Update position marker
        marker.position = userLocation.coordinate
        
        //--- Circle Location
        circleLocation.position = userLocation.coordinate
        
        //--- stop update location
        locationManager.stopUpdatingLocation()
        
        //--- use set up camera
        currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

extension GoogleMap: GMSMapViewDelegate {
    
}



