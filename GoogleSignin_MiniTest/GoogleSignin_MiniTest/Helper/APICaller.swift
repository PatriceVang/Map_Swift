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
    
    
    static func getMethod<T: Codable>(_ : T.Type, url: String, completion: @escaping (T) -> Void) {
        let header: HTTPHeaders = [
            "api_key": "t6q3AIjL6NQdwZk732qdAIXl87Y4B7BX"
        ]

//        DispatchQueue.global(qos: .utility).async {
            //        AF.request(url, method: .get).responseDecodable(of: T.self) { (response) in
            //            switch response.result {
            //            case .success(let result):
            //                completion(result)
            //            case .failure(let err):
            //                print(err.localizedDescription)
            //            }
            //        }
//        }

        DispatchQueue.global(qos: .utility).async {
            AF.request(url, method: .get, headers: header).responseJSON { (response) in
                print(response.value as Any)
            }
        }
    }
}
