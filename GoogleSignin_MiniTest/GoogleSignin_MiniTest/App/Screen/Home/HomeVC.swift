//
//  HomeVC.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit
import Mapbox

class HomeVC: UIViewController{
    @IBOutlet weak var map_View: UIView!
    @IBOutlet weak var search_View: UIView!
    @IBOutlet weak var zoom_View: UIView!
    @IBOutlet weak var hamburger_Btn: UIView!
    @IBOutlet weak var camera_View: UIView!
    @IBOutlet weak var stacks_View: UIView!
    var locationGgMap: CLLocation = CLLocation(latitude: 0, longitude: 0)
    var locationMapBox: CLLocation = CLLocation(latitude: 0, longitude: 0)
    var passCurrentLocation: ((CLLocation) -> Void)?
    //--- Factory
    var factory = ContainerFactory()
    //--- Create Map
    lazy var googleMap = factory.makeGoogleMap()
    lazy var mapBox = factory.makeMapBox()
    var stateMap: Bool = false {
        didSet {
            if stateMap == true {
                googleMap.reloadView()
                mapBox.removeFromSuperview()
                map_View.addSubview(googleMap)
            } else {
                mapBox.reloadCamera()
                googleMap.removeFromSuperview()
                map_View.addSubview(mapBox)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        customElement()
        //--- Make frame for Map
        factory.frame = map_View.bounds
        //--- Map is displayed when app start
        stateMap = UserDefaultHelpers.shared.useGoogleMap
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK:--- CustomElement
    private func customElement() {
        //--- Search View
        search_View.addRadius(radius: 10)
        search_View.addShadow(color: UIColor.black.cgColor, opacity: 0.3, radius: 4, offset: .zero)
        search_View.addGesture(taget: self, selector: #selector(onTapSearchView))
        //--- Hambureger Button
        hamburger_Btn.addGesture(taget: self, selector: #selector(onTapHamburgerBtn))
        //--- Stacks View
        stacks_View.addRadius(radius: stacks_View.frame.height / 2)
        stacks_View.addShadow(color: UIColor.black.cgColor, opacity: 0.3, radius: 4, offset: .zero)
        stacks_View.addGesture(taget: self, selector: #selector(onTapStackView))
        //--- Camera View
        camera_View.addRadius(radius: stacks_View.frame.height / 2)
        camera_View.addShadow(color: UIColor.black.cgColor, opacity: 0.3, radius: 4, offset: .zero)
        //--- Zoom View
        zoom_View.addShadow(color: UIColor.black.cgColor, opacity: 0.3, radius: 4, offset: .zero)
    }
    //MARK: Handle Events
    @objc func onTapHamburgerBtn() {
        let profile = ProfileTableVC()
        profile.useGoogleMap = { did in
            self.stateMap = did
        }
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    @objc func onTapStackView() {
        
        print("GgMap:\(locationGgMap.coordinate), Mapbox: \(locationMapBox.coordinate)")
        let distanceByMeter = locationGgMap.distance(from: locationMapBox)
        print("sai so la: \(String(format: "%.2f", distanceByMeter))")
    }
    
    @objc func onTapSearchView() {
        let searchVC = SearchVC()
        if let currentLocation = googleMap.currentLocation {
            searchVC.locationEndpoint = currentLocation
        }
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}





