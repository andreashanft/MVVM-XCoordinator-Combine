//
//  UIButton+Combine.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 03.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import Foundation
import UIKit

// It seems there is no default way to set the title using combine, add a custom
// computed property to be able to use 'assign'.
extension UIButton {
    var defaultTitle: String? {
        set {
            setTitle(newValue, for: .normal)
        }
        get {
            title(for: .normal)
        }
    }
}
