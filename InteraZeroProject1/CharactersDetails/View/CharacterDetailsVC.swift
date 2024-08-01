//
//  CharacterDetailsVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class CharacterDetailsVC: UIViewController {
    
    
    @IBOutlet weak var hairColorTitleLabel: UILabel!
    @IBOutlet weak var genderTitleLabel: UILabel!
    @IBOutlet weak var birthYearTitleLabel: UILabel!
    @IBOutlet weak var eyeColorTitleLabel: UILabel!
    @IBOutlet weak var skinColorTitleLabel: UILabel!
    @IBOutlet weak var massTitleLabel: UILabel!
    @IBOutlet weak var heightTitleLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    
    var noInternetImageView: UIImageView!
    
    private var loadingIndicator: UIActivityIndicatorView!
    let charactersDetailsViewModel = DependencyProvider.charactersDetailsViewModel
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        charactersDetailsViewModel.networkStatusChanged = { isReachable in
            DispatchQueue.main.async {
                if !isReachable {
                    self.showNoInternetImage()
                    self.showAlerts(title: "No Internet Connection", message: "Please check your WiFi connection.")
                    self.stopLoading()
                } else {
                    self.hideNoInternetImage()
                    self.charactersDetailsViewModel.fetchCharactersDetailsIfNeeded()
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
        charactersDetailsViewModel.bindCharactersDetailsModelToVC = {
            DispatchQueue.main.async {
                self.stopLoading()
                self.heightLabel.text = self.charactersDetailsViewModel.characterDetails?.height
                self.massLabel.text = self.charactersDetailsViewModel.characterDetails?.mass
                self.hairColorLabel.text = self.charactersDetailsViewModel.characterDetails?.hair_color
                self.skinColorLabel.text = self.charactersDetailsViewModel.characterDetails?.skin_color
                self.birthYearLabel.text = self.charactersDetailsViewModel.characterDetails?.birth_year
                self.genderLabel.text = self.charactersDetailsViewModel.characterDetails?.gender
                self.eyeColorLabel.text = self.charactersDetailsViewModel.characterDetails?.eye_color
            }
        }
        
        startLoading()
        charactersDetailsViewModel.setupReachability()
        charactersDetailsViewModel.fetchCharactersDetailsIfNeeded()
        
        
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
            heightTitleLabel.isHidden = true
            heightLabel.isHidden = true
            massLabel.isHidden = true
            massTitleLabel.isHidden = true
            hairColorLabel.isHidden = true
            hairColorTitleLabel.isHidden = true
            skinColorLabel.isHidden = true
            skinColorTitleLabel.isHidden = true
            birthYearLabel.isHidden = true
            birthYearTitleLabel.isHidden = true
            genderLabel.isHidden = true
            genderTitleLabel.isHidden = true
            eyeColorLabel.isHidden = true
            eyeColorTitleLabel.isHidden = true
        }

        private func hideNoInternetImage() {
            noInternetImageView.isHidden = true
            heightTitleLabel.isHidden = false
            heightLabel.isHidden = false
            massLabel.isHidden = false
            massTitleLabel.isHidden = false
            hairColorLabel.isHidden = false
            hairColorTitleLabel.isHidden = false
            skinColorLabel.isHidden = false
            skinColorTitleLabel.isHidden = false
            birthYearLabel.isHidden = false
            birthYearTitleLabel.isHidden = false
            genderLabel.isHidden = false
            genderTitleLabel.isHidden = false
            eyeColorLabel.isHidden = false
            eyeColorTitleLabel.isHidden = false
        }

}
