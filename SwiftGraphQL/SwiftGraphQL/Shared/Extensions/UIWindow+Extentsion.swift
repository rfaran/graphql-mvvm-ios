//
//  UIWindow+Extentsion.swift
//
//  Created by Faran Rasheed on 13/08/2023.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows.filter({$0.isKeyWindow}).first
    }
}
