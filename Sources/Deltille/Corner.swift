//
//  Corner.swift
//
//  Created by Zack Brown on 23/05/2024.
//

// MARK: Corner

public protocol Corner: CaseIterable,
                        Codable,
                        Hashable,
                        Identifiable,
                        Sendable {
    
    associatedtype E = Edge
    
    var corners: [Self] { get }
    
    var edges: [E] { get }
}
