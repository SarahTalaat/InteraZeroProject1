//
//  StarshipViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation


class StarshipViewModel {
    
    init(){
    }
    
    var nextPage: String? = nil

    
    var starships: [StarshipModel] = [] {
        didSet{
            bindStarshipModelToVC()
        }
    }
    
    var bindStarshipModelToVC: (()->()) = {}
    
    func fetchStarships() {
         let endpoint: Constants.APIConfig = nextPage == nil ? .starships : .endPoint(nextPage!)
         let url = endpoint.url
         
         NetworkService.instance.requestFunction(urlString: url, method: .get) { (result: Result<StarshipsResponse, Error>) in
             switch result {
             case .success(let response):
                 self.starships.append(contentsOf: response.results)
                 if let nextPageURL = response.next?.replacingOccurrences(of: "https://swapi.dev/api/", with: "") {
                     self.nextPage = nextPageURL
                     self.fetchStarships() // Recursively fetch the next page
                 } else {
                     self.nextPage = nil
                 }
             case .failure(let error):
                 print(error)
             }
         }
     }
    
}
