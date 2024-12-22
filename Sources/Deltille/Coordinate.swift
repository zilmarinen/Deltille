//
//  Coordinate.swift
//
//  Created by Zack Brown on 23/05/2024.
//

// MARK: Coordinate

extension Grid {
 
    public struct Coordinate: Codable,
                              Hashable,
                              Identifiable,
                              Sendable {
        
        public static let zero = Self(0, 0, 0)
        public static let one = Self(1, 1, 1)
        public static let unitX = Self(1, 0, 0)
        public static let unitY = Self(0, 1, 0)
        public static let unitZ = Self(0, 0, 1)
        
        public let x: Int
        public let y: Int
        public let z: Int
        
        public var id: String { "[\(x), \(y), \(z)]" }
        
        public var sum: Int { x + y + z }
                
        public var equalToZero: Bool { sum == 0 }
        public var equalToOne: Bool { sum == 1 }
        public var equalToNegativeOne: Bool { sum == -1 }
        
        public init(_ x: Int,
                    _ y: Int,
                    _ z: Int) {
            
            self.x = x
            self.y = y
            self.z = z
        }
    }
}

extension Grid.Coordinate {
    
    public static func -(lhs: Self,
                         rhs: Self) -> Self { .init(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z) }
    
    public static func +(lhs: Self,
                         rhs: Self) -> Self { .init(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z) }
    
    public static prefix func -(rhs: Self) -> Self { .init(-rhs.x, -rhs.y, -rhs.z) }
    
    public static func *(lhs: Self,
                         rhs: Int) -> Self { .init(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs) }
}
