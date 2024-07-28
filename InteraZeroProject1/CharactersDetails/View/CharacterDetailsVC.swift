//
//  CharacterDetailsVC.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class CharacterDetailsVC: UIViewController {

    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    
    let charactersDetailsViewModel = DependencyProvider.charactersDetailsViewModel
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Bind the ViewModel to the ViewController
        charactersDetailsViewModel.bindCharactersDetailsModelToVC = {
            DispatchQueue.main.async {
                self.heightLabel.text = self.charactersDetailsViewModel.characterDetails?.height
                self.massLabel.text = self.charactersDetailsViewModel.characterDetails?.mass
                self.hairColorLabel.text = self.charactersDetailsViewModel.characterDetails?.hair_color
                self.skinColorLabel.text = self.charactersDetailsViewModel.characterDetails?.skin_color
                self.birthYearLabel.text = self.charactersDetailsViewModel.characterDetails?.birth_year
                self.genderLabel.text = self.charactersDetailsViewModel.characterDetails?.gender
                self.eyeColorLabel.text = self.charactersDetailsViewModel.characterDetails?.eye_color
            }
        }
        
        // Fetch initial starships data
        charactersDetailsViewModel.fetchCharactersDetails()
        
        
    
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
