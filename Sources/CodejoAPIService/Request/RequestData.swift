//
//  RequestData.swift
//  Codejo
//
//  Created by Cole James on 2/24/21.
//

import Foundation

public struct RequestData {

    let baseUrl : String
    let path    : String
    let method  : HTTPMethod
    let params  : [String: Any]?
    let headers : [String: String]?

    public init (baseUrl: String, path: String, method: HTTPMethod, params: [String: Any]? = nil, headers: [String: String]? = nil) {
        self.baseUrl    = baseUrl
        self.path       = path
        self.method     = method
        self.params     = params
        self.headers    = headers
    }

}
