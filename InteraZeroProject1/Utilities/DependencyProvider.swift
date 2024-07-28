//
//  DependencyProvider.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 29/07/2024.
//

import Foundation

class DependencyProvider {
    
    
    static var starshipViewModel: StarshipViewModel {
        return StarshipViewModel()
    }
    
    static var starshipDetailsViewModel: StarshipDetailsViewModel {
        return StarshipDetailsViewModel()
    }
    
    static var charactersViewModel: CharactersViewModel {
        return CharactersViewModel()
    }
    
    static var charactersDetailsViewModel: CharactersDetailsViewModel {
        return CharactersDetailsViewModel()
    }
}
