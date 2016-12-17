//
//  SwifTumb.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation

open class SwifTumb {
    var consumerKey: String
    var consumerSecret: String
    var token: String
    var tokenSecret: String
    
    var client: SwifTumbClient
    
    required public init(
        client: SwifTumbClient?,
        consumerKey: String,
        consumerSecret: String,
        token: String,
        tokenSecret: String)
    {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.token = token
        self.tokenSecret = tokenSecret
        
        self.client = client ?? AlmofileClient()
    }
    
    convenience init(client: SwifTumbClient?, credentials: Credentials) {
        self.init(
            client: client,
            consumerKey: credentials.consumerKey,
            consumerSecret: credentials.consumerSecret,
            token: credentials.token ?? "",
            tokenSecret: credentials.tokenSecret ?? ""
        )
    }
    
    convenience init(client: SwifTumbClient?, adapter: OAuthAdapter) {
        let credentials: Credentials = adapter.get()
        self.init(
            client: client,
            credentials: credentials
        )
    }
    
}
