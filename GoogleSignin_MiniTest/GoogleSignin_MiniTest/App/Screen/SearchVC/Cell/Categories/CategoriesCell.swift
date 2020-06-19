//
//  CategoriesCell.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/16/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit

class CategoriesCell: UITableViewCell {
    @IBOutlet weak var bus_Btn: UIImageView!
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
    }
    
    //MARK:--- Handle Event
    @objc func onTapBusBtn() {
        delegate?.getStationsBus()
    }
}

protocol CategoriesCellDelegate: class {
    func getStationsBus()
}
