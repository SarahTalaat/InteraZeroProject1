//
//  StarshipsVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class StarshipsVC: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    

    @IBOutlet weak var searchBarStarships: UISearchBar!
    @IBOutlet weak var tableViewStarships: UITableView!
    let starshipViewModel = DependencyProvider.starshipViewModel
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        starshipViewModel.networkStatusChanged = { isReachable in
            DispatchQueue.main.async {
                if !isReachable {
                    self.showAlerts(title: "No Internet Connection", message: "Please check your WiFi connection.")
                }
                else {
                   
                    self.starshipViewModel.bindStarshipModelToVC = {
                        DispatchQueue.main.async {
                            self.tableViewStarships.reloadData()
                        }
                    }
                    self.starshipViewModel.fetchStarshipsIfNeeded()
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
         tableViewStarships.register(nib, forCellReuseIdentifier: "cell")
         
         tableViewStarships.dataSource = self
         tableViewStarships.delegate = self
         searchBarStarships.delegate = self
        
        
        // Bind the ViewModel to the ViewController
        starshipViewModel.bindStarshipModelToVC = {
            DispatchQueue.main.async {
                self.tableViewStarships.reloadData()
            }
        }
        
        // Fetch initial starships data
        starshipViewModel.setupReachability()
        starshipViewModel.fetchStarshipsIfNeeded()
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starshipViewModel.starships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewStarships.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.name.text = starshipViewModel.starships[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let starshipDetailsVC = storyboard.instantiateViewController(withIdentifier: "StarshipDetailsVC") as? StarshipDetailsVC {
            starshipViewModel.passSingleStarshipUrl(url: starshipViewModel.starships[indexPath.row].url)
            starshipDetailsVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(starshipDetailsVC, animated: true)
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        starshipViewModel.searchStarships(with: searchText)
    }
    
    
}

