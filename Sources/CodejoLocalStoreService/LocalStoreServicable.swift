//
//  File.swift
//  
//
//  Created by Cole James on 4/2/21.
//

import Foundation

protocol LocalStoreServicable {

    func get<T: Codable>(type: T.Type, key: String, errorHandler: ((_ error: Error) -> Void)?) -> T?

    func setItem<T: Codable>(item: T?, key: String, errorHandler: ((_ error: Error) -> Void)?)

    func deleteItem(key: String)

}
