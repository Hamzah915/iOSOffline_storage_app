//
//  CoreDataManager.swift
//  iOSOfflineStorage
//
//  Created by Hamzah Azam on 27/04/2023.
//

import Foundation
import CoreData

class CoreDataManager: CoreDataProtocol{
    
    let context: NSManagedObjectContext
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    
    func saveDataInDatabase(pokemonList:[PokemonSuitableForUIWithId]) async throws {
        deleteAllDataFromDatabase()
        
        try await PersistenceController.shared.container.performBackgroundTask { (privateContext) in
            if Thread.isMainThread{
                print("Main Thread")
            }else{
                print("Background Thread")
            }
            pokemonList.forEach { pokemon in
                let entity = PokemonModelEntity(context: privateContext)
                entity.pokemonName = pokemon.name
                entity.id = pokemon.id
                
                let ids = PokemonIDS(context:privateContext)
                entity.toPokemonIDS = ids
                
            }
            do{
                try privateContext.save()
                print("the data has been successfully saved into the database")
            }catch let error{
                print(error.localizedDescription)
                throw error
            }
        }
    }
    
    private func deleteAllDataFromDatabase(){
        let databasePokemonList = getPokemonDataFromDatabase()
        databasePokemonList.forEach { pokemon in
            context.delete(pokemon)
        }
        do{
            try context.save()
            print("the data has been deleted from the database")
        }catch {
          
        }
    }
        
    
    
    
    func getPokemonDataFromDatabase() -> [PokemonModelEntity] {
        let pokemonListFetchRequest = PokemonModelEntity.fetchRequest()
        let results = (try? context.fetch(pokemonListFetchRequest)) ?? []
        return results
    }
    
    
//    func fetchDataFromAPI(completion: @escaping () -> Void){
//        let privateContext  = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//        privateContext.perform {
//            // Make the API call
//            // let responseData = makeAPIRequest()
//
//            // Parse the response and save the data to the Core Data
//            // parseAndSaveToCoreData(responseData, in: privateContext)
//
//            //save changes to Core Data
//            do {
//                try privateContext.save()
//            }catch let error{
//                print("Error saving contect: \(error.localizedDescription)")
//            }
//
//            //call completion handler on main thread
//            DispatchQueue.main.async {
//                completion()
//            }
//        }
//    }

}
