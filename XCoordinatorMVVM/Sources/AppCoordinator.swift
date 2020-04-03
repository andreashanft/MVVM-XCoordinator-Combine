//
//  AppCoordinator.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 02.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import Foundation
import XCoordinator
import Reusable

enum AppRoute: Route {
    case home
    case detail
    case back
}

class AppCoordinator: NavigationCoordinator<AppRoute> {

    // MARK: Initialization

    init() {
        super.init(initialRoute: .home)
    }

    // MARK: Overrides

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {

        case .home:
            let viewController = HomeViewController.instantiate()
            let viewModel = HomeViewModel(router: unownedRouter)
            viewController.bind(to: viewModel)
            return .push(viewController)

        case .detail:
            let viewController = DetailViewController()
            viewController.router = unownedRouter
            return .push(viewController)

            // TODO: Find a better way with XCoordinator to have a generic "back" route
        case .back:
            return .pop()
        }
    }
}
