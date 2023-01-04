//
//  Character.swift
//  RickAndMortyData
//
//  Created by Artem on 03/12/2022.
//

import Foundation
import SwiftUI


struct Wizard: Codable, Identifiable {
    let elixirs: [Elixir]
    let id: String
    let firstName: String?
    let lastName: String
}


struct Elixir: Codable, Identifiable {
    let id: String
    let name: String
}
