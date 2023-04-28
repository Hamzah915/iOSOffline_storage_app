//
//  CoreDataProtocol.swift
//  iOSOfflineStorage
//
//  Created by Hamzah Azam on 27/04/2023.
//

import Foundation
protocol CoreDataProtocol{
    func saveDataInDatabase(pokemonList:[PokemonSuitableForUIWithId]) async throws
    func getPokemonDataFromDatabase() -> [PokemonModelEntity]

}
