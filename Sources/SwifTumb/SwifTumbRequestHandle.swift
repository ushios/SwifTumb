//
//  SwifTumbRequestHandle.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/18.
//
//

import Foundation

public protocol SwifTumbRequestHandle {
    func cancel()
}

public typealias SuccessHandler = (_ response: OAuthSwiftResponse) -> Void
public typealias FailureHandler = (_ error: OAuthSwiftError) -> Void
