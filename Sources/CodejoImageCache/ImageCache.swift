//
//  File.swift
//  
//
//  Created by Cole James on 4/2/21.
//

import UIKit

class ImageCache {

    static let shared = NSCache<AnyObject, AnyObject>()

    static let instance = ImageCache()

    var currentRequests = [String]()

    var pendingRequestCallbacks: [String: [((_ url: String, _ image: UIImage?) -> Void)]] = [:]

    static func cacheImage(url: String, _ callback: ((_ url: String, _ image: UIImage?) -> Void)? = nil) -> UIImage? {
        if let url = URL(string: url) {
            if let imageFromCache = ImageCache.shared.object(forKey: url.absoluteString as AnyObject) as? UIImage {
                return imageFromCache
            }

            if self.instance.pendingRequestCallbacks[url.absoluteString] != nil {
                registerCallback(url: url.absoluteString, callback: callback)
                return nil
            } else {
                registerCallback(url: url.absoluteString, callback: callback)

                if url.absoluteString.contains(".gif") {
                    var image: UIImage?
                    background(
                        background: {
                            image = UIImage.gif(url: url.absoluteString)
                            if let image = image {
                                ImageCache.shared.setObject(image, forKey: url.absoluteString as AnyObject)
                            }
                        },
                        completion: {
                            DispatchQueue.main.async {
                                callback?(url.absoluteString, image)
                                self.instance.currentRequests.removeAll { urlString -> Bool in
                                        return urlString == url.absoluteString
                                    }
                                }
                            })
                } else {
                    DispatchQueue.main.async {
                        URLSession.shared.dataTask(with: url) { (data, response, _ error) in
                            DispatchQueue.main.async {
                                if let response = data {
                                    if let imageToCache = UIImage(data: response) {
                                        ImageCache.shared.setObject(imageToCache, forKey: url.absoluteString as AnyObject)

                                        self.instance.executeCallbacks(url: url.absoluteString, image: imageToCache)
                                    } else {
                                        self.instance.executeCallbacks(url: url.absoluteString, image: nil)
                                    }
                                    self.instance.currentRequests.removeAll { urlString -> Bool in
                                        return urlString == url.absoluteString
                                    }
                                }
                            }
                        }.resume()
                    }
                }
            }
        }

        return nil
    }

    static func background(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

    private static func registerCallback(url: String, callback: ((_ url: String, _ image: UIImage?) -> Void)?) {
        if self.instance.pendingRequestCallbacks[url] == nil {
            self.instance.pendingRequestCallbacks[url] = []
        }

        if let callback = callback {
            self.instance.pendingRequestCallbacks[url]?.append(callback)
        }
    }

    func executeCallbacks(url: String, image: UIImage?) {
        let length = (self.pendingRequestCallbacks[url]?.count ?? 1) - 1

        for n in 0...length {
            self.pendingRequestCallbacks[url]?[n](url, image)
        }

        self.pendingRequestCallbacks[url] = nil
    }

    static func cacheImage(url: String, image: UIImage?) -> UIImage? {
        if let imageFromCache = ImageCache.shared.object(forKey: url as AnyObject) as? UIImage {
            return imageFromCache
        } else {
            guard let image = image else { return nil }
            ImageCache.shared.setObject(image, forKey: url as AnyObject)
            return image
        }
    }

}
