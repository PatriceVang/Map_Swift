//
//  RecentCell.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/16/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit

class RecentCell: UITableViewCell {
    @IBOutlet weak var name_Lb: UILabel!
    @IBOutlet weak var address_Lb: UILabel!
    @IBOutlet weak var foward_Btn: UIView!
    @IBOutlet weak var foward_Img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        customElement()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:--- CustomElement
    private func customElement() {
        //--- Foward Btn
        foward_Btn.addRadius(radius: foward_Btn.frame.height / 2)
        foward_Img.addRadius(radius: foward_Img.frame.height / 2)
        foward_Btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFowardBtn)))
    }
    //MARK:--- Handle Event
    
    @objc func onTapFowardBtn() {
        print("Tap")
    }
    
    
        
    
    
}
