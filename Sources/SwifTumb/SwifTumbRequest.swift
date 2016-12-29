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
    func message() -> String
}

open class SwifTumbHttpRequest {
    public typealias SuccessHandler = (_ response: SwifTumbResponse) -> Void
    public typealias FailureHandler = (_ error: SwifTumbError) -> Void
    
    /// HTTP method
    ///
    /// - GET: get
    /// - POST: post
    /// - PUT: put
    /// - DELETE: delete
    /// - PATCH: patch
    /// - HEAD: head
    public enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
        case HEAD
    }
}
