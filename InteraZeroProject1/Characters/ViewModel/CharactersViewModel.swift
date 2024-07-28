//
//  CharactersViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation


class CharactersViewModel {
    
    init(){
    }
    
    var nextPage: String? = nil

    var singleCharacter: CharactersModel?
    var allCharacters: [CharactersModel] = []
    var characters: [CharactersModel] = [] {
        didSet{
            bindCharactersModelToVC()
        }
    }
    
    var bindCharactersModelToVC: (()->()) = {}
    
    func fetchCharacters() {
         let endpoint: Constants.APIConfig = nextPage == nil ? .people : .endPoint(nextPage!)
         let url = endpoint.url
         
         NetworkService.instance.requestFunction(urlString: url, method: .get) { (result: Result<CharactersResponse, Error>) in
             switch result {
             case .success(let response):
                 
                self.allCharacters.append(contentsOf: response.results)
                self.characters = self.allCharacters
                 print("Resulttt: \(response.results)")
                 if let nextPageURL = response.next?.replacingOccurrences(of: "https://swapi.dev/api/", with: "") {
                     self.nextPage = nextPageURL
                     self.fetchCharacters() // Recursively fetch the next page
                 } else {
                     self.nextPage = nil
                 }
             case .failure(let error):
                 print(error)
             }
         }
     }
    
    func searchCharacters(with name: String) {
        if name.isEmpty {
            characters = allCharacters
        } else {
            characters = allCharacters.filter { $0.name.lowercased().contains(name.lowercased()) }
        }
    }
    
    func passSingleCharacterUrl(url:String){
        SharedDataModel.instance.urlCharacter = url
    }
    
}
