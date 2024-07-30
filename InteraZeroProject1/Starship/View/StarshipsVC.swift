//
//  StarshipsVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit
import JGProgressHUD


class StarshipsVC: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CustomTableViewCellDelegate {

    
    private var loadingFavIndicator: JGProgressHUD!
    @IBOutlet weak var searchBarStarships: UISearchBar!
    @IBOutlet weak var tableViewStarships: UITableView!
    let starshipViewModel = DependencyProvider.starshipViewModel
    
    private let customTransitionDelegate = CustomTransitioningDelegate(transitionType: .push)
    private var loadingIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableViewStarships.reloadData()
        starshipViewModel.segmentControlTitle(index: 1)
        
        starshipViewModel.networkStatusChanged = { isReachable in
            DispatchQueue.main.async {
                if !isReachable {
                    self.showAlerts(title: "No Internet Connection", message: "Please check your WiFi connection.")
                }
                else {
                   
                    self.starshipViewModel.bindStarshipModelToVC = {
                        DispatchQueue.main.async {
                            self.stopLoading()
                            self.tableViewStarships.reloadData()
                        }
                    }
                    
                    self.startLoading()
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
        
        setupLoadingIndicator()
        setupLoadingFavIndicator()
        
        // Bind the ViewModel to the ViewController
        starshipViewModel.bindStarshipModelToVC = {
            DispatchQueue.main.async {
                self.stopLoading()
                self.tableViewStarships.reloadData()
            }
        }
        
        if let navigationController = self.navigationController {
            navigationController.delegate = customTransitionDelegate
        }
        
        starshipViewModel.setupReachability()
        starshipViewModel.fetchStarshipsIfNeeded()
        
        starshipViewModel.segmentControlTitle(index: 1)
        
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starshipViewModel.starships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewStarships.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.delegate = self
        cell.name.text = starshipViewModel.starships[indexPath.row].name
        cell.starshipName(name: starshipViewModel.starships[indexPath.row].name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let starshipDetailsVC = storyboard.instantiateViewController(withIdentifier: "StarshipDetailsVC") as? StarshipDetailsVC {
            starshipViewModel.passSingleStarshipUrl(url: starshipViewModel.starships[indexPath.row].url)
            let transitioningDelegate = CustomTransitioningDelegate(transitionType: .push)
            self.navigationController?.delegate = transitioningDelegate as! UINavigationControllerDelegate
            starshipDetailsVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(starshipDetailsVC, animated: true)
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        starshipViewModel.searchStarships(with: searchText)
    }
    
    func didTapDelete(cell: CustomTableViewCell) {
        print("star name: \(cell.starshipName)")
        starshipViewModel.toggleStarshipFavoriteState(name: cell.starshipName ?? "")
        tableViewStarships.reloadData()
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
        tableViewStarships.isHidden = true
    }

    private func stopLoading() {
        loadingIndicator.stopAnimating()
        tableViewStarships.isHidden = false
    }
    
    
    func didTapFavouriteButton(cell: CustomTableViewCell) {
     
        startFavLoading()
        
        if let name = cell.characterName {
            if cell.characterName != nil {
                starshipViewModel.toggleStarshipFavoriteState(name: name)
            }
            tableViewStarships.reloadData()
            

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.stopFavLoading()
            }
        }
    }
    
    private func setupLoadingFavIndicator() {
        loadingFavIndicator = JGProgressHUD(style: .dark)
    }

    private func startFavLoading() {
        loadingFavIndicator.show(in: self.view)
    }

    private func stopFavLoading() {
        loadingFavIndicator.dismiss()
    }
}

