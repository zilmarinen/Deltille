//
//  Edge.swift
//
//  Created by Zack Brown on 24/05/2024.
//

// MARK: Edge

public protocol Edge: CaseIterable,
                      Codable,
                      Hashable,
                      Identifiable,
                      Sendable {
    
    associatedtype C = Corner
    
    var corners: [C] { get }
    
    var edges: [Self] { get }
}
