//
//  StarshipViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation

class StarshipDetailsViewModel {
 
    
    init(){
    }
    

    var starshipDetails: StarshipModel? {
        didSet{
            bindStarshipDetailsModelToVC()
        }
    }
    
    var bindStarshipDetailsModelToVC: (()->()) = {}
    
    func fetchStarshipDetails() {

        let url = SharedDataModel.instance.urlStarship ?? ""
         
         NetworkService.instance.requestFunction(urlString: url, method: .get) { (result: Result<StarshipModel, Error>) in
             switch result {
             case .success(let response):
                 self.starshipDetails = response
             case .failure(let error):
                 print(error)
             }
         }
     }
    
    
}
