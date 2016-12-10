//
//  ApiClientAdapter.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation
import Alamofire

protocol ApiClientAdapter {
    func get(path: String) -> String
}

class AlamofireAdapter {
    
}
