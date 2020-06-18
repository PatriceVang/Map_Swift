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
    var passCurrentLocation: ((CLLocation) -> Void)?
    //--- Use NotificationCenter
    var switchMapSubcription: NSObjectProtocol?
    //--- Factory
    var factory = ContainerFactory()
    //--- Create Map
    lazy var googleMap = factory.makeGoogleMap()
    lazy var mapBox = factory.makeMapBox()

    //--- ViewModel
    var viewModel: HomeViewModel {
        didSet {
            viewModel.stateMap.bindAndFire { [weak self] (state) in
                guard let self = self else {return}
                if state == true {
                    self.googleMap.reloadView()
                    self.mapBox.removeFromSuperview()
                    self.map_View.addSubview(self.googleMap)
                } else {
                    self.mapBox.reloadCamera()
                    self.googleMap.removeFromSuperview()
                    self.map_View.addSubview(self.mapBox)
                }
            }
        }
    }
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HomeVC", bundle: nil)
    }
    deinit {
        //--- Remove Observer
        NotificationCenter.default.removeObserver(switchMapSubcription as Any, name: .switchMap, object: nil)
    }
    
    func setupViewModel(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customElement()
        //--- Make frame for Map
        factory.frame = map_View.bounds
        //--- Setup ViewModel again
        setupViewModel(viewModel: viewModel)
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
        //--- Camera View
        camera_View.addRadius(radius: stacks_View.frame.height / 2)
        camera_View.addShadow(color: UIColor.black.cgColor, opacity: 0.3, radius: 4, offset: .zero)
        //--- Zoom View
        zoom_View.addShadow(color: UIColor.black.cgColor, opacity: 0.3, radius: 4, offset: .zero)
    }
    //MARK: Handle Events
    @objc func onTapHamburgerBtn() {
        let profile = ProfileTableVC()
        switchMapSubcription = NotificationCenter.default.addObserver(forName: .switchMap, object: nil, queue: .main) { [weak self] (state) in
            guard let self = self else {return}
            if let state = state.userInfo as? [String: Bool], let data = state["switchMap"] {
                self.viewModel.stateMap.value = data
            }
        }
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    @objc func onTapSearchView() {
        let searchVC = factory.makeSearchVC()
        if let currentLocation = googleMap.currentLocation {
            searchVC.locationEndpoint = currentLocation
        }
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}





