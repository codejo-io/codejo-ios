//
//  RequestType.swift
//  Talk About It
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
        sender: [UIButton?]? = nil,
        shouldShowIndicator: Bool = true,
        timeout: Double = 10.0,
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
                    } catch let error {
                        DispatchQueue.main.async {
                            var params: [String: Any] = ["url": request.baseUrl]

                            if let json = String(data: responseData, encoding: .utf8) {
                                params["body"] = [ "response": json ]
                            } else if let result = try? (JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any]) {
                                params["body"] = [ "response": result ]
                            } else {
                                params["body"] = [ "error": "Unable to parse response from API." ]
                            }

                            onError(NetworkError(error: error))
                        }
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

}
