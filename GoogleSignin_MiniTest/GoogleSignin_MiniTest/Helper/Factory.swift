//
//  Factory.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import UIKit


protocol MapFactory {
    func makeGoogleMap() -> GoogleMap
    func makeMapBox() -> MapBox
}
protocol ViewControllerFactory {
    func makeHomeVC() -> HomeVC
    func makeSearchVC() -> SearchVC
}

protocol ViewModelFactory {
    func makeHomeViewModel() -> HomeViewModel
    func makeSearchViewModel() -> SearchViewModel
}

class ContainerFactory {
    //--- Use for Map
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    //--- Use fro ViewModel
}

//MARK:--- Create Map
extension ContainerFactory: MapFactory {
    func makeGoogleMap() -> GoogleMap {
        return GoogleMap(frame: frame)
    }
    func makeMapBox() -> MapBox {
        return MapBox(frame: frame)
    }
}

//MARK:--- Create ViewModel
extension ContainerFactory: ViewModelFactory {
    func makeSearchViewModel() -> SearchViewModel {
        return SearchViewModel()
    }
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
}

//MARK:--- Create ViewController
extension ContainerFactory: ViewControllerFactory {
    func makeSearchVC() -> SearchVC {
        return SearchVC(viewModel: self.makeSearchViewModel())
    }
    
    func makeHomeVC() -> HomeVC {
        return HomeVC(viewModel: self.makeHomeViewModel())
    }
}



