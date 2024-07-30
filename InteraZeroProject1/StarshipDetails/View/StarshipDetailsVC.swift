//
//  StarshipDetailsVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class StarshipDetailsVC: UIViewController {
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var passengersLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    
    let starshipDetailsViewModel = DependencyProvider.starshipDetailsViewModel
    private var loadingIndicator: UIActivityIndicatorView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        starshipDetailsViewModel.networkStatusChanged = { isReachable in
            DispatchQueue.main.async {
                if !isReachable {
                    self.showAlerts(title: "No Internet Connection", message: "Please check your WiFi connection.")
                } else {
                    self.starshipDetailsViewModel.fetchStarshipsDetailsIfNeeded()
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingIndicator()

        // Do any additional setup after loading the view.
        // Bind the ViewModel to the ViewController
        starshipDetailsViewModel.bindStarshipDetailsModelToVC = {
            DispatchQueue.main.async {
                self.stopLoading()
                self.modelLabel.text = self.starshipDetailsViewModel.starshipDetails?.model
                self.manufacturerLabel.text = self.starshipDetailsViewModel.starshipDetails?.manufacturer
                self.costLabel.text = self.starshipDetailsViewModel.starshipDetails?.cost_in_credits
                self.lengthLabel.text = self.starshipDetailsViewModel.starshipDetails?.length
                self.passengersLabel.text = self.starshipDetailsViewModel.starshipDetails?.passengers
                self.crewLabel.text = self.starshipDetailsViewModel.starshipDetails?.crew

            }
        }
        
         startLoading()
         starshipDetailsViewModel.fetchStarshipDetails()
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
        view.isUserInteractionEnabled = false
    }

    private func stopLoading() {
        loadingIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
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
