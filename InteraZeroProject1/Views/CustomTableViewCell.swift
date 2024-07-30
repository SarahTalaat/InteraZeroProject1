//
//  TableViewCell.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    var starshipViewModel = DependencyProvider.starshipViewModel
    var characterViewModel = DependencyProvider.charactersViewModel
    var starshipName: String?
    var characterName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favouritesButton(_ sender: Any) {
        
        print("FavouriteButton Tapped")
        if starshipViewModel.returnSegmentControlTitle() == 1 {
            print("z Starship cell fav btn")
            starshipViewModel.insertStarshipToCoreData(name: starshipName ?? "")
        } else if characterViewModel.returnSegmentControlTitle() == 0 {
            print("z character cell fav btn")
            characterViewModel.insertCharacterToCoreData(name: characterName ?? "")
        }
        
    }
    
    
    func starshipName(name:String){
        self.starshipName = name
        print("x cell starshipName: \(name)")
    }
    
    func characterName(name:String){
        self.characterName = name
        print("x cell characterName: \(name)")
    }

}
