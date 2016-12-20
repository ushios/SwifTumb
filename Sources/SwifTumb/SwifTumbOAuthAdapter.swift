//
//  SwifTumbOAuthAdapter.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/21.
//
//

import Foundation

public protocol SwifTumbOAuthAdapter {
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
