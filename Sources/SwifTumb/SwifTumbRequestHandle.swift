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
}
