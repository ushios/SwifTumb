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

/// Request parameter protocol
public protocol SwifTumbModelMapper {
    
    /// Response to object
    ///
    /// - Parameter data: data from request
    /// - Returns: SwifTumb response object
    /// - Throws: mapping exceptions
    static func Response(data: Data) throws -> SwifTumbResponse
}

open class SwifTumbResponseMapper: SwifTumbModelMapper {
    
    open static func Response(data: Data) throws -> SwifTumbResponse {
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        let jsonMap = json as? [String : Any]
        
        let response = SwifTumbResponse(json: jsonMap!)
        
        let passList: [Int] = [200, 201]
        if passList.index(of: response!.meta.status) == nil {
            throw ModelMappingErrors.errorResponse(
                response!.meta.status,
                response!.meta.msg ?? "Error message was empty"
            )
        }
        
        return response!
    }
}
