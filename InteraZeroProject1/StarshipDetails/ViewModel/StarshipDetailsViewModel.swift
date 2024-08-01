//
//  StarshipViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation
import Reachability

class StarshipDetailsViewModel {
 
    
    init(){
        setupReachability()
        fetchStarshipDetails()
    }
    

    var starshipDetails: StarshipModel? {
        didSet{
            bindStarshipDetailsModelToVC()
        }
    }
    var reachability: Reachability?
    var networkStatusChanged: ((Bool) -> Void)?
    func setupReachability() {
        reachability = try? Reachability()
        reachability?.whenReachable = { reachability in
            self.networkStatusChanged?(true)
            print("Network reachable")
            self.fetchStarshipsDetailsIfNeeded()
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
    func fetchStarshipsDetailsIfNeeded() {
        guard reachability?.connection != .unavailable else {
            print("No internet connection")
            return
        }
        fetchStarshipDetails()
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
