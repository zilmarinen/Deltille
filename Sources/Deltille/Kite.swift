//
//  Kite.swift
//
//  Created by Zack Brown on 24/05/2024.
//

extension Grid.Triangle {
    
    ///
    /// A kite encodes the vertices that form the perimeter of a
    /// polygon that can be tessellated within a triangle.
    ///
    
    public enum Kite: String,
                      CaseIterable,
                      Identifiable {
        
        case delta
        case epsilon
        case gamma
        case kappa
        case lambda
        case omega
        case phi
        case psi
        case sigma
        
        public static var uniform = Kite.kappa
        
        public var id: String { rawValue.capitalized }
        
        public var vertices: [Stencil.Vertex] {
            
            switch self {
                
            case .delta: return [.v0, .v5, .v7]
            case .epsilon: return [.v0, .v5, .center, .v7]
            case .gamma: return [.v0, .v5, .v6, .v9, .v10, .v7]
            case .kappa: return [.v0, .v1, .v2]
            case .lambda: return [.v0, .v5, .v9, .v10, .v6, .v7]
            case .omega: return [.v0, .v5, .v9, .v10, .v7]
            case .phi: return [.v0, .v5, .v6, .v10, .v7]
            case .psi: return [.v0, .v5, .v9, .v6, .v7]
            case .sigma: return [.v0, .v5, .v9, .v6, .v10, .v7]
            }
        }
    }
}

extension Grid.Triangle.Kite {
    
    ///
    /// Patterns define the combination of Kites required
    /// to completely fill the interior of a triangle.
    ///
    
    public enum Pattern: String,
                         CaseIterable,
                         Identifiable {
        
        case descartes
        case euclid
        case euler
        case gauss
        case mobius
        case pascal
        case thales
        
        public var id: String { rawValue.capitalized }
        
        public var kites: [Grid.Triangle.Kite] {
            
            switch self {
                
            case .descartes: return [.epsilon, .epsilon, .epsilon]
            case .euclid: return [.lambda, .delta, .sigma]
            case .euler: return [.psi, .delta, .omega]
            case .gauss: return [.lambda, .psi, .psi]
            case .mobius: return [.delta, .gamma, .sigma]
            case .pascal: return [.phi, .gamma, .phi]
            case .thales: return [.delta, .phi, .omega]
            }
        }
    }
}
