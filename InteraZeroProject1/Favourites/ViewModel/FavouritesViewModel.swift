//
//  FavouritesViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 29/07/2024.
//

import Foundation


class FavouritesViewModel {
    
    var favouriteStarshipsArray: [LocalStarship] = []
    var favouriteCharactersArray: [LocalCharacter] = []
    
    
    func retrieveStarshipsFromCoreData()->[LocalStarship]{
        favouriteStarshipsArray.removeAll()
        favouriteStarshipsArray = DatabaseService.instance.retriveStarshipsFromCoreData()
        return favouriteStarshipsArray
        
    }
    
    func retrieveCharactersFromCoreData()->[LocalCharacter]{
        favouriteCharactersArray.removeAll()
        favouriteCharactersArray = DatabaseService.instance.retriveCharactersFromCoreData()
        return favouriteCharactersArray
    }
    
    
    func deleteStarshipFromCoreData(localStarship: LocalStarship) -> [LocalStarship]{
        
        favouriteStarshipsArray.removeAll()
        favouriteStarshipsArray = DatabaseService.instance.deleteStarshipFromCoreData(name: localStarship.name ?? "")
        return favouriteStarshipsArray
        
    }
    
    func deleteCharacterFromCoreData(localCharacter: LocalCharacter) -> [LocalCharacter]{
        
        favouriteCharactersArray.removeAll()
        favouriteCharactersArray = DatabaseService.instance.deleteCharacterFromCoreData(name: localCharacter.name ?? "")
        return favouriteCharactersArray
        
    }
    

}
