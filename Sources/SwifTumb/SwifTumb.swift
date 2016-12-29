//
//  SwifTumb.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import Foundation


/// Tumblr client written by Swift
open class SwifTumb {
    static let EnvConsumerKey: String = "SWIFTUMB_CONSUMER_KEY"
    static let EnvConsumerSecret: String = "SWIFTUMB_CONSUMER_SECRET"
    static let EnvOAuthToken: String = "SWIFTUMB_OAUTH_TOKEN"
    static let EnvOAuthTokenSecret: String = "SWIFTUMB_OAUTH_TOKEN_SECRET"
    
    
    /// Post types
    ///
    /// - Text: text post type
    /// - Quote: quote post type
    /// - Link: link post type
    /// - Answer: answer post type
    /// - Video: video post type
    /// - Audio: audio post type
    /// - Photo: photo post type
    /// - Chat: chat post type
    public enum PostType: String {
        case Text = "text"
        case Quote = "quote"
        case Link = "link"
        case Answer = "answer"
        case Video = "video"
        case Audio = "audio"
        case Photo = "photo"
        case Chat = "chat"
    }
    
    public static let DefaultProtocol: String = "https"
    public static let DefaultHost: String = "api.tumblr.com"
    public static let DefaultVersion: String = "v2"
    public static let RequestTokenUrl: String = "https://www.tumblr.com/oauth/request_token"
    public static let AuthorizeUrl: String = "https://www.tumblr.com/oauth/authorize"
    public static let AccessTokenUrl: String = "https://www.tumblr.com/oauth/access_token"
    
    /// OAuth adapter
    private var adapter: SwifTumbOAuthAdapter
    
    
    /// Make base url
    ///
    /// - Returns: url
    open static func baseUrl() -> String {
        return "\(SwifTumb.DefaultProtocol)://\(SwifTumb.DefaultHost)/\(SwifTumb.DefaultVersion)"
    }
    
    /// Make endpoint url
    ///
    /// - Parameter path: path string without prefix slash
    /// - Returns: endpoint url
    open static func url(_ path: String) -> String {
        return "\(SwifTumb.baseUrl())/\(path)"
    }
    
    /// init
    ///
    /// - Parameter adapter: oauth adapter
    public init(adapter: SwifTumbOAuthAdapter) {
        self.adapter = adapter
    }
    
    /// init
    ///
    /// - Parameters:
    ///   - consumerKey: consumer key
    ///   - consumerSecret: consumer secret
    ///   - oauthToken: oauth token
    ///   - oauthTokenSecret: oauth token secret
    public convenience init(
        consumerKey: String,
        consumerSecret: String,
        oauthToken: String,
        oauthTokenSecret: String
    ) {
        let adapter = OAuthSwiftAdapter(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            oauthToken: oauthToken,
            oauthTokenSecret: oauthTokenSecret
        )
        
        self.init(adapter: adapter)
    }
    
    /// init from environments
    public convenience init?() {
        guard let consumerKey = getenv(SwifTumb.EnvConsumerKey),
            let consumerSecret = getenv(SwifTumb.EnvConsumerSecret),
            let oauthToken = getenv(SwifTumb.EnvOAuthToken),
            let oauthTokenSecret = getenv(SwifTumb.EnvOAuthTokenSecret)
            else {
                return nil
        }
        
        self.init(
            consumerKey: String(utf8String: consumerKey) ?? "",
            consumerSecret: String(utf8String: consumerSecret) ?? "",
            oauthToken: String(utf8String: oauthToken) ?? "",
            oauthTokenSecret: String(utf8String: oauthTokenSecret) ?? ""
        )
    }
    
    /// Request to tumblr api
    ///
    /// - Parameters:
    ///   - urlString: path
    ///   - method: HTTP method
    ///   - paramHolder: parameter struct
    ///   - headers: HTTP headers
    ///   - body: request body
    ///   - checkTokenExpiration: <#checkTokenExpiration description#>
    ///   - success: success handler
    ///   - failure: failure handler
    /// - Returns: request handle
    private func request(
        _ urlString: String,
        method: SwifTumbHttpRequest.Method,
        paramHolder: SwifTumbParameterHolder? = nil,
        headers: SwifTumb.Headers? = nil,
        body: Data? = nil,
        checkTokenExpiration: Bool = true,
        success: SwifTumbHttpRequest.SuccessHandler?,
        failure: SwifTumbHttpRequest.FailureHandler?
    ) -> SwifTumbRequestHandle? {
        
        var params: [String: Any]
        if paramHolder == nil {
            params = [:]
        } else {
            params = paramHolder!.parameters()
        }
        
        return self.adapter.request(urlString, method: method, parameters: params, headers: headers, body: body, checkTokenExpiration: checkTokenExpiration, success: success, failure: failure)
    }
    
    /// Request user/info api
    ///
    /// - Parameters:
    ///   - success: success handler
    ///   - failure: failure handler
    /// - Returns: request handle
    /// - Throws: request exceptions
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
    
    /// Request parameters for user/dashboard
    public struct UserDashboardParameters: SwifTumbParameterHolder {
        var limit: Int?
        var offset: Int?
        var type: SwifTumb.PostType?
        var sinceId: Int?
        var reblogInfo: Bool?
        var notesInfo: Bool?
    }
    
    /// Request user/dashboard api
    ///
    /// - Parameters:
    ///   - params: user/dashboard parameter
    ///   - success: sucess handler
    ///   - failure: failure handler
    /// - Returns: request handle
    /// - Throws: request exceptions
    open func userDashboard(
        params: UserDashboardParameters? = nil,
        success: SwifTumbHttpRequest.SuccessHandler?,
        failure: SwifTumbHttpRequest.FailureHandler?
        ) throws -> SwifTumbRequestHandle? {
        let handle = self.request(
            SwifTumb.url("user/dashboard"),
            method: SwifTumbHttpRequest.Method.GET,
            paramHolder: params,
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

extension SwifTumb.UserDashboardParameters {
    public func parameters() -> [String : Any] {
        var param: [String: Any] = [:]
        
        if self.limit != nil {
            param["limit"] = self.limit!
        }
        
        if self.offset != nil {
            param["offset"] = self.offset!
        }
        
        if self.type != nil {
            param["type"] = self.type!.rawValue
        }
        
        if self.sinceId != nil {
            param["since_id"] = self.sinceId!
        }
        
        if self.reblogInfo != nil {
            param["reblog_info"] = self.reblogInfo!
        }
        
        if self.notesInfo != nil {
            param["notes_info"] = self.notesInfo!
        }
        
        return param
    }
}

/// Parameters protocol
public protocol SwifTumbParameterHolder {
    
    /// Get request parameters map
    ///
    /// - Returns: parameters
    func parameters() -> [String: Any]
}
