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
        var posts: [Post]?
        var totalPosts: Int?
        var likedPosts: [Post]?
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
    
    public struct Post {
        var blogName: String
        var id: Int
        var postUrl: String
        var type: SwifTumb.PostType
        var timestamp: Int
        var date: String
        var format: String
        var reblogKey: String
        var tags: [String]?
        var bookmarklet: Bool
        var mobile: Bool
        var sourceUrl: String?
        var sourceTitle: String?
        var liked: Bool
        var state: String
        
        // text posts
        var title: String?
        var body: String?
        
        // photo posts
        var photos: [Photo]?
        var caption: String?
        var width: Int?
        var height: Int?
        
        // quote posts
        var text: String?
        var source: String?
        
        // link posts
        // --> title
        // --> photos
        var url: String?
        var author: String?
        var excerpt: String?
        var publisher: String?
        var description: String?
        
        // chat posts
        // --> ttile
        // --> body
        var dialogue: [DialogueLine]?
        
        // audio posts
        // --> caption
        var player: [Player]?
        var plays: Int?
        var albumArt: String?
        var artist: String?
        var album: String?
        var trackName: String?
        var trackNumber: Int?
        var year: Int?
        
        // video posts
        // --> caption
        // --> player
        
        // answer posts
        var askingName: String?
        var askingUrl: String?
        var question: String?
        var answer: String?
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
            var posts: [SwifTumbResponse.Post] = []
            for postMap in postMaps! {
                let post: SwifTumbResponse.Post? = SwifTumbResponse.Post(json: postMap)
                posts.append(post!)
            }
            self.posts = posts
        }
        
        if likedPosts != nil {
            var posts: [SwifTumbResponse.Post] = []
            for postMap in likedPosts! {
                let post: SwifTumbResponse.Post? = SwifTumbResponse.Post(json: postMap)
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

extension SwifTumbResponse.Post {
    
    init?(json: [String: Any]) {
        guard let blogName = json["blog_name"] as? String,
            let id = json["id"] as? Int,
            let postUrl = json["post_url"] as? String,
            let typeString = json["type"] as? String,
            let timestamp = json["timestamp"] as? Int,
            let date = json["date"] as? String,
            let format = json["format"] as? String,
            let reblogKey = json["reblog_key"] as? String,
            let state = json["state"] as? String
            else {
            return nil
        }
        
        let tags = json["tags"] as? [String]
        let bookmarklet = json["bookmarklet"] as? Bool
        let mobile = json["mobile"] as? Bool
        let sourceUrl = json["source_url"] as? String
        let sourceTitle = json["source_title"] as? String
        let liked = json["liked"] as? Bool
        
        let title = json["title"] as? String
        let body = json["body"] as? String
        let photoMaps = json["photos"] as? [[String: Any]]
        let caption = json["caption"] as? String
        let width = json["width"] as? Int
        let height = json["height"] as? Int
        let text = json["text"] as? String
        let source = json["source"] as? String
        let url = json["url"] as? String
        let author = json["author"] as? String
        let excerpt = json["excerpt"] as? String
        let publisher = json["publisher"] as? String
        let description = json["description"] as? String
        let dialogueMaps = json["dialogue"] as? [[String: Any]]
        let plays = json["plays"] as? Int
        let albumArt = json["album_art"] as? String
        let artist = json["artist"] as? String
        let album = json["album"] as? String
        let trackName = json["track_name"] as? String
        let trackNumber = json["track_number"] as? Int
        let year = json["year"] as? Int
        let askingName = json["asking_name"] as? String
        let askingUrl = json["asking_url"] as? String
        let question = json["question"] as? String
        let answer = json["answer"] as? String
        
        // photo list
        if photoMaps != nil {
            var photos: [Photo] = []
            for photoMap in photoMaps! {
                let photo: Photo = Photo(json: photoMap)!
                photos.append(photo)
            }
            self.photos = photos
        }
        
        // chat dialogue
        if dialogueMaps != nil {
            var dialogue: [DialogueLine] = []
            for dialogueLineMap in dialogueMaps! {
                let dialogueLine: DialogueLine = DialogueLine(json: dialogueLineMap)!
                dialogue.append(dialogueLine)
            }
            self.dialogue = dialogue
        }
        
        // player object
        if json["player"] != nil {
            var players: [Player] = []
            if json["player"] is String {
                let embedCode = json["player"] as? String
                let player: Player = Player(embedCode: embedCode!)!
                players.append(player)
            } else if json["player"] is [[String: Any]] {
                let playerMaps = json["player"] as? [[String: Any]]
                for playerMap in playerMaps! {
                    let player: Player = Player(json: playerMap)!
                    players.append(player)
                }
            }
            
            self.player = players
        }
        
     
        self.blogName = blogName
        self.id = id
        self.postUrl = postUrl
        self.type = SwifTumb.PostType(rawValue: typeString)!
        self.timestamp = timestamp
        self.date = date
        self.format = format
        self.reblogKey = reblogKey
        self.tags = tags
        self.bookmarklet = bookmarklet ?? false
        self.mobile = mobile ?? false
        self.sourceUrl = sourceUrl
        self.sourceTitle = sourceTitle
        self.liked = liked ?? false
        self.state = state
        self.title = title
        self.body = body
        self.caption = caption
        self.width = width
        self.height = height
        self.text = text
        self.source = source
        self.url = url
        self.author = author
        self.excerpt = excerpt
        self.publisher = publisher
        self.description = description
        self.plays = plays
        self.albumArt = albumArt
        self.artist = artist
        self.album = album
        self.trackName = trackName
        self.trackNumber = trackNumber
        self.year = year
        self.askingName = askingName
        self.askingUrl = askingUrl
        self.question = question
        self.answer = answer
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
        var width: Int?
        var embedCode: String
    }
}

extension SwifTumbResponse.Post.DialogueLine {
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let label = json["label"] as? String,
            let phrase = json["phrase"] as? String
            else {
                return nil
        }
        
        self.name = name
        self.label = label
        self.phrase = phrase
    }
}

extension SwifTumbResponse.Post.Photo {
    init?(json: [String: Any]) {
        guard let caption = json["caption"] as? String,
            let altSizeMaps = json["alt_sizes"] as? [[String: Any]]
            else {
                return nil
        }
        let originalSizeMap = json["original_size"] as? [String: Any]
        
        var altSizes: [AltSize] = []
        for altSizeMap in altSizeMaps {
            let altSize: AltSize = AltSize(json: altSizeMap)!
            altSizes.append(altSize)
        }
        
        if originalSizeMap != nil {
            var originalSize: OriginalSize?
            originalSize = OriginalSize(json: originalSizeMap!)
            self.originalSize = originalSize
        }
        
        self.caption = caption
        self.altSizes = altSizes
    }
    
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

extension SwifTumbResponse.Post.Photo.OriginalSize {
    init?(json: [String: Any]) {
        guard let width = json["width"] as? Int,
            let height = json["height"] as? Int,
            let url = json["url"] as? String
            else {
                return nil
        }
        
        self.width = width
        self.height = height
        self.url = url
    }
}

extension SwifTumbResponse.Post.Photo.AltSize {
    init?(json: [String: Any]) {
        guard let width = json["width"] as? Int,
            let height = json["height"] as? Int,
            let url = json["url"] as? String
            else {
                return nil
        }
        
        self.width = width
        self.height = height
        self.url = url
    }
}

extension SwifTumbResponse.Post.Player {
    init?(json: [String: Any]) {
        guard let embedCode = json["embed_code"] as? String
            else {
                return nil
        }
        
        let width = json["width"] as? Int
        
        self.width = width
        self.embedCode = embedCode
    }
    
    init?(embedCode: String) {
        self.embedCode = embedCode
    }
}
