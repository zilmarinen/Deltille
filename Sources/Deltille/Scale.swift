//
//  Scale.swift
//  Deltille
//
//  Created by Zack Brown on 23/05/2024.
//

import Foundation

// MARK: Scale

public enum Scale: Int,
                   Codable,
                   Hashable,
                   Identifiable,
                   Sendable {
           
    public static let `default` = Self.tile

    case tile
    case chunk
    case region

    public var id: String {

        switch self {

        case .tile: "Tile"
        case .chunk: "Chunk"
        case .region: "Region"
        }
    }
}
