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
        var likes: Int
    }
    
    public struct Post {
        var blogName: String
        var id: Int
        var postUrl: String
        var type: PostType
        var timestamp: Int
        var date: String
        var format: String
        var reblogKey: String
        var tags: [String]
        var bookmarklet: Bool
        var mobile: Bool
        var sourceUrl: String
        var sourceTitle: String
        var liked: Bool
        var state: String
        var totalPosts: Int
        
        // text posts
        var title: String
        var body: String
        
        // photo posts
        var photos: [Photo]
        var caption: String
        var width: Int
        var height: Int
        
        // quote posts
        var text: String
        var source: String
        
        // link posts
        // --> title
        // --> photos
        var url: String
        var author: String
        var excerpt: String
        var publisher: String
        var description: String
        
        // chat posts
        // --> ttile
        // --> body
        var dialogue: [DialogueLine]
        
        // audio posts
        // --> caption
        var player: Player
        var plays: Int
        var albumArt: String
        var artist: String
        var album: String
        var trackName: String
        var trackNumber: Int
        var year: Int
        
        // video posts
        // --> caption
        // --> player
        
        // answer posts
        var askingName: String
        var askingUrl: String
        var question: String
        var answer: String
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
        guard let title = json["title"] as? String,
            let posts = json["posts"] as? Int,
            let name = json["name"] as? String,
            let url = json["url"] as? String,
            let updated = json["updated"] as? Int,
            let description = json["description"] as? String,
            let ask = json["ask"] as? Bool,
            let askAnon = json["ask_anon"] as? Bool,
            let likes = json["likes"] as? Int
            else {
                return nil
        }
        
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
            let blogs = json["blogs"] as? [[String: Any]]
            else {
                return nil
        }
        
        var blogObjects: [SwifTumbResponse.User.Blog] = []
        for blog in blogs {
            guard let b = SwifTumbResponse.User.Blog(json: blog) else {
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

extension SwifTumbResponse.Post {
    
    public enum PostType: String {
        case Text
        case Quote
        case Link
        case Answer
        case Video
        case Audio
        case Photo
        case Chat
    }
    
    public struct Photo {
        var caption: String
        var originalSize: OriginalSize?
        var altSizes: [AltSize]
    }
    
    public struct DialogueLine {
        var name: String
        var label: String
        var phrase: String
    }
    
    public struct Player {
        var width: Int
        var embedCode: String
    }
}

extension SwifTumbResponse.Post.Photo {
    public struct AltSize {
        var width: Int
        var height: Int
        var url: String
    }
    
    public struct OriginalSize {
        var width: Int
        var height: Int
        var url: String
    }
}
