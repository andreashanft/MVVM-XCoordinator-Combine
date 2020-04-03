//
//  Subscriptions.swift
//  XCoordinatorMVVM
//
//  Created by Andreas Hanft on 03.04.20.
//  Copyright © 2020 andreashanft. All rights reserved.
//

import Foundation
import Combine

typealias Subscriptions = Set<AnyCancellable>

// Some syntactic sugar to make adding multiple subscriptions less cumbersome
extension Subscriptions {
    mutating func add(_ subscriptions: [AnyCancellable]) {
        for item in subscriptions {
           insert(item)
        }
    }
}
