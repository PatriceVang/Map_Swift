//
//  CategoriesCell.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/16/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit

enum TypePOI: String {
    case cafe = "cafe"
    case hotel = "hotels"
    case restaurant = "restaurant"
    case bus = "bus"
}

class CategoriesCell: UITableViewCell {
    @IBOutlet weak var bus_Btn: UIView!
    @IBOutlet weak var coffee_Btn: UIView!
    @IBOutlet weak var hotel_Btn: UIView!
    @IBOutlet weak var restaurant_Btn: UIView!
    @IBOutlet weak var more_Btn: UIView!
    @IBOutlet var arrPOI_Btn: [UIView]!
    weak var delegate: CategoriesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        customElement()
    }
    
    //MARK:--- Custom Element
    private func customElement() {
        //--- Bus Btn
        bus_Btn.addGesture(taget: self, selector: #selector(onTapBusBtn))
        //--- Coffee Btn
        coffee_Btn.addGesture(taget: self, selector: #selector(onTapCoffeeBtn))
        //--- Hotel Btn
        hotel_Btn.addGesture(taget: self, selector: #selector(onTapHotelBtn))
        //--- Restaurant Btn
        restaurant_Btn.addGesture(taget: self, selector: #selector(onTapRestaurantBtn))
        //--- More Btn
        more_Btn.addGesture(taget: self, selector: #selector(onTapMoreBtn))
    }
    
    //MARK:--- Handle Event
    @objc func onTapBusBtn() {
        delegate?.getPlacePOI(type: .bus)
    }
    @objc func onTapCoffeeBtn() {
        delegate?.getPlacePOI(type: .cafe)
    }
    @objc func onTapHotelBtn() {
        delegate?.getPlacePOI(type: .hotel)
    }
    @objc func onTapRestaurantBtn() {
        delegate?.getPlacePOI(type: .restaurant)
    }
    @objc func onTapMoreBtn() {
        print("more")
    }
}

protocol CategoriesCellDelegate: class {
    func getPlacePOI(type: TypePOI)
}
