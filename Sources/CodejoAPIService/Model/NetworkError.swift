//
//  NetworkError.swift
//  Codejo
//
//  Created by Cole James on 2/24/21.
//

import Foundation

public struct NetworkError: Error {

    let statusCode: Int?
    let title: String
    let description: String
    let params: [String: Any]?

    init(error: Error) {
        statusCode = nil
        title = "Error"
        description = error.localizedDescription
        params = nil
    }

    init(statusCode: Int?, title: String, description: String, params: [String: Any]? = nil) {
        self.statusCode = statusCode
        self.title = title
        self.description = description
        self.params = params
    }

}

extension NetworkError: LocalizedError {

    public var errorDescription: String? {
        return NSLocalizedString(self.description, comment: self.title)
    }
    
}
