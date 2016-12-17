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
    
    public init(consumerKey: String, consumerSecret: String) {
        super.init(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            requestTokenUrl: SwifTumb.RequestTokenUrl,
            authorizeUrl: SwifTumb.AuthorizeUrl,
            accessTokenUrl: SwifTumb.AccessTokenUrl
        )
    }
}
