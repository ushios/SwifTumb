//
//  ApiClientAdapter.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation

protocol ApiClientAdapter {
    func get(path: String) -> String
}

class OAuthSwiftAdapter {
    private let Host: String = "api.tumblr.com"
    private let Version: String = "v2"
    
    private let RequestTokenUrl: String = "https://www.tumblr.com/oauth/request_token"
    private let AuthorizeUrl: String = "https://www.tumblr.com/oauth/authorize"
    private let AccessTokenUrl: String = "https://www.tumblr.com/oauth/access_token"
    
    
    private var consumerKey: String
    private var consumerSecret: String
    
    init(consumerKey: String, consumerSecret: String) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
    }
    
    convenience init() {
        self.init(consumerKey: "", consumerSecret: "")
    }
    
    public func baseUrl() -> String {
        return self.Host + "/" + self.Version
    }
}
