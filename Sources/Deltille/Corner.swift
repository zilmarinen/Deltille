//
//  Corner.swift
//  Deltille
//
//  Created by Zack Brown on 23/05/2024.
//

// MARK: Corner

public protocol Corner: CaseIterable,
                        Codable,
                        Hashable,
                        Identifiable,
                        Sendable,
                        RawRepresentable {
    
    associatedtype E: Edge
    
    init?(rawValue: Int)
    
    var corners: [Self] { get }
    
    var edges: [E] { get }
}
