//
//  ApiClientAdapter.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation
import OAuthSwift

struct Credentials {
    var consumerKey: String
    var consumerSecret: String
    var token: String?
    var tokenSecret: String?
}

protocol OAuthAdapter {
    func get() -> Credentials
}

class OAuthSwiftAdapter {
    private static let EnvKeyConsumerKey: String = "SWIFTUMB_CONSUMER_KEY"
    private static let EnvKeyConsumerSecret: String = "SWIFTUMB_CONSUMER_SECRET"
    
    private let RequestTokenUrl: String = "https://www.tumblr.com/oauth/request_token"
    private let AuthorizeUrl: String = "https://www.tumblr.com/oauth/authorize"
    private let AccessTokenUrl: String = "https://www.tumblr.com/oauth/access_token"
    
    private var consumerKey: String
    private var consumerSecret: String
    private var oauthswift: OAuth1Swift
    private var handle: OAuthSwiftRequestHandle?
    
    init(consumerKey: String, consumerSecret: String) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        
        self.oauthswift = OAuth1Swift(
            consumerKey: self.consumerKey,
            consumerSecret: self.consumerSecret,
            requestTokenUrl: self.RequestTokenUrl,
            authorizeUrl: self.AuthorizeUrl,
            accessTokenUrl: self.AccessTokenUrl
        )
    }
    
    convenience init() {
        let key = getEnvironmentVar(name: OAuthSwiftAdapter.EnvKeyConsumerKey) ?? ""
        let secret = getEnvironmentVar(name: OAuthSwiftAdapter.EnvKeyConsumerSecret) ?? ""
        self.init(consumerKey: key, consumerSecret: secret)
    }
}


func getEnvironmentVar(name: String) -> String? {
    guard let rawValue = getenv(name) else { return nil }
    return String(utf8String: rawValue)
}
