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
    func userInfo() -> SwifTumbRequestHandle
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
    
    private func swiftumbRequest(
        _ urlString: String,
        method: OAuthSwiftHTTPRequest.Method,
        parameters: OAuthSwift.Parameters = [:],
        headers: OAuthSwift.Headers? = nil,
        body: Data? = nil,
        checkTokenExpiration: Bool = true,
        success: SwifTumbHttpRequest.SuccessHandler?,
        failure: SwifTumbHttpRequest.FailureHandler?
    ) -> SwifTumbRequestHandle? {
        return self.request(
            urlString,
            method: method,
            success: { (response: OAuthSwiftResponse) in
                let meta: Meta = Meta(status: 200, msg: "hoge")
                success!(SwifTumbResponse(meta: meta, response: nil))
            },
            failure: { (err: OAuthSwiftError) in
                failure!(OAuthSwiftAdapterError())
            }
        )
    }
    
    private func request(
        _ urlString: String,
        method: OAuthSwiftHTTPRequest.Method,
        parameters: OAuthSwift.Parameters = [:],
        headers: OAuthSwift.Headers? = nil,
        body: Data? = nil,
        checkTokenExpiration: Bool = true,
        success: OAuthSwiftHTTPRequest.SuccessHandler?,
        failure: OAuthSwiftHTTPRequest.FailureHandler?
    ) -> SwifTumbRequestHandle? {
        let handle: OAuthSwiftRequestHandle? = self.client.request(
            urlString,
            method: method,
            success: success,
            failure: failure
        )
        
        return OAuthSwiftAdapterRequestHandle(handle: handle)
    }
}

open class OAuthSwiftAdapterError: SwifTumbError {
    
}

open class OAuthSwiftAdapterRequestHandle: SwifTumbRequestHandle {
    var handle: OAuthSwiftRequestHandle
    
    init? (handle: OAuthSwiftRequestHandle?) {
        if handle == nil {
            return nil
        }
        
        self.handle = handle!
    }
    
    open func cancel() {
        self.handle.cancel()
    }
}