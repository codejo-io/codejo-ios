//
//  URLSessionNetworkDispatcher.swift
//  Codejo
//
//  Created by Cole James on 2/24/21.
//

import Foundation

public struct URLSessionNetworkDispatcher: NetworkDispatcher {

    public static let instance = URLSessionNetworkDispatcher()

    private func parseError(_ data: Data?, statusCode: Int, params: [String: Any]?) -> NetworkError {
        if let data = data {
            let result = try? (JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any])
            let errorDict = result?["errors"] as? [String: [String]]
            let json = String(data: data, encoding: .utf8)
//            print(json)
            if let errorDict = errorDict {
                let index = errorDict.startIndex
                let errorTitle = errorDict.keys[index]
                let errorDescription = errorDict.first!.value[0]
                return NetworkError(
                    statusCode: statusCode,
                    title: errorTitle,
                    description: errorDescription,
                    params: ["request": params ?? "", "response": result ?? "Unable to parse response from API.", "jsonString": json ?? "Unable to parse response from API."]
                )
            } else if result?["errors"] != nil, let message = result?["message"] as? String {
                return NetworkError(statusCode: statusCode, title: "Error", description: message, params: ["request": params ?? "", "response": result ?? "Unable to parse response from API."])
            } else {
                return NetworkError(
                    statusCode: statusCode,
                    title: "Error",
                    description: "Unexpected Error Occurred",
                    params: ["request": params ?? "", "response": result ?? "Unable to parse response from API."]
                )
            }
        } else {
            return NetworkError(statusCode: statusCode, title: "Error", description: "Unexpected Error Occurred")
        }
    }

    private func configureRequest(_ request: RequestData) -> URLRequest? {
        guard let url = URL(string: request.baseUrl + request.path) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)

        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        urlRequest.httpMethod = request.method.rawValue

        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        if let params = request.params {
            if params["image"] != nil {
                var body = Data()

                let boundary = "Boundary-\(NSUUID().uuidString)"
                urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

                let fname = "image.jpeg"
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition:form-data; name=\"images[]\";filename=\"\(fname)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(params["image"] as! Data)
                body.append("\r\n".data(using: .utf8)!)
                body.append("--\(boundary)--\r\n".data(using: .utf8)!)

                urlRequest.httpBody = body
            } else {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
        } else {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }

    public func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (NetworkError) -> Void) {
        if let urlRequest = self.configureRequest(request) {
            DispatchQueue.main.async {
                URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    if let error = error {
                        onError(NetworkError(statusCode: nil, title: "Error", description: error.localizedDescription))
                        return
                    }

                    guard let data_ = data else {
                        onError(NetworkError(statusCode: nil, title: "Error", description: "Unexpected Error Occurred"))
                        return
                    }

                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 401 {
                            onError(NetworkError(statusCode: httpResponse.statusCode, title: "Error", description: NSLocalizedString("sessionExpiredError", comment: "")))
                        } else if httpResponse.statusCode != 200 && httpResponse.statusCode != 201 {
                            onError(self.parseError(data, statusCode: httpResponse.statusCode, params: request.params))
                        } else {
                            onSuccess(data_)
                        }
                    }
                }.resume()
            }
        } else {
            onError(NetworkError(statusCode: nil, title: "Errora", description: "Invalid request URL"))
        }
    }

}
