//
//  CharactersVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class CharactersVC: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CustomTableViewCellDelegate {

    

    

    @IBOutlet weak var searchBarCharacters: UISearchBar!
    @IBOutlet weak var tableViewCharacters: UITableView!
    
    private let customTransitionDelegate = CustomTransitioningDelegate(transitionType: .push)
    
    
    let charactersViewModel = DependencyProvider.charactersViewModel
    
    private var loadingIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableViewCharacters.reloadData()
        charactersViewModel.segmentControlInndex(index: 0)
        
        charactersViewModel.networkStatusChanged = { isReachable in
            DispatchQueue.main.async {
                if !isReachable {
                    self.showAlerts(title: "No Internet Connection", message: "Please check your WiFi connection.")
                } else {
                   
                    self.charactersViewModel.bindCharactersModelToVC = {
                        DispatchQueue.main.async {
                            self.stopLoading()
                            self.tableViewCharacters.reloadData()
                        }
                    }
                    
                    self.startLoading()
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
        
        setupLoadingIndicator()
        
        // Bind the ViewModel to the ViewController
        charactersViewModel.bindCharactersModelToVC = {
            DispatchQueue.main.async {
                self.stopLoading()
                self.tableViewCharacters.reloadData()
            }
        }
        if let navigationController = self.navigationController {
            navigationController.delegate = customTransitionDelegate
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
        cell.delegate = self
        cell.name.text = charactersViewModel.characters[indexPath.row].name
        cell.characterName(name: charactersViewModel.characters[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let charactersDetailsVC = storyboard.instantiateViewController(withIdentifier: "CharactersDetailsVC") as? CharacterDetailsVC {
            charactersViewModel.passSingleCharacterUrl(url: charactersViewModel.characters[indexPath.row].url)
            let transitioningDelegate = CustomTransitioningDelegate(transitionType: .push)
            self.navigationController?.delegate = transitioningDelegate as! UINavigationControllerDelegate
            charactersDetailsVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(charactersDetailsVC, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        charactersViewModel.searchCharacters(with: searchText)
    }
    
    func didTapDelete(cell: CustomTableViewCell) {
        charactersViewModel.toggleCharacterFavoriteState(name: cell.characterName ?? "")
        tableViewCharacters.reloadData()
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func startLoading() {
        loadingIndicator.startAnimating()
        tableViewCharacters.isHidden = true
    }

    private func stopLoading() {
        loadingIndicator.stopAnimating()
        tableViewCharacters.isHidden = false
    }
    
}

