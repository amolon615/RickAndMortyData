//
//  Character.swift
//  RickAndMortyData
//
//  Created by Artem on 03/12/2022.
//

import Foundation
import SwiftUI

// The RootJSON struct that represents the root object in the JSON data
struct RootJSON: Codable {
    let info: Info
    let results: [Character]
}

// The Info struct that represents the info object in the JSON data
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String
    let prev: String?
}

// The Character struct that represents a character in the JSON data
struct Character: Codable, Identifiable {
    // The Location struct that represents a location in the JSON data
    struct Location: Codable {
        let name: String
        let url: String
    }
    
    let id = UUID()
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String

}
