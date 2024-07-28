//
//  TableViewCell.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favouritesButton(_ sender: Any) {
    }
    @IBAction func detailsButton(_ sender: Any) {
    }
}
