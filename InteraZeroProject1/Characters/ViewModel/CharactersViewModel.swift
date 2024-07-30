//
//  CharactersViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation
import Reachability

class CharactersViewModel {
    
    init(){
     //   setupReachability()
        fetchCharacters()
    }
    
    var nextPage: String? = nil
    var allCharacters: [CharactersModel] = []
    var characters: [CharactersModel] = [] {
        didSet{
            bindCharactersModelToVC()
        }
    }
    
    private var isFetching = false
    var reachability: Reachability?
    var networkStatusChanged: ((Bool) -> Void)?
    func setupReachability() {
        reachability = try? Reachability()
        reachability?.whenReachable = { reachability in
            self.networkStatusChanged?(true)
            print("Network reachable")
            self.fetchCharactersIfNeeded()
        }
        reachability?.whenUnreachable = { _ in
            self.networkStatusChanged?(false)
            print("Network unreachable")
        }

        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    deinit {
        reachability?.stopNotifier()
    }
    
    func fetchCharacters() {
        guard !isFetching else { return }
        isFetching = true
        
        let endpoint: Constants.APIConfig = nextPage == nil ? .people : .endPoint(nextPage!)
        let url = endpoint.url
        
        NetworkService.instance.requestFunction(urlString: url, method: .get) { (result: Result<CharactersResponse, Error>) in
            self.isFetching = false
            switch result {
            case .success(let response):
                self.allCharacters.append(contentsOf: response.results)
                self.characters = self.allCharacters
                if let nextPageURL = response.next?.replacingOccurrences(of: "https://swapi.dev/api/", with: "") {
                        self.nextPage = nextPageURL
                    print("Next Page CH : \(self.nextPage)")
                    print("Next Page URL CH : \(nextPageURL)")
                        self.fetchCharactersIfNeeded()
                } else {
                    self.nextPage = nil
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchCharactersIfNeeded() {
        guard reachability?.connection != .unavailable else {
            print("No internet connection")
            return
        }
        fetchCharacters()
    }
    
    var bindCharactersModelToVC: (()->()) = {}
//
//    func fetchCharacters() {
//         let endpoint: Constants.APIConfig = nextPage == nil ? .people : .endPoint(nextPage!)
//         let url = endpoint.url
//
//         NetworkService.instance.requestFunction(urlString: url, method: .get) { (result: Result<CharactersResponse, Error>) in
//             switch result {
//             case .success(let response):
//
//                self.allCharacters.append(contentsOf: response.results)
//                self.characters = self.allCharacters
//                 print("Resulttt: \(response.results)")
//                 if let nextPageURL = response.next?.replacingOccurrences(of: "https://swapi.dev/api/", with: "") {
//                     self.nextPage = nextPageURL
//                     // Recursively fetch the next page
//                   //   self.fetchCharacters()
//                     self.fetchCharactersIfNeeded()
//
//                 } else {
//                     self.nextPage = nil
//                 }
//             case .failure(let error):
//                 print(error)
//             }
//         }
//     }
    

    
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
    
    func insertCharacterToCoreData(name:String){
        DatabaseService.instance.saveCharacterToCoreData(name: name)
    }
    
    func segmentControlTitle(index:Int){
        SharedDataModel.instance.segmentControlIndex = index
    }
    
    func returnSegmentControlTitle()->Int{
        return SharedDataModel.instance.segmentControlIndex ?? 0
    }
    
}
