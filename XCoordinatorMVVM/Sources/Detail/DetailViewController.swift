//
//  DetailViewController.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 02.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import UIKit
import XCoordinator
import SwiftUI

// Provides a preview using the Canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper(viewController: UINavigationController(rootViewController: DetailViewController(viewModel: DetailViewModel())))
    }
}


enum DesignSystem {

    enum Color: Int {
        case error              = 0x50237F
        case defaultBackground  = 0xD4E7FF
    }

    enum Font: String {
        case thonburi = "Thonburi"
        case palatino = "Palatino"
    }

    enum FontSize: CGFloat {
        case h1         = 28.0
        case h2         = 20.0
        case bodytext   = 16.0
    }

    enum LineSpacing: CGFloat {
        case h1         = 1.285
        case h2         = 1.6
        case bodytext   = 1.625
    }
}


extension UILabel {
    func apply(
        font: DesignSystem.Font,
        fontSize: DesignSystem.FontSize = .bodytext,
        lineSpacing: DesignSystem.LineSpacing = .bodytext) {

        self.font = UIFont(name: font.rawValue, size: fontSize.rawValue)

        // Needs to actually be implemented...
        // self.lineSpacing = lineSpacing
    }
}


extension UIColor {
    @nonobjc class var error: UIColor               { .init(.error) }
    @nonobjc class var defaultBackground: UIColor   { .init(.defaultBackground) }

    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }

    convenience init(_ colorName: DesignSystem.Color) {
        let colorValue = colorName.rawValue
        self.init(
            red: (colorValue >> 16) & 0xFF,
            green: (colorValue >> 8) & 0xFF,
            blue: colorValue & 0xFF
        )
    }
}

extension UIView {
    func activate(_ constraints: [NSLayoutConstraint]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}



class Headline: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        apply(font: .thonburi, fontSize: .h1, lineSpacing: .h1)
    }
}


class SpecialButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .error
        setTitleColor(.white, for: .normal)
    }
}


class DetailViewController: UIViewController {

    // MARK: Stored properties

    private var subscriptions = Subscriptions()
    private let viewModel: DetailViewModel!

    private var label: Headline = Headline()
    private var button: SpecialButton = SpecialButton()
    private var stackView = UIStackView()

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail 🔍"

        setupViews()
        setupConstraints()
        setupBindings()
    }

    private func setupViews() {
        view.backgroundColor = .defaultBackground

        view.addSubview(label)
        view.addSubview(button)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        view.addSubview(stackView)

        for i in 0...3 {
            let demoLabel = UILabel()
            demoLabel.apply(font: .palatino)
            demoLabel.numberOfLines = i % 2 == 0 ? 0 : 1
            demoLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
            stackView.addArrangedSubview(demoLabel)
        }
    }

    private func setupConstraints() {
        let topMargin: CGFloat = 20.0
        label.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topMargin),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        button.activate([
            button.widthAnchor.constraint(equalToConstant: 180),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        stackView.activate([
            stackView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    private func setupBindings() {

        subscriptions.add([

            // Outputs
            viewModel.$outHeadlineText.assign(to: \.label.text, on: self),
            viewModel.$outButtonText.assign(to: \.button.defaultTitle, on: self),

            // Inputs
            button.eventPublisher(for: .touchUpInside).map({_ in ()}).assign(to: \.viewModel.inBackAction, on: self),
        ])
    }
}

