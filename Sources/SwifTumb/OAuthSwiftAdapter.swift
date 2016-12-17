//
//  OAuthSwiftAdapter.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation
import OAuthSwift

public protocol OAuthAdapter {
    
}

open class OAuthSwiftAdapter: OAuth1Swift {
    
    public init(
        consumerKey: String,
        consumerSecret: String,
        oauthToken: String,
        oauthTokenSecret: String
    ) {
        super.init(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            requestTokenUrl: SwifTumb.RequestTokenUrl,
            authorizeUrl: SwifTumb.AuthorizeUrl,
            accessTokenUrl: SwifTumb.AccessTokenUrl
        )
        
        self.client.credential.oauthToken = oauthToken
        self.client.credential.oauthTokenSecret = oauthTokenSecret
    }
    
    convenience init (consumerKey: String, consumerSecret: String) {
        self.init(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            oauthToken: "",
            oauthTokenSecret: ""
        )
    }
}
