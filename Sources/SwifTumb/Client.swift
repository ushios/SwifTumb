//
//  Client.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/17.
//
//

import Foundation

public let Host: String = "api.tumblr.com"
public let ApiVersion: String = "v2"

public protocol SwifTumbClient {
    static func get() -> String
}

open class AlmofileClient: SwifTumbClient {
    public static func get() -> String {
        return "hoge"
    }
}
