//
//  Scale.swift
//  Deltille
//
//  Created by Zack Brown on 23/05/2024.
//

import Foundation

// MARK: Scale

public protocol Scale: Codable,
                       Hashable,
                       Identifiable,
                       Sendable {
    
    static var `default`: Self { get }
    
    var id: String { get }
    
    var size: Int { get }
}
