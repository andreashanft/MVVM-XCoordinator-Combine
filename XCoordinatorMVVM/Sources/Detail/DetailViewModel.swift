//
//  DetailViewModel.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 07.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import Foundation
import Combine
import XCoordinator

final class DetailViewModel {

    // MARK: Outputs

    @Published private(set) var headlineText: String? = "Much Detail! Such Beauty!"
    @Published private(set) var buttonText: String? = "↩️ Back"
    @Published private(set) var textLabels: [String] = [
        "Bavaria ipsum dolor sit amet Schneid Ledahosn wolpern",
        "Etza muass sodala Kirwa bitt, nimma.",
        "Spuiratz Baamwach ebba, obandeln aba trihöleridi dijidiholleri!"]

    // MARK: Inputs

    var backAction: Void = () {
        didSet {
            router?.trigger(.back)
        }
    }

    // MARK: Stored properties

    private let router: UnownedRouter<AppRoute>?

    // MARK: Initialization

    init(router: UnownedRouter<AppRoute>? = nil) {
        self.router = router
    }
}
