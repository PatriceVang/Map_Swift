//
//  SearchVC.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/16/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit
import CoreLocation

private let categories = "categories"
private let recent = "recent"

class SearchVC: UIViewController {
    @IBOutlet weak var myTableV: UITableView!
    let search_Tf: UITextField = {
        let tf = UITextField(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 35))
        tf.backgroundColor = Resource.Color.bgSearchTfColor
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.layer.masksToBounds = true
        tf.addRadius(radius: 5)
        tf.textColor = .white
        let padding = UIView(frame: .init(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = padding
        tf.leftViewMode = .always
        return tf
    }()
    let back_Btn: UIImageView = {
        let img = UIImageView(frame: .init(x: 0, y: 0, width: 25, height: 25))
        img.image = UIImage(systemName: "arrow.left")
        img.tintColor = .white
        return img
    }()

    
//    let searchBar: UISearchBar = {
//       let sb = UISearchBar()
//        sb.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 35)
//        sb.searchTextField.backgroundColor = Resource.Color.bgSearchTfColor
//        sb.searchTextField.textColor = .white
//        return sb
//    }()
    
    //--- Tilte of Header
        let titleHeader = ["Categories", "Recent"]
    //--- Use call API
        var locationEndpoint: CLLocation = CLLocation(latitude: 0, longitude: 0)
    var viewModel: SearchViewModel {
        didSet {
            
        }
    }
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SearchVC", bundle: nil)
        setupViewModel(viewModel: viewModel)
    }
    
    func setupViewModel(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customElement()
        myTableV.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellReuseIdentifier: categories)
        myTableV.register(UINib(nibName: "RecentCell", bundle: nil), forCellReuseIdentifier: recent)
    }
    
    //MARK: Custom Element
    private func customElement() {
        //--- NavigatonBar
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = Resource.Color.naviBarColor
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: back_Btn)
        
        //--- Search Tf
        self.navigationItem.titleView = search_Tf
//        self.navigationItem.titleView = searchBar
        
        //--- Back Btn
        back_Btn.addGesture(taget: self, selector: #selector(onTapLeftBtnItem))
    }
    
    
    //MARK:--- Handle Event
    @objc func onTapLeftBtnItem() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //--- Create Header
        let headerV = UIView(frame: .init(x: 0, y: 0, width: self.myTableV.frame.width, height: 50))
        headerV.backgroundColor = Resource.Color.headerCatagoriesColor
        let title = UILabel(frame: .init(x: 20, y: 10, width: 150, height: 30))
        title.textColor = .gray
        title.text = titleHeader[section]
        headerV.addSubview(title)
        return headerV
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = myTableV.dequeueReusableCell(withIdentifier: categories) as! CategoriesCell
            cell.delegate = self
            return cell
        } else {
            let cell = myTableV.dequeueReusableCell(withIdentifier: recent) as! RecentCell
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK:--- Delegation from Categories Cell
extension SearchVC: CategoriesCellDelegate {
    //--- Call API
    func getStationBus() {
        viewModel.fetchData()
    }
}
