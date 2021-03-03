//
//  NetworkDispatcher.swift
//  Talk About It
//
//  Created by Cole James on 2/24/21.
//

import Foundation

public protocol NetworkDispatcher {

    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (NetworkError) -> Void)
    
}
