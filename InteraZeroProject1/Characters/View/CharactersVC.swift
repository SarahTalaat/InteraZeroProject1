//
//  CharactersVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class CharactersVC: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    

    @IBOutlet weak var searchBarCharacters: UISearchBar!
    @IBOutlet weak var tableViewCharacters: UITableView!
    
    let charactersViewModel = DependencyProvider.charactersViewModel
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        charactersViewModel.segmentControlInndex(index: 0)
        
        charactersViewModel.networkStatusChanged = { isReachable in
            DispatchQueue.main.async {
                if !isReachable {
                    self.showAlerts(title: "No Internet Connection", message: "Please check your WiFi connection.")
                } else {
                   
                    self.charactersViewModel.bindCharactersModelToVC = {
                        DispatchQueue.main.async {
                            self.tableViewCharacters.reloadData()
                        }
                    }
                    self.charactersViewModel.fetchCharactersIfNeeded()
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
         tableViewCharacters.register(nib, forCellReuseIdentifier: "cell")
         
         tableViewCharacters.dataSource = self
         tableViewCharacters.delegate = self
         searchBarCharacters.delegate = self
        

        // Bind the ViewModel to the ViewController
        charactersViewModel.bindCharactersModelToVC = {
            DispatchQueue.main.async {
                self.tableViewCharacters.reloadData()
            }
        }
        
        // Fetch initial starships data
        charactersViewModel.setupReachability()
        charactersViewModel.fetchCharactersIfNeeded()
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersViewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewCharacters.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
  
        cell.name.text = charactersViewModel.characters[indexPath.row].name
        cell.characterName(name: charactersViewModel.characters[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let charactersDetailsVC = storyboard.instantiateViewController(withIdentifier: "CharactersDetailsVC") as? CharacterDetailsVC {
            charactersViewModel.passSingleCharacterUrl(url: charactersViewModel.characters[indexPath.row].url)
            charactersDetailsVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(charactersDetailsVC, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        charactersViewModel.searchCharacters(with: searchText)
    }
}

