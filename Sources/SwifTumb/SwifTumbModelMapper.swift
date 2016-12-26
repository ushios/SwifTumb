//
//  SwifTumbModelMapper.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/26.
//
//

import Foundation

enum ModelMappingErrors: Error {
    case errorResponse(Int, String)
}

public protocol SwifTumbObjectMapper {
    static func UserInfo(data: Data) throws -> UserInfoResponse
}

open class SwifTumbDefaultObjectMapper: SwifTumbObjectMapper {
    
    open static func Response(data: Data) throws -> SwifTumbResponse {
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        let response = json as! SwifTumbResponse
        
        if response.meta.status != 200 {
            throw ModelMappingErrors.errorResponse(
                response.meta.status,
                response.meta.msg ?? "Error message not found"
            )
        }
        
        return response
    }
    
    open static func UserInfo(data: Data) throws -> UserInfoResponse {
        let response = try! SwifTumbDefaultObjectMapper.Response(data: data)
        
        let model = response.response as! UserInfoResponse
        
        return model
    }
}
