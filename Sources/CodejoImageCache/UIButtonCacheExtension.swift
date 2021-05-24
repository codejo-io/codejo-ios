//
//  File.swift
//  
//
//  Created by Cole James on 4/2/21.
//

import UIKit.UIButton

public extension UIButton {

    func cacheImage(url: String) {
        let image = ImageCache.cacheImage(url: url) { (imageUrl, image) in
            guard let image = image, url == imageUrl else { return }
            self.setImage(image, for: .normal)
        }

        self.setImage(image, for: .normal)
    }

}
