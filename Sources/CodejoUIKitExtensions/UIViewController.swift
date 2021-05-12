//
//  UIViewControllerExtension.swift
//  V Shred
//
//  Created by Cole James on 2/15/19.
//  Copyright © 2019 None. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {

    func displayTempAlert(title:String, message: String, style: TempAlertStyle) {

        let imageViewHeight: CGFloat = 30.0
        let imageViewWidth: CGFloat = 30.0

        let textWidthOffset: CGFloat = 50.0

        let view = UIView()
        view.frame = CGRect(x: 0, y: -80, width: self.view.frame.width, height: 80)
        view.backgroundColor = style.color

        let imageView = UIImageView(image: style.image.imageWithInsets(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)))
        imageView.frame = CGRect(x: 20, y: view.frame.height / 2 - imageViewWidth / 2, width: imageViewWidth, height: imageViewHeight)
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

        self.view.addSubview(view)

        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
                view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            },
            completion: { (success) in
                UIView.animate(
                    withDuration: 0.2,
                    delay: 3.0,
                    usingSpringWithDamping: 1,
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

    /// Creates and presents an alert with a title, description, and single button
    func simpleAlert(title: String, description: String, buttonText: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    /// Creates and presents a Simple Alert with a single button and an action for that button
    func simpleAlertWithAction(title: String,
                               description: String,
                               buttonText: String,
                               action: @escaping (UIAlertAction) -> Void)
    {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: action)
        alert.addAction(alertAction)

        self.present(alert, animated: true)
    }

    func cancelableAlert(title: String, description: String, cancelText: String, actionText: String, actionStyle: UIAlertAction.Style, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: cancelText, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: actionText, style: actionStyle) {(action) in
            completion?(action)
        })

        self.present(alert, animated: true)
    }

    func multipleActionsAlert(
        sender              : UIButton,
        alertData           : AlertData,
        actionOneText       : String,
        actionTwoText       : String,
        actionOneHandler    : ((UIAlertAction) -> Void)? = nil,
        actionTwoHandler    : ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(title: alertData.title, message: alertData.description, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: alertData.cancelButtonText, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: actionOneText, style: .default) {(actionOne) in
            actionOneHandler?(actionOne)
        })
        alert.addAction(UIAlertAction(title: actionTwoText, style: .default) {(actionTwo) in
           actionTwoHandler?(actionTwo)
        })
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = sender.frame

        self.present(alert, animated: true)
    }

    /// Creates and presents an alert with an error title and an ok button
    func errorAlert(_ errorString: String?) {
        guard let errorString = errorString else { return }
        self.simpleAlert(title: "Error", description: errorString, buttonText: "Ok")
    }

}
