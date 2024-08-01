//
//  CharactersSharedData.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation

class SharedDataModel {
    
    private init() {}
    static var instance = SharedDataModel()
    
    var urlCharacter: String?
    var urlStarship: String?
    var segmentControlIndex: Int?
    
}
