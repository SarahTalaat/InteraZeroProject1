//
//  FavouritesViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 29/07/2024.
//

import Foundation


class FavouritesViewModel {
    
    var favouriteStarshipsArray: [LocalStarship] = []{
        didSet{
            bindStarshipsToVC()
        }
    }
    
    var favouriteCharactersArray: [LocalCharacter] = [] {
        didSet{
            bindCharactersToVC()
        }
    }
    
    init(){
        
    }
    
    var bindStarshipsToVC: (()->()) = {}
    var bindCharactersToVC: (()->()) = {}
    
    func retrieveStarshipsFromCoreData()->[LocalStarship]{
        favouriteStarshipsArray.removeAll()
        favouriteStarshipsArray = DatabaseService.instance.retriveStarshipsFromCoreData()
        print("z retrieved starshipArray : \(favouriteStarshipsArray)")
        return favouriteStarshipsArray
        
    }
    
    func retrieveCharactersFromCoreData()->[LocalCharacter]{
        favouriteCharactersArray.removeAll()
        favouriteCharactersArray = DatabaseService.instance.retriveCharactersFromCoreData()
        print("z retrieved characterArray : \(favouriteCharactersArray)")
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
