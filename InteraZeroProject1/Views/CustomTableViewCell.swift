//
//  TableViewCell.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var favouriteButtonUI: UIButton!
    @IBOutlet weak var name: UILabel!
    var starshipViewModel = DependencyProvider.starshipViewModel
    var characterViewModel = DependencyProvider.charactersViewModel
    var starshipName: String?
    var characterName: String?
    weak var delegate: CustomTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favouritesButton(_ sender: Any) {
        
//        print("FavouriteButton Tapped")
//        if starshipViewModel.returnSegmentControlTitle() == 1 {
//            print("z Starship cell fav btn")
//            starshipViewModel.insertStarshipToCoreData(name: starshipName ?? "")
//        }
//        if characterViewModel.returnSegmentControlIndex() == 0 {
//            print("z character cell fav btn")
//            characterViewModel.insertCharacterToCoreData(name: characterName ?? "")
//        }
        
        if starshipViewModel.returnSegmentControlTitle() == 1, let name = starshipName {
            starshipViewModel.toggleStarshipFavoriteState(name: name)
            updateFavouriteButtonState(isFavorited: starshipViewModel.isStarshipFavorited(name: name))
        } else if characterViewModel.returnSegmentControlIndex() == 0, let name = characterName {
            characterViewModel.toggleCharacterFavoriteState(name: name)
            updateFavouriteButtonState(isFavorited: characterViewModel.isCharacterFavorited(name: name))
        }
        
        // Notify the delegate
        delegate?.didTapFavouriteButton(cell: self)
        
    }
       
    
    func starshipName(name:String){
        self.starshipName = name
        print("x cell starshipName: \(name)")
        updateFavouriteButtonState(isFavorited: starshipViewModel.isStarshipFavorited(name: name))
    }
    
    func characterName(name:String){
        self.characterName = name
        print("x cell characterName: \(name)")
        updateFavouriteButtonState(isFavorited: characterViewModel.isCharacterFavorited(name: name))
    }

    func updateFavouriteButtonState(isFavorited: Bool) {
        let imageName = isFavorited ? "heart.fill" : "heart"
        favouriteButtonUI.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
