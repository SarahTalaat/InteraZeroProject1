//
//  StarshipsVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class StarshipsVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    

    @IBOutlet weak var searchBarStarships: UISearchBar!
    @IBOutlet weak var tableViewStarships: UITableView!
    let starshipViewModel = StarshipViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
         tableViewStarships.register(nib, forCellReuseIdentifier: "cell")
         
         tableViewStarships.dataSource = self
         tableViewStarships.delegate = self
        
        
        // Bind the ViewModel to the ViewController
        starshipViewModel.bindStarshipModelToVC = {
            DispatchQueue.main.async {
                self.tableViewStarships.reloadData()
            }
        }
        
        // Fetch initial starships data
        starshipViewModel.fetchStarships()
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starshipViewModel.starships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewStarships.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let starship = starshipViewModel.starships[indexPath.row]
        cell.name.text = starshipViewModel.starships[indexPath.row].name
        return cell
    }
}

