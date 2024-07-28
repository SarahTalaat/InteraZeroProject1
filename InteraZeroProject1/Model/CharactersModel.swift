//
//  CharactersModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation


struct CharactersResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [CharactersModel]
}

struct CharactersModel: Codable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String
}
