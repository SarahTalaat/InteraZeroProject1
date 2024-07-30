//
//  CustomTableViewCellDelegate.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 30/07/2024.
//

import Foundation

protocol CustomTableViewCellDelegate: AnyObject {
    func didTapDelete(cell: CustomTableViewCell)
    func didTapFavouriteButton(cell: CustomTableViewCell)
}
