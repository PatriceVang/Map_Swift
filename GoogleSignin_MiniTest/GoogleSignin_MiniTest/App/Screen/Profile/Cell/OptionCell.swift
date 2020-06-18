//
//  OptionCell.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {
    @IBOutlet weak var switchMap_Switch: UISwitch!
    //--- Delegate
//    weak var delegate: OptionCellDelegate?
    var isUseGoogleMap: Bool!
    override func awakeFromNib() {
        super.awakeFromNib()
        isUseGoogleMap = UserDefaultHelpers.shared.useGoogleMap
        switchMap_Switch.isOn = isUseGoogleMap
    }
    
    @IBAction func onSwitchMap(_ sender: UISwitch) {
        isUseGoogleMap.toggle()
        UserDefaultHelpers.shared.useGoogleMap = isUseGoogleMap
//        self.delegate?.didUsedGoogleMap(did: isUseGoogleMap)
        
        //--- Use to Switch Map
        let dataToPost: [AnyHashable : Any] = ["switchMap": isUseGoogleMap as Any]
        NotificationCenter.default.post(name: .switchMap , object: nil, userInfo: dataToPost)
    }
}


//MARK: Delegation
//protocol OptionCellDelegate: class {
//    func didUsedGoogleMap(did: Bool)
//}






