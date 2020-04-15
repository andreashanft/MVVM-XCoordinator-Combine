//
//  AppDelegate.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 02.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import UIKit
import XCoordinator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Stored properties

    private lazy var mainWindow = UIWindow()
    private let router = AppCoordinator().strongRouter

    // MARK: UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureUI()
        router.setRoot(for: mainWindow)

        return true
    }

    // MARK: Helpers

    private func configureUI() {
        // Some global settings...
//        UIView.appearance().overrideUserInterfaceStyle = .light
    }
}
