//
//  Constants.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation

class Constants {
    
    enum APIConfig {
        
        case endPoint(String)
        case starships
        case people
    
        var resource: String {
            switch self {
                case .starships:
                    return "starships"
                case .people:
                    return "people"
                case .endPoint(let endpoint):
                    return endpoint
            }
        }
    
    
        var url: String {
            switch self{
                case .endPoint(let endpoint):
                    return "https://swapi.dev/api/\(endpoint)"
                default:
                    return "https://swapi.dev/api/\(self.resource)/"
            }
        }
    }
}
