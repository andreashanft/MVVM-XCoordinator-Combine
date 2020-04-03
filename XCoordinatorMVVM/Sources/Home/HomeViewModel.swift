//
//  HomeViewModel.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 03.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import Foundation
import Combine
import XCoordinator

final class HomeViewModel {

    // MARK: Outputs

    @Published private(set) var outHeadlineText: String? = "Hello there!"
    @Published private(set) var outButtonText: String? = "Press Me!"
    @Published private(set) var outDetailButtonText: String? = "Detail"

    // MARK: Inputs

    var inTestAction: Void = () {
        didSet {
            buttonPresses += 1
            outHeadlineText = buttonPresses <= 1 ? "Button pressed!"
                : "Button pressed \(buttonPresses)x times"
            outButtonText = "Press me again!"
        }
    }

    var inDetailAction: Void = () {
        didSet {
            router.trigger(.detail)
        }
    }

    // MARK: Stored properties

    private let router: UnownedRouter<AppRoute>
    private var buttonPresses = 0

    // MARK: Initialization

    init(router: UnownedRouter<AppRoute>) {
        self.router = router
    }
}
