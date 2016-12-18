//
//  SwifTumbResponse.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/18.
//
//

import Foundation


public struct SwifTumbResponse {
    var meta: Meta
    var response: Any?
}

public struct Meta {
    var status: Int
    var msg: String?
}

public struct UserInfoResponse {
    var following: Int
    var default_post_format: String
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
