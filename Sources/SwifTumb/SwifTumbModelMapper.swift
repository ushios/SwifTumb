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
    case errorInvalidFormat(String)
}

public protocol SwifTumbModelMapper {
    static func Response(data: Data) throws -> SwifTumbResponse
}

open class SwifTumbResponseMapper: SwifTumbModelMapper {
    
    open static func Response(data: Data) throws -> SwifTumbResponse {
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        let response = SwifTumbResponse(json: json as! [String : Any])
        
        if response!.meta.status != 200 {
            throw ModelMappingErrors.errorResponse(
                response!.meta.status,
                response!.meta.msg ?? "Error message was empty"
            )
        }
        
        return response!
    }
}