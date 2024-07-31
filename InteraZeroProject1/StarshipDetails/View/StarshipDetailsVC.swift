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
    
    @IBOutlet weak var modelTitleLabel: UILabel!
    @IBOutlet weak var manufacturerTitleLabel: UILabel!
    
    @IBOutlet weak var passengersTitleLabel: UILabel!
    @IBOutlet weak var crewTitleLabel: UILabel!
    @IBOutlet weak var lengthTitleLabel: UILabel!
    @IBOutlet weak var costTitleLabel: UILabel!
    let starshipDetailsViewModel = DependencyProvider.starshipDetailsViewModel
    private var loadingIndicator: UIActivityIndicatorView!
    var noInternetImageView: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        starshipDetailsViewModel.networkStatusChanged = { isReachable in
            DispatchQueue.main.async {
                if !isReachable {
                    self.showNoInternetImage()
                    self.showAlerts(title: "No Internet Connection", message: "Please check your WiFi connection.")
                    self.stopLoading()
                } else {
                    self.hideNoInternetImage()
                    self.starshipDetailsViewModel.fetchStarshipsDetailsIfNeeded()
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingIndicator()
        setupNoInternetImageView()

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
    
    private func setupNoInternetImageView() {
            noInternetImageView = UIImageView(image: UIImage(named: "noInternet"))
            noInternetImageView.contentMode = .scaleAspectFit
            noInternetImageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(noInternetImageView)
            
            NSLayoutConstraint.activate([
                noInternetImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                noInternetImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                noInternetImageView.widthAnchor.constraint(equalToConstant: 200),
                noInternetImageView.heightAnchor.constraint(equalToConstant: 200)
            ])
            
            noInternetImageView.isHidden = true
        }
        
    private func showNoInternetImage() {
        noInternetImageView.isHidden = false
        modelLabel.isHidden = true
        manufacturerLabel.isHidden = true
        costLabel.isHidden = true
        lengthLabel.isHidden = true
        passengersLabel.isHidden = true
        crewLabel.isHidden = true
        modelTitleLabel.isHidden = true
        manufacturerTitleLabel.isHidden = true
        passengersTitleLabel.isHidden = true
        crewTitleLabel.isHidden = true
        lengthTitleLabel.isHidden = true
        costTitleLabel.isHidden = true
    }

    private func hideNoInternetImage() {
        noInternetImageView.isHidden = true
        modelLabel.isHidden = false
        manufacturerLabel.isHidden = false
        costLabel.isHidden = false
        lengthLabel.isHidden = false
        passengersLabel.isHidden = false
        crewLabel.isHidden = false
        modelTitleLabel.isHidden = false
        manufacturerTitleLabel.isHidden = false
        passengersTitleLabel.isHidden = false
        crewTitleLabel.isHidden = false
        lengthTitleLabel.isHidden = false
        costTitleLabel.isHidden = false
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
