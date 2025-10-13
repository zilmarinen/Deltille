//
//  Scale.swift
//
//  Created by Zack Brown on 23/05/2024.
//

import Foundation

// MARK: Scale

public protocol Scale: CaseIterable,
                       Codable,
                       Hashable,
                       Identifiable,
                       Sendable {
    
    static var `default`: Self { get }
    
    var edgeLength: Double { get }
}
