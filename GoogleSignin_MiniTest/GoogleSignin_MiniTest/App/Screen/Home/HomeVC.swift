//
//  HomeVC.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var map_View: UIView!
    @IBOutlet weak var search_View: UIView!
    @IBOutlet weak var zoom_View: UIView!
    @IBOutlet weak var hamburger_Btn: UIView!
    @IBOutlet weak var camera_View: UIView!
    @IBOutlet weak var stacks_View: UIView!
    //--- Factory
    var factory = ContainerFactory()
    lazy var googleMap = factory.makeGoogleMap()
    lazy var mapBox = factory.makeMapBox()
    var stateMap: Bool = false {
        didSet {
            if stateMap == true {
                map_View.addSubview(googleMap)
                mapBox.removeFromSuperview()
            } else {
                map_View.addSubview(mapBox)
                googleMap.removeFromSuperview()
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
        //--- Hambureger Button
        hamburger_Btn.addGesture(taget: self, selector: #selector(onTapHamburgerBtn))
        //--- Stacks View
        stacks_View.addRadius(radius: stacks_View.frame.height / 2)
        stacks_View.addShadow(color: UIColor.black.cgColor, opacity: 0.3, radius: 4, offset: .zero)
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

}
