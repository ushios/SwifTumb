//
//  OAuthSwiftAdapter.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation
import OAuthSwift

open class OAuthSwiftAdapter: OAuth1Swift, SwifTumbOAuthAdapter {
    
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

    public func request(
        _ urlString: String,
        method: SwifTumbHttpRequest.Method,
        parameters: SwifTumb.Parameters = [:],
        headers: SwifTumb.Headers? = nil,
        body: Data? = nil,
        checkTokenExpiration: Bool = true,
        success: SwifTumbHttpRequest.SuccessHandler?,
        failure: SwifTumbHttpRequest.FailureHandler?
    ) -> SwifTumbRequestHandle? {
        let handle: OAuthSwiftRequestHandle? = self.client.request(
            urlString,
            method: self.method(method: method),
            parameters: parameters,
            headers: headers,
            body:body,
            checkTokenExpiration: checkTokenExpiration,
            success: { (response: OAuthSwiftResponse) in
                let meta: Meta = Meta(status: 200, msg: "hoge")
                success!(SwifTumbResponse(meta: meta, response: nil))
            },
            failure: { (err: OAuthSwiftError) in
                failure!(OAuthSwiftAdapterError())
            }
        )
        
        return OAuthSwiftAdapterRequestHandle(handle: handle)
    }
    
    private func method(method: SwifTumbHttpRequest.Method) -> OAuthSwiftHTTPRequest.Method {
        switch method {
        case SwifTumbHttpRequest.Method.GET:
            return OAuthSwiftHTTPRequest.Method.GET
        case SwifTumbHttpRequest.Method.POST:
            return OAuthSwiftHTTPRequest.Method.POST
        case SwifTumbHttpRequest.Method.PUT:
            return OAuthSwiftHTTPRequest.Method.PUT
        case SwifTumbHttpRequest.Method.DELETE:
            return OAuthSwiftHTTPRequest.Method.DELETE
        case SwifTumbHttpRequest.Method.PATCH:
            return OAuthSwiftHTTPRequest.Method.PATCH
        case SwifTumbHttpRequest.Method.HEAD:
            return OAuthSwiftHTTPRequest.Method.HEAD
        }
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
