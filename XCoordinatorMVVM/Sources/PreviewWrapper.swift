//
//  PreviewWrapper.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 06.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import Foundation
import SwiftUI

public struct PreviewWrapper: UIViewControllerRepresentable {
    let viewController: UIViewController
    public func makeUIViewController(context: Context) -> UIViewController {
        return self.viewController
    }
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
