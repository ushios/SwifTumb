//
//  SwifTumb.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation

open class SwifTumb {
    var clientAdapter: ApiClientAdapter
    
    init(clientAdapter: ApiClientAdapter) {
        self.clientAdapter = clientAdapter
    }
}
