//
//  UIControl+EventPublisher.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 03.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import Foundation
import UIKit
import Combine

/// Syntactic sugar to change the syntax for better readability
extension Publisher where Self.Failure == Never {
    public func execute(_ receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        return sink(receiveValue: receiveValue)
    }
}

/// Add an event publisher to UIControls
/// From: https://forums.swift.org/t/a-uicontrol-event-publisher-example/26215/19
extension UIControl {

    private class EventObserver {

        let control: UIControl
        let event: UIControl.Event
        let subject: PassthroughSubject<Void, Never>

        init(control: UIControl, event: UIControl.Event) {
            self.control = control
            self.event = event
            self.subject = .init()
        }

        func start() {
            control.addTarget(self, action: #selector(handleEvent(from:)), for: event)
        }

        func stop() {
            control.removeTarget(self, action: nil, for: event)
        }

        @objc
        func handleEvent(from sender: UIControl) {
            subject.send(())
        }
    }

    struct ControlEventPublisher: Publisher {

        typealias Output = Void
        typealias Failure = Never

        let control: UIControl
        let event: UIControl.Event

        init(control: UIControl, event: UIControl.Event) {
            self.control = control
            self.event = event
        }

        func receive<S>(subscriber: S)
            where S: Subscriber,
            S.Failure == Failure,
            S.Input == Output {
                let observer = EventObserver(control: control, event: event)
                observer
                    .subject
                    .handleEvents(
                        receiveSubscription: { _ in observer.start() },
                        receiveCancel: observer.stop
                    )
                    .receive(subscriber: subscriber)

        }
    }

    func eventPublisher(for event: UIControl.Event) -> ControlEventPublisher {
        return ControlEventPublisher(control: self, event: event)
    }

    var onTap: ControlEventPublisher {
        ControlEventPublisher(control: self, event: .touchUpInside)
    }
}
