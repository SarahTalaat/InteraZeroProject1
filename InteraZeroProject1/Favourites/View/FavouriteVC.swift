//
//  FavouriteVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 29/07/2024.
//

import UIKit
import JGProgressHUD

class FavouriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var favouriteTableview: UITableView!
    var favouriteViewModel = DependencyProvider.favouritesViewModel
    
    private var emptyImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouriteViewModel.retrieveCharactersFromCoreData()
        favouriteViewModel.retrieveStarshipsFromCoreData()
        
        updateUI()
        
        favouriteTableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        favouriteTableview.delegate = self
        favouriteTableview.dataSource = self
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
         favouriteTableview.register(nib, forCellReuseIdentifier: "cell")
        
        setupEmptyImageView()
        
        
        favouriteViewModel.bindStarshipsToVC = {
            DispatchQueue.main.async {
               // self.favouriteTableview.reloadData()
                self.updateUI()
            }
        }
        
        favouriteViewModel.bindCharactersToVC = {
            DispatchQueue.main.async {
              //  self.favouriteTableview.reloadData()
                self.updateUI()
            }
        }
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)

        
        updateUI()
        //favouriteTableview.reloadData()
       
        
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        updateUI()
       // favouriteTableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          switch segmentedControl.selectedSegmentIndex {
          case 0:
              return favouriteViewModel.favouriteCharactersArray.count
          case 1:
              return favouriteViewModel.favouriteStarshipsArray.count
          default:
              return 0
          }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = favouriteTableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
       
            switch segmentedControl.selectedSegmentIndex {
                  case 0:
                      cell.name.text = favouriteViewModel.favouriteCharactersArray[indexPath.row].name
                      cell.setFavouriteButtonVisibility(isVisible: false)
                      return cell
                  case 1:
                      cell.name.text = favouriteViewModel.favouriteStarshipsArray[indexPath.row].name
                      cell.setFavouriteButtonVisibility(isVisible: false)
                      return cell
                  default:
                      cell.name.text = favouriteViewModel.favouriteStarshipsArray[indexPath.row].name
                      cell.setFavouriteButtonVisibility(isVisible: false)
                      return cell
                      
                  }
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                switch self.segmentedControl.selectedSegmentIndex {
                case 0:
                    self.favouriteViewModel.deleteCharacterFromCoreData(localCharacter: self.favouriteViewModel.favouriteCharactersArray[indexPath.row])
                case 1:
                    self.favouriteViewModel.deleteStarshipFromCoreData(localStarship: self.favouriteViewModel.favouriteStarshipsArray[indexPath.row])
                default:
                    break
                }
                
                self.showProgress(message: "Deleted Successfully")
               
              //  self.favouriteTableview.reloadData()
                self.updateUI()
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }

    func showProgress(message : String){
        let hud = JGProgressHUD()
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.textLabel.text = message
        hud.square = true
        hud.style = .dark
        hud.show(in: view)
        hud.dismiss(afterDelay: 1.3, animated: true){
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupEmptyImageView() {
        emptyImageView = UIImageView(image: UIImage(named: "noFavourites.png"))
        emptyImageView.contentMode = .scaleAspectFit
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyImageView)
        
        NSLayoutConstraint.activate([
            emptyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyImageView.widthAnchor.constraint(equalToConstant: 200),
            emptyImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func updateUI() {
        let hasItems: Bool
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            hasItems = favouriteViewModel.favouriteCharactersArray.count > 0
        case 1:
            hasItems = favouriteViewModel.favouriteStarshipsArray.count > 0
        default:
            hasItems = false
        }
        
        emptyImageView.isHidden = hasItems
        favouriteTableview.isHidden = !hasItems
        favouriteTableview.reloadData()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
