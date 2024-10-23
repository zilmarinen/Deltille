//
//  Mesh.swift
//
//  Created by Zack Brown on 17/06/2024.
//

import Euclid

public extension Mesh {
    
    ///
    /// Given an array of `vectors` and a `volume`, extrude each point along the Y axis
    /// to create a volumetric mesh with an upper surface and outer edge faces.
    ///
    
    static func wrap(_ vectors: [Vector],
                     _ surfaceColor: Color?,
                     _ edgeColor: Color,
                     _ volume: Double) -> Self {
        
        let v = Vector(0.0, volume, 0.0)
        let face = vectors.map { $0 + v }
        var polygons: [Polygon] = []
        
        for i in vectors.indices {
            
            let j = (i + 1) % vectors.count
            
            let v0 = vectors[i]
            let v1 = vectors[j]
            let v2 = v1 + v
            let v3 = v0 + v
            
            guard let polygon = Polygon.face([v0,
                                              v1,
                                              v2,
                                              v3],
                                             edgeColor) else { continue }
            
            polygons.append(polygon)
        }
        
        if let surfaceColor,
           let surface = Polygon.face(face,
                                      .unitY,
                                      surfaceColor) {
            
            polygons.append(surface)
        }
        
        return Mesh(polygons)
    }
}

