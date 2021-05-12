//
//  File.swift
//  
//
//  Created by Cole James on 4/2/21.
//

import UIKit.UIImageView

extension UIImageView {

    func cacheImage(url: String?, placeholder: String? = nil) {
        if url == "avatar-upload" || url == "profile" {
            image = UIImage(named: url!)
            return
        }

        guard let url = url else { return }

        if let placeholder = placeholder {
            image = UIImage(named: placeholder)!
        }

        if let image = ImageCache.cacheImage(url: url, { (imageUrl, image) in
            guard let image = image, url == imageUrl else { return }
            self.image = image
        }) {
            self.image = image
        }
    }

    func cacheImage(url: String, image: UIImage?) {
        if let imageFromCache = ImageCache.shared.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
        } else {
            guard let image = image else { return }
            ImageCache.shared.setObject(image, forKey: url as AnyObject)
            self.image = image
        }
    }

}
