//
//  HomeViewController.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 03.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class HomeViewController: UIViewController, StoryboardBased {

    // MARK: Outlets

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var detailButton: UIButton!

    // MARK: Stored properties
    
    private var subscriptions = Subscriptions()
    private var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    func bind(to model: HomeViewModel) {
        viewModel = model
    }

    private func bindViewModel() {

        subscriptions.add([
            
            // Outputs
            viewModel.$outHeadlineText.assign(to: \.text, on: label),
            viewModel.$outButtonText.assign(to: \.defaultTitle, on: button),
            viewModel.$outDetailButtonText.assign(to: \.defaultTitle, on: detailButton),

            // Inputs
            button.eventPublisher(for: .touchUpInside).map({_ in ()}).assign(to: \.viewModel.inTestAction, on: self),
            detailButton.eventPublisher(for: .touchUpInside).map({_ in ()}).assign(to: \.viewModel.inDetailAction, on: self)
        ])
    }
}
