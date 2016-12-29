//
//  SwifTumbOAuthAdapter.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/21.
//
//

import Foundation

public protocol SwifTumbOAuthAdapter {
    
    /// Request to tumblr api and oauth token
    ///
    /// - Parameters:
    ///   - urlString: path
    ///   - method: HTTP method
    ///   - parameters: parameters map
    ///   - headers: HTTP headers
    ///   - body: request body
    ///   - checkTokenExpiration: <#checkTokenExpiration description#>
    ///   - success: success handler
    ///   - failure: failure handler
    /// - Returns: request handle
    func request(
        _ urlString: String,
        method: SwifTumbHttpRequest.Method,
        parameters: SwifTumb.Parameters,
        headers: SwifTumb.Headers?,
        body: Data?,
        checkTokenExpiration: Bool,
        success: SwifTumbHttpRequest.SuccessHandler?,
        failure: SwifTumbHttpRequest.FailureHandler?
    ) -> SwifTumbRequestHandle?
}
