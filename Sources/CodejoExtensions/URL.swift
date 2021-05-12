//
//  URL.swift
//  vshred-ios
//
//  Created by Cole James on 7/24/20.
//  Copyright © 2020 V Shred LLC. All rights reserved.
//

import Foundation

extension URL {

    func getQueryComponent(with key: String) -> String? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        let queryItem = components?.queryItems?.first(where: { item -> Bool in
            return item.name == key
        })

        return queryItem?.value
    }

}
