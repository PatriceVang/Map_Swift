//
//  ProfileTableVC.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/12/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit

class ProfileTableVC: UITableViewController {
    //--- Tranport event use Google Map for HomeVC to displayed
    var useGoogleMap: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "OptionCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OptionCell
        cell.delegate = self
        return cell
    }
}

extension ProfileTableVC: OptionCellDelegate {
    func didUsedGoogleMap(did: Bool) {
        useGoogleMap!(did)
    }
}
