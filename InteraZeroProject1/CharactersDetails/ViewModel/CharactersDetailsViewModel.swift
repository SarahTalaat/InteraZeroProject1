//
//  CharactersDetailsViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation

class CharactersDetailsViewModel{
    
    init(){
    }
    

    var characterDetails: CharactersModel? {
        didSet{
            bindCharactersDetailsModelToVC()
        }
    }
    
    var bindCharactersDetailsModelToVC: (()->()) = {}
    
    func fetchCharactersDetails() {

        let url = SharedDataModel.instance.urlCharacter ?? ""
         
         NetworkService.instance.requestFunction(urlString: url, method: .get) { (result: Result<CharactersModel, Error>) in
             switch result {
             case .success(let response):
                 self.characterDetails = response
             case .failure(let error):
                 print(error)
             }
         }
     }
    
}
