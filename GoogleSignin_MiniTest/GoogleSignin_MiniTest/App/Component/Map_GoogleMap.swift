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

//enum CircleAnimation {
//    case In
//    case Out
//}

class GoogleMap: GMSMapView {
    var locationManager = CLLocationManager()
//    let marker = GMSMarker()
    var markerPoiSubcription: NSObjectProtocol?
    //--- Circle Location
//    var circleAnimation = CircleAnimation.Out
//    var circleLocation = GMSCircle()
    var arrRadius : [GMSCircle] = [GMSCircle]()
    var radius : Int = 50

    
    //--- setup Camera
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
        
        //--- Set up current location MapView
        delegate = self
        self.isMyLocationEnabled = true
  
    
//        setupMarker()
//        setupCircleLocation()
        setupMarketPOI()
    }
    
    deinit {
        //--- Remove observer
        NotificationCenter.default.removeObserver(markerPoiSubcription as Any, name: .markerPOI, object: nil)
    }

    
    func setupMarketPOI() {
        markerPoiSubcription = NotificationCenter.default.addObserver(forName: .markerPOI, object: nil, queue: .main) { [weak self] (notification) in
            guard let self = self else {return}
            self.clear()
            if let userInfo = notification.userInfo as? [String: Any],
                let location = userInfo["markerPOI"] as? [Location], let markerType = userInfo["markerType"] as? String {
                location.map { loc in
                    let marker = GMSMarker()
                    let markerV = UIView()
                    markerV.frame.size = .init(width: 25, height: 25)
                    let markerImg = UIImageView()
                    markerImg.frame = markerV.bounds
                    switch markerType {
                    case TypePOI.bus.rawValue:
                        markerImg.image = Resource.Image.bus
                    case TypePOI.cafe.rawValue:
                        markerImg.image = Resource.Image.cafe
                    case TypePOI.hotel.rawValue:
                        markerImg.image = Resource.Image.hotel
                    case TypePOI.restaurant.rawValue:
                        markerImg.image = Resource.Image.restaurant
                    default:
                        break
                    }
                    markerV.addSubview(markerImg)
                    
                    marker.iconView = markerV
                    marker.position = CLLocationCoordinate2D(latitude: (loc.lat?.convertDegree())!, longitude: (loc.lng?.convertDegree())!)
                    marker.map = self
                }
                if let curentLocation = self.currentLocation {
                    self.camera = GMSCameraPosition.camera(withLatitude: curentLocation.coordinate.latitude, longitude: curentLocation.coordinate.longitude, zoom: 12)
                }
            }
        }
    }
    
//    func setupMarker() {
//        let marketV = UIView()
//        marketV.backgroundColor = Resource.Color.pickerColor
//        marketV.frame.size = .init(width: 27, height: 27)
//        marketV.addRadius(radius: marketV.frame.height / 2)
//        let markerImg = UIImageView()
//        markerImg.frame.size = .init(width: 20, height: 20)
//        markerImg.center = marketV.center
//        markerImg.contentMode = .scaleAspectFill
//        markerImg.image = Resource.Image.maker
//        marketV.addSubview(markerImg)
//        marker.iconView = marketV
//        marker.isTappable = false
//        marker.map = self
//
//    }
//    func setupCircleLocation() {
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.setupAnimationCircleLocation), userInfo: nil, repeats: true)
//        }
//
//        let update = GMSCameraUpdate.fit(circleLocation.bound())
//        self.animate(with: update)
//    }
//    @objc func setupAnimationCircleLocation() {
//
//        circleLocation.radius = CLLocationDistance(radius)
//        circleLocation.fillColor = UIColor(red: 0.8144833446, green: 0.8457677364, blue: 0.9246796966, alpha: 0.5)
//        circleLocation.strokeColor = Resource.Color.circleLocationColor
//
//        if circleAnimation == .Out {
//            radius += 5
//            if radius >= 120 {
//                radius = 120
//                circleAnimation = .In
//            }
//        } else {
//            radius = 50
//            circleAnimation = .Out
//
//        }
//        arrRadius.append(circleLocation)
//
//         self.circleLocation.map = self
//        if arrRadius.count > 0 {
//            for i in 0..<arrRadius.count {
//                let circle = arrRadius[i]
//                circle.map = nil
//                arrRadius.removeAll(where: { $0 == circle})
//            }
//        }
//    }
    
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
//        marker.position = userLocation.coordinate

        //--- Circle Location
//        circleLocation.position = userLocation.coordinate
        
        //--- stop update location
        locationManager.stopUpdatingLocation()
        
        //--- use set up camera
        currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

extension GoogleMap: GMSMapViewDelegate {}

//extension GMSCircle {
//    func bound() -> GMSCoordinateBounds {
//        func locationMinMax(_ positive: Bool) -> CLLocationCoordinate2D {
//            let sign: Double = positive ? 1 : -1
//            let dx = sign * self.radius / 6378000 * (180 / .pi)
//            let lat = position.latitude + dx
//            let long =  position.longitude + dx / cos(position.latitude * .pi / 180)
//            return CLLocationCoordinate2D(latitude: lat, longitude: long)
//        }
//        return GMSCoordinateBounds(coordinate: locationMinMax(true), coordinate: locationMinMax(false))
//    }
//}
