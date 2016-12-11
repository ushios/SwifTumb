//
//  ApiClientAdapter.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation
import OAuthSwift

protocol ApiClientAdapter {
    func get(path: String) -> String
}

class OAuthSwiftAdapter {
    private static let EnvKeyConsumerKey: String = "SWIFTUMB_CONSUMER_KEY"
    private static let EnvKeyConsumerSecret: String = "SWIFTUMB_CONSUMER_SECRET"
    
    private let Host: String = "api.tumblr.com"
    private let Version: String = "v2"
    
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
        
        self.handle = self.oauthswift.authorize(
            withCallbackURL: URL(string: "oauth-swift://oauth-callback/tumblr")!,
            success: { credential, response, parameters in
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                print(parameters["user_id"] ?? "nothing")
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
    
    convenience init() {
        let key = getEnvironmentVar(name: OAuthSwiftAdapter.EnvKeyConsumerKey) ?? ""
        let secret = getEnvironmentVar(name: OAuthSwiftAdapter.EnvKeyConsumerSecret) ?? ""
        
        self.init(consumerKey: key, consumerSecret: secret)
    }
    
    public func baseUrl() -> String {
        return self.Host + "/" + self.Version
    }
}


func getEnvironmentVar(name: String) -> String? {
    guard let rawValue = getenv(name) else { return nil }
    return String(utf8String: rawValue)
}
