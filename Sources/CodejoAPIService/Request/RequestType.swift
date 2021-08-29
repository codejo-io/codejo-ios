//
//  RequestType.swift
//  Codejo
//
//  Created by Cole James on 2/24/21.
//

import UIKit

public protocol RequestType {

    associatedtype ResponseType: Codable
    associatedtype CallbackType: Codable

    static var path: String { get }
    static var method: HTTPMethod { get }

}

extension RequestType {

    public static func perform (
        request: RequestData,
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
        onSuccess: @escaping (ResponseType) -> Void,
        onError: @escaping (NetworkError) -> Void
    ) {
        if Reachability.isConnectedToNetwork() {

            dispatcher.dispatch(
                request: request,
                onSuccess: { (responseData: Data) in
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                        DispatchQueue.main.async {
                            onSuccess(result)
                        }
                    } catch let DecodingError.dataCorrupted(context) {
                        let message = "Data corrupted: \(context.debugDescription). codingPath: \(context.codingPath)"
                        let error = NetworkError(statusCode: 701, title: context.debugDescription, description: "There was an issue loading this data. Error code: 701", params: ["dataCorrupted": context.debugDescription])
                        handleError(request: request, responseData: responseData, errorMessage: message, error: error, onError: onError)
                    } catch let DecodingError.keyNotFound(key, context) {
                        let message = "Key '\(key)' not found: \(context.debugDescription). codingPath: \(context.codingPath)."
                        let error = NetworkError(statusCode: 702, title: context.debugDescription, description: "There was an issue loading this data. Error code: 702", params: ["keyNotFound": context.debugDescription])
                        handleError(request: request, responseData: responseData, errorMessage: message, error: error, onError: onError)
                    } catch let DecodingError.valueNotFound(value, context) {
                        let message = "Value '\(value)' not found: \(context.debugDescription). codingPath: \(context.codingPath)."
                        let error = NetworkError(statusCode: 703, title: context.debugDescription, description: "There was an issue loading this data. Error code: 703", params: ["valueNotFound": context.debugDescription])
                        handleError(request: request, responseData: responseData, errorMessage: message, error: error, onError: onError)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        let message = "Type '\(type)' mismatch: \(context.debugDescription). codingPath: \(context.codingPath)."
                        let error = NetworkError(statusCode: 704, title: context.debugDescription, description: "There was an issue loading this data. Error code: 704", params: ["typeMismatch": context.debugDescription])
                        handleError(request: request, responseData: responseData, errorMessage: message, error: error, onError: onError)
                    } catch {
                        handleError(request: request, responseData: responseData, errorMessage: error.localizedDescription, error: error, onError: onError)
                    }
                },
                onError: { (error: NetworkError) in
                    DispatchQueue.main.async {
                        if error.statusCode == 401 {
                            // Force Logout
                        } else {
                            onError(error)
                        }
                    }
                }
            )
        } else {
            onError(NetworkError(statusCode: 503, title: "Error", description: "No internet connection..."))
        }
    }

    static func handleError(
        request: RequestData,
        responseData: Data,
        errorMessage: String,
        error: Error,
        onError: @escaping (NetworkError) -> Void
    ) {
        DispatchQueue.main.async {
            onError(NetworkError(error: error))
        }
    }

}
