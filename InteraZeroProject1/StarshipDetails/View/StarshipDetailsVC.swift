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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Bind the ViewModel to the ViewController
        starshipDetailsViewModel.bindStarshipDetailsModelToVC = {
            DispatchQueue.main.async {
                self.modelLabel.text = self.starshipDetailsViewModel.starshipDetails?.model
                self.manufacturerLabel.text = self.starshipDetailsViewModel.starshipDetails?.manufacturer
                self.costLabel.text = self.starshipDetailsViewModel.starshipDetails?.cost_in_credits
                self.lengthLabel.text = self.starshipDetailsViewModel.starshipDetails?.length
                self.passengersLabel.text = self.starshipDetailsViewModel.starshipDetails?.passengers
                self.crewLabel.text = self.starshipDetailsViewModel.starshipDetails?.crew

            }
        }
        
        // Fetch initial starships data
         starshipDetailsViewModel.fetchStarshipDetails()
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
