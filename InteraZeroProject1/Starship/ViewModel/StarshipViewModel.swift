//
//  StarshipViewModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation
import Reachability


class StarshipViewModel {
    
    init(){
    //    setupReachability()
    }
    
    var nextPage: String? = nil

    var allStarships: [StarshipModel] = []
    var starships: [StarshipModel] = [] {
        didSet{
            bindStarshipModelToVC()
        }
    }
    
    var bindStarshipModelToVC: (()->()) = {}
    
    private var isFetching = false
    var reachability: Reachability?
    var networkStatusChanged: ((Bool) -> Void)?
    
    func setupReachability() {
        reachability = try? Reachability()
        reachability?.whenReachable = { reachability in
            self.networkStatusChanged?(true)
            print("Network reachable")
            self.fetchStarshipsIfNeeded()
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
    
    func fetchStarships() {
        guard !isFetching else { return }
        isFetching = true
        
        let endpoint: Constants.APIConfig = nextPage == nil ? .starships : .endPoint(nextPage!)
        let url = endpoint.url
        
        NetworkService.instance.requestFunction(urlString: url, method: .get) { (result: Result<StarshipsResponse, Error>) in
            self.isFetching = false
            switch result {
            case .success(let response):
                self.allStarships.append(contentsOf: response.results)
                self.starships = self.allStarships
                if let nextPageURL = response.next?.replacingOccurrences(of: "https://swapi.dev/api/", with: "") {
                    self.nextPage = nextPageURL
                    print("Next Page : \(self.nextPage)")
                    print("Next Page URL : \(nextPageURL)")
                    self.fetchStarshipsIfNeeded()
                } else {
                    self.nextPage = nil
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchStarshipsIfNeeded() {
        guard reachability?.connection != .unavailable else {
            print("No internet connection")
            return
        }
        fetchStarships()
    }
    
    
    func searchStarships(with name: String) {
        if name.isEmpty {
            starships = allStarships
        } else {
            starships = allStarships.filter { $0.name.lowercased().contains(name.lowercased()) }
        }
    }
 
    
    func passSingleStarshipUrl(url:String){
        SharedDataModel.instance.urlStarship = url
    }
    
    func insertStarshipToCoreData(name:String){
        DatabaseService.instance.saveStarshipToCoreData(name: name)
    }
    
    func segmentControlTitle(index:Int){
        SharedDataModel.instance.segmentControlIndex = index
    }
    
    func returnSegmentControlTitle()->Int{
        return SharedDataModel.instance.segmentControlIndex ?? 1
    }
}
