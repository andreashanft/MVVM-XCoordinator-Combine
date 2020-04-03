//
//  DetailViewController.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 02.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import UIKit
import XCoordinator

class DetailViewController: UIViewController {

    var router: UnownedRouter<AppRoute>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Such beauty much UI code...

        title = "Detail 🔍"

        view.backgroundColor = .cyan

        let button = UIButton()
        button.setTitle("◀️ Back", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 250),
            button.heightAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func buttonPressed() {
        router?.trigger(.back)
    }
}

