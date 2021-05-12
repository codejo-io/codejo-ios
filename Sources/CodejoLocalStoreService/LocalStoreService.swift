//
//  File.swift
//  
//
//  Created by Cole James on 4/2/21.
//

import Foundation

class LocalStoreService: LocalStoreServicable {

    private var valueMap = [String: Codable]()

    func setItem<T: Codable>(item: T?, key: String, errorHandler: ((_ error: Error) -> Void)?) {
        do {
            UserDefaults.standard.set(try PropertyListEncoder().encode(item), forKey: key)
            valueMap[key] = item
        } catch let error {
            errorHandler?(error)
        }
    }

    func get<T: Codable>(type: T.Type, key: String, errorHandler: ((_ error: Error) -> Void)?) -> T? {
        if let item = valueMap[key] as? T {
            return item
        } else {
            do {
                let storedObject = UserDefaults.standard.object(forKey: key) as? Data
                if let storedObject = storedObject {
                    let result: T = try PropertyListDecoder().decode(T.self, from: storedObject)
                    valueMap[key] = result
                    return result
                }
            } catch let error {
                errorHandler?(error)
            }
        }
        return nil
    }

    func deleteItem(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        valueMap[key] = nil
    }

}
