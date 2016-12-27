//
//  SwifTumbResponse.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/18.
//
//
// Deserialize sample: https://developer.apple.com/swift/blog/?id=37
// 

import Foundation


public struct SwifTumbResponse {
    var meta: Meta
    var response: Response?
}

extension SwifTumbResponse {
    init?(json: [String: Any]) {
        guard let meta = json["meta"] as? [String: Any],
            let response = json["response"] as? [String: Any]
            else {
                return nil
        }
        
        self.meta = Meta(json: meta)!
        self.response = Response(json: response)
    }
    
    public struct Meta {
        var status: Int
        var msg: String?
    }
    
    public struct Response {
        var user: User?
    }
    
    public struct User {
        var following: Int
        var defaultPostFormat: String
        var name: String
        var likes: Int
        var blogs: [Blog]
    }
    
    public struct Blog {
        var name: String
        var url: String
        var title: String
        var primary: Bool
        var followers: Int
        var tweet: String
        var facebook: String
        var type: String
    }
}

extension SwifTumbResponse.Response {
    init?(json: [String: Any]) {
        guard let user = json["user"] as? [String: Any]
            else {
                return nil
        }
        
        self.user = SwifTumbResponse.User(json: user)
    }
}


extension SwifTumbResponse.Meta {
    init?(json: [String: Any]) {
        guard let status = json["status"] as? Int,
            let msg = json["msg"] as? String?
            else {
                return nil
        }
        
        self.status = status
        self.msg = msg
    }
}

extension SwifTumbResponse.Blog {
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let url = json["url"] as? String,
            let title = json["title"] as? String,
            let primary = json["primary"] as? Bool,
            let followers = json["followers"] as? Int,
            let tweet = json["tweet"] as? String,
            let facebook = json["facebook"] as? String,
            let type = json["type"] as? String
            else {
                return nil
        }
        
        self.name = name
        self.url = url
        self.title = title
        self.primary = primary
        self.followers = followers
        self.tweet = tweet
        self.facebook = facebook
        self.type = type
    }
}

extension SwifTumbResponse.User {
    init?(json: [String: Any]) {
        guard let following = json["following"] as? Int,
            let defaultPostFormat = json["default_post_format"] as? String,
            let name = json["name"] as? String,
            let likes = json["likes"] as? Int,
            let blogs = json["blogs"] as? [[String: Any]]
            else {
                return nil
        }
        
        var blogObjects: [SwifTumbResponse.Blog] = []
        for blog in blogs {
            guard let b = SwifTumbResponse.Blog(json: blog) else {
                return nil
            }
            
            blogObjects.append(b)
        }
        
        self.following = following
        self.defaultPostFormat = defaultPostFormat
        self.name = name
        self.likes = likes
        self.blogs = blogObjects
    }
}
