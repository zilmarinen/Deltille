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
    
    var edgeLength: Double { get }
}
