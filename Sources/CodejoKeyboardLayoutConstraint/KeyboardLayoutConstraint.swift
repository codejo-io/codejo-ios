//
//  File.swift
//  
//
//  Created by Cole James on 4/2/21.
//

import UIKit

public class KeyboardLayoutConstraint: NSLayoutConstraint {

    private var offset : CGFloat = 0
    private var keyboardVisibleHeight : CGFloat = 0

    @available(tvOS, unavailable)
    override public func awakeFromNib() {
        super.awakeFromNib()

        offset = constant

        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillShowNotification(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillHideNotification(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShowNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let animation = parseKeyboardAnimation(from: userInfo) else { return }

        keyboardVisibleHeight = animation.height

        self.updateShowConstant()

        UIView.animate(withDuration: TimeInterval(animation.duration), delay: 0, options: animation.animateOptions, animations: {
            UIApplication.shared.keyWindow?.layoutIfNeeded()
        }, completion: nil)

    }

    @objc func keyboardWillHideNotification(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo, let animation = parseKeyboardAnimation(from: userInfo) else { return }

        keyboardVisibleHeight = 0

        self.updateDissmissConstant()

        UIView.animate(withDuration: TimeInterval(animation.duration), delay: 0, options: animation.animateOptions, animations: {
            UIApplication.shared.keyWindow?.layoutIfNeeded()
        }, completion: nil)
    }

    private func parseKeyboardAnimation(from userInfo: [AnyHashable: Any]) -> KeyboardAnimationOptions? {
        if let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = frameValue.cgRectValue

            switch (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):
                if let duration = duration as? Double {
                    let options = UIView.AnimationOptions(rawValue: curve.uintValue)
                    return KeyboardAnimationOptions(height: frame.size.height, duration: duration, animateOptions: options)
                }
            default:
                break
            }
        }
        return nil
    }

    private func updateShowConstant() {
        let parentView = self.firstItem as? UIView
        let distanceToTop = parentView?.convert(parentView!.bounds, to: UIApplication.shared.keyWindow).origin.y ?? 0
        let distanceToBottom = UIScreen.main.bounds.height - distanceToTop
        self.constant = keyboardVisibleHeight - distanceToBottom + 20 // add 20 to add a little margin above the keyboard
    }

    private func updateDissmissConstant() {
        self.constant = offset + keyboardVisibleHeight
    }

}
