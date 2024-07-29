//
//  CharactersDetailsViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation
import Reachability

class CharactersDetailsViewModel{
    
    init(){
        setupReachability()
        fetchCharactersDetails()
    }
    

    var characterDetails: CharactersModel? {
        didSet{
            bindCharactersDetailsModelToVC()
        }
    }
    
    var bindCharactersDetailsModelToVC: (()->()) = {}
    
    
    var reachability: Reachability?
    var networkStatusChanged: ((Bool) -> Void)?
    func setupReachability() {
        reachability = try? Reachability()
        reachability?.whenReachable = { reachability in
            self.networkStatusChanged?(true)
            print("Network reachable")
            self.fetchCharactersDetailsIfNeeded()
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
    func fetchCharactersDetailsIfNeeded() {
        guard reachability?.connection != .unavailable else {
            print("No internet connection")
            return
        }
        fetchCharactersDetails()
    }
    
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
