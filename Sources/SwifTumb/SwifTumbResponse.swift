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
        var blog: Blog?
        var posts: [SwifTumb.Post]?
        var totalPosts: Int?
        var likedPosts: [SwifTumb.Post]?
        var likedCount: Int?
    }
    
    public struct User {
        var following: Int
        var defaultPostFormat: String
        var name: String
        var likes: Int
        var blogs: [Blog]
    }
    
    public struct Blog {
        var title: String
        var posts: Int
        var name: String
        var url: String
        var updated: Int
        var description: String
        var ask: Bool
        var askAnon: Bool
        var likes: Int?
    }
    
}

extension SwifTumbResponse.Response {
    init?(json: [String: Any]) {
        let user = json["user"] as? [String: Any]
        let postMaps = json["posts"] as? [[String: Any]]
        let blog = json["blog"] as? [String: Any]
        let totalPosts = json["total_posts"] as? Int
        let likedPosts = json["liked_posts"] as? [[String: Any]]
        let likedCount = json["liked_count"] as? Int
        
        if postMaps != nil {
            var posts: [SwifTumb.Post] = []
            for postMap in postMaps! {
                let post: SwifTumb.Post? = SwifTumb.Post(json: postMap)
                posts.append(post!)
            }
            self.posts = posts
        }
        
        if likedPosts != nil {
            var posts: [SwifTumb.Post] = []
            for postMap in likedPosts! {
                let post: SwifTumb.Post? = SwifTumb.Post(json: postMap)
                posts.append(post!)
            }
            self.likedPosts = posts
        }
        
        if likedCount != nil {
            self.likedCount = likedCount!
        }
        
        if user != nil {
            self.user = SwifTumbResponse.User(json: user!)
        }
        
        if blog != nil {
            self.blog = SwifTumbResponse.Blog(json: blog!)
        }
        
        self.totalPosts = totalPosts
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
        guard let title = json["title"] as? String,
            let posts = json["posts"] as? Int,
            let name = json["name"] as? String,
            let url = json["url"] as? String,
            let updated = json["updated"] as? Int,
            let description = json["description"] as? String,
            let ask = json["ask"] as? Bool,
            let askAnon = json["ask_anon"] as? Bool
            else {
                return nil
        }
        
        let likes = json["likes"] as? Int
        
        self.title = title
        self.posts = posts
        self.name = name
        self.url = url
        self.updated = updated
        self.description = description
        self.ask = ask
        self.askAnon = askAnon
        self.likes = likes
    }
}

extension SwifTumbResponse.User {
    
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
    
    init?(json: [String: Any]) {
        guard let following = json["following"] as? Int,
            let defaultPostFormat = json["default_post_format"] as? String,
            let name = json["name"] as? String,
            let likes = json["likes"] as? Int,
            let blogMaps = json["blogs"] as? [[String: Any]]
            else {
                return nil
        }
        
        var blogs: [SwifTumbResponse.User.Blog] = []
        for blogMap in blogMaps {
            guard let blog = SwifTumbResponse.User.Blog(json: blogMap) else {
                return nil
            }
            
            blogs.append(blog)
        }
        
        self.following = following
        self.defaultPostFormat = defaultPostFormat
        self.name = name
        self.likes = likes
        self.blogs = blogs
    }
}

extension SwifTumbResponse.User.Blog {
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
