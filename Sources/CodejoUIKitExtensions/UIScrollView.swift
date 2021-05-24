//
//  UIScrollView.swift
//  Codejo
//
//  Created by Cole James on 5/6/19.
//  Copyright © 2019 V Shred LLC. All rights reserved.
//

import UIKit.UIScrollView

public extension UIScrollView {

    func displayTempAlert(title:String, message: String, style: TempAlertStyle) {
        let imageViewHeight: CGFloat = 30.0
        let imageViewWidth: CGFloat = 30.0

        let textWidthOffset: CGFloat = 50.0

        let view = UIView()
        view.frame = CGRect(x: 0, y: -80, width: self.frame.width, height: 80)
        view.backgroundColor = style.color

        let imageView = UIImageView(image: style.image.imageWithInsets(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)))
        imageView.frame = CGRect(x: 20, y: view.frame.height / 2 - imageViewHeight / 2, width: imageViewWidth, height: imageViewHeight)
        imageView.setImageColor(color: style.color)
        imageView.backgroundColor = .white
        imageView.cornerRadius = 15

        view.addSubview(imageView)

        let titleLabel = UILabel(frame: CGRect(x: 30 + imageView.frame.width, y: 20, width: view.frame.width - textWidthOffset - imageView.frame.width, height: 20))
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.text = title

        view.addSubview(titleLabel)

        let descriptionLabel = UILabel(frame: CGRect(x: 30 + imageView.frame.width, y: 40, width: view.frame.width - textWidthOffset - imageView.frame.width, height: 20))
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .white
        descriptionLabel.text = message

        view.addSubview(descriptionLabel)

        self.addSubview(view)

        UIView.animate(
            withDuration: 0.2,
            delay: 0, usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
                view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            },
            completion: { (success) in
                UIView.animate(
                    withDuration: 0.2,
                    delay: 3.0, usingSpringWithDamping: 1,
                    initialSpringVelocity: 1,
                    options: .curveEaseInOut,
                    animations: {
                        view.frame = CGRect(x: 0, y: -80, width: view.frame.width, height: view.frame.height)
                    },
                    completion: { (_ success) in
                        view.removeFromSuperview()
                    })
            })
    }

    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view: UIView, offset: CGFloat = 0, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y - offset, width: 1, height: self.frame.height), animated: animated)
        }
    }

}
