//
//  APICaller.swift
//  GoogleSignin_MiniTest
//
//  Created by Apple on 6/16/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import Foundation
import Alamofire




class APICaller {
    
    
    static func getMethod<T: Codable>(_ : T.Type, url: String, completion: @escaping (T?, AFError?) -> Void) {
        AF.request(url, method: .get).responseDecodable(of: T.self) { (response) in
            switch response.result {
            case .success:
                guard let jsonDeco = response.value else {return}
                completion(jsonDeco, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
}
