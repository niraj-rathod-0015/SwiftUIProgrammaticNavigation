//
//  NavigationDestination.swift
//
//
//  Created by Niraj Rathod on 6/8/23.
//

import SwiftUI

@available(iOS 16.0, *)
public protocol NavigationDestination<ID>: (Identifiable & Equatable & Hashable) {
    associatedtype Content where Content: View
    static func == (lhs: Self, rhs: Self) -> Bool
    var id: Self.ID { get }
    var destinationView: Content { get }
}
