//
//  SwifTumb.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation

open class SwifTumb {
    public static let DefaultProtocol: String = "https"
    public static let DefaultHost: String = "api.tumblr.com"
    public static let DefaultVersion: String = "v2"
    public static let RequestTokenUrl: String = "https://www.tumblr.com/oauth/request_token"
    public static let AuthorizeUrl: String = "https://www.tumblr.com/oauth/authorize"
    public static let AccessTokenUrl: String = "https://www.tumblr.com/oauth/access_token"
    
    private var adapter: OAuthAdapter
    
    init(adapter: OAuthAdapter) {
        self.adapter = adapter
    }
    
    open static func baseUrl() -> String {
        return "\(SwifTumb.DefaultProtocol)://\(SwifTumb.DefaultHost)/\(SwifTumb.DefaultVersion)"
    }
    
    open static func url(_ path: String) -> String {
        return "\(SwifTumb.baseUrl())/\(path)"
    }
}


extension SwifTumb {
    public typealias Parameters = [String : Any]
    public typealias Headers = [String : String]
}
