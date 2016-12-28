//
//  SwifTumbRequestHandle.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/18.
//
//

import Foundation
import OAuthSwift

public protocol SwifTumbRequestHandle {
    func cancel()
}

public protocol SwifTumbError {
    
}

open class SwifTumbHttpRequest {
    public typealias SuccessHandler = (_ response: SwifTumbResponse) -> Void
    public typealias FailureHandler = (_ error: SwifTumbError) -> Void
    
    public enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
        case HEAD
    }
}
