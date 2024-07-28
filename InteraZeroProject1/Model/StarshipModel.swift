//
//  StarshipModel.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 28/07/2024.
//

import Foundation

struct StarshipModel: Decodable {
    let name: String
    let model: String
    let manufacturer: String
    let cost_in_credits: String
    let length: String
    let max_atmosphering_speed: String
    let crew: String
    let passengers: String
    let cargo_capacity: String
    let consumables: String
    let hyperdrive_rating: String
    let MGLT: String
    let starship_class: String
    let pilots: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
}

struct StarshipsResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [StarshipModel]
}
