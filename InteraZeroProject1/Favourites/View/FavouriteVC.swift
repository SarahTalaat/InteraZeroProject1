//
//  FavouriteVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 29/07/2024.
//

import UIKit

class FavouriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var favouriteTableview: UITableView!
    var favouriteViewModel = DependencyProvider.favouritesViewModel
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouriteViewModel.retrieveCharactersFromCoreData()
        favouriteViewModel.retrieveStarshipsFromCoreData()
        
        favouriteTableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        favouriteTableview.delegate = self
        favouriteTableview.dataSource = self
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
         favouriteTableview.register(nib, forCellReuseIdentifier: "cell")
        
        favouriteViewModel.bindStarshipsToVC = {
            DispatchQueue.main.async {
                self.favouriteTableview.reloadData()
            }
        }
        
        favouriteViewModel.bindCharactersToVC = {
            DispatchQueue.main.async {
                self.favouriteTableview.reloadData()
            }
        }
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)

        
        favouriteTableview.reloadData()
       
        
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        favouriteTableview.reloadData()
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
//                      cell.characterName(name: favouriteViewModel.favouriteCharactersArray[indexPath.row].name ?? "")
                      return cell
                  case 1:
                      cell.name.text = favouriteViewModel.favouriteStarshipsArray[indexPath.row].name
//                      cell.starshipName(name: favouriteViewModel.favouriteStarshipsArray[indexPath.row].name ?? "")
                      return cell
                  default:
                      cell.name.text = favouriteViewModel.favouriteStarshipsArray[indexPath.row].name
                      return cell
                      
                  }
        
        return cell
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
