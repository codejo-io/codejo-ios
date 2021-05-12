//
//  File.swift
//  
//
//  Created by Cole James on 4/2/21.
//

import UIKit

enum TempAlertStyle {

    case success
    case warning
    case error

}

extension TempAlertStyle {

    var color: UIColor {
        switch self {
        case .success: return .systemGreen
        case .warning: return .systemYellow
        case .error: return .systemRed
        }
    }

    var image: UIImage {
        switch self {
        case .success: return UIImage(named: "md-checkmark")!
        case .warning: return UIImage(named: "md-close")!
        case .error: return UIImage(named: "md-close")!
        }
    }

}
