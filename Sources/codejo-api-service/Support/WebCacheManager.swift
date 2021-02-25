//
//  WebCacheManager.swift
//  Talk About It
//
//  Created by Cole James on 2/24/21.
//

import Foundation
import WebKit

final class WebCacheManager {

    static func clean() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            for record in records {
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }

}
