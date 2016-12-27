//
//  SwifTumb.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation
import SwiftyJSON

open class SwifTumb {
    public static let DefaultProtocol: String = "https"
    public static let DefaultHost: String = "api.tumblr.com"
    public static let DefaultVersion: String = "v2"
    public static let RequestTokenUrl: String = "https://www.tumblr.com/oauth/request_token"
    public static let AuthorizeUrl: String = "https://www.tumblr.com/oauth/authorize"
    public static let AccessTokenUrl: String = "https://www.tumblr.com/oauth/access_token"
    
    private var adapter: SwifTumbOAuthAdapter
    
    open static func baseUrl() -> String {
        return "\(SwifTumb.DefaultProtocol)://\(SwifTumb.DefaultHost)/\(SwifTumb.DefaultVersion)"
    }
    
    open static func url(_ path: String) -> String {
        return "\(SwifTumb.baseUrl())/\(path)"
    }
    
    init(adapter: SwifTumbOAuthAdapter) {
        self.adapter = adapter
    }
    
    private func request(
        _ urlString: String,
        method: SwifTumbHttpRequest.Method,
        parameters: SwifTumb.Parameters = [:],
        headers: SwifTumb.Headers? = nil,
        body: Data? = nil,
        checkTokenExpiration: Bool = true,
        success: SwifTumbHttpRequest.SuccessHandler?,
        failure: SwifTumbHttpRequest.FailureHandler?
    ) -> SwifTumbRequestHandle? {
        return self.adapter.request(urlString, method: method, parameters: parameters, headers: headers, body: body, checkTokenExpiration: checkTokenExpiration, success: success, failure: failure)
    }
    
    open func userInfo(
        success: SwifTumbHttpRequest.SuccessHandler?,
        failure: SwifTumbHttpRequest.FailureHandler?
    ) throws -> SwifTumbRequestHandle? {
        let handle = self.request(
            SwifTumb.url("user/info"),
            method: SwifTumbHttpRequest.Method.GET,
            success: success,
            failure: failure
        )
        
        return handle
    }
}


extension SwifTumb {
    public typealias Parameters = [String : Any]
    public typealias Headers = [String : String]
}
