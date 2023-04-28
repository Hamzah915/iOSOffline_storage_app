//
//  UserDefaultsScreen.swift
//  iOSOfflineStorage
//
//  Created by Hamzah Azam on 26/04/2023.
//

import SwiftUI

struct UserDefaultsScreen: View {
    var name = UserDefaults.standard.string(forKey: "com.ITC.iOSOfflineStorage.name")
    var body: some View {
        VStack{
            Group{
                Text(name ?? "default value")
                
                Button("Save into UserDefaults"){
                    UserDefaults.standard.set("SwiftUI", forKey: "com.ITC.iOSOfflineStorage.name")
                    
                    let pokemon = Pokemons(name: "Pikachu", url:"pokemon.com")
                    if let encodedData = try? JSONEncoder().encode(pokemon){
                        UserDefaults.standard.set(encodedData, forKey: "com.ITC.iOSOfflineStorage.PikachuObj")
                    }
                    
                }
                
                Button("Get data from UserDefaults"){
                    let valueInsideUserDefaults = UserDefaults.standard.string(forKey: "com.ITC.iOSOfflineStorage.name")
                    print(valueInsideUserDefaults ?? "default value")
                    let pikachuData = UserDefaults.standard.object(forKey: "com.ITC.iOSOfflineStorage.PikachuObj")
                    if let pikachuObj = try? JSONDecoder().decode(Pokemon.self, from: pikachuData as! Data){
                        UserDefaults.standard.set(pikachuData ,forKey: "com.ITC.iOSOfflineStorage.PikachuObj")
                        print(pikachuObj)
                    }
                    
                }
                
            }.padding().buttonStyle(.borderedProminent)
        }
        
    }
}

struct UserDefaultsScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsScreen()
    }
}

struct Pokemons : Codable{
//    var id : UUID
    let name : String
    let url : String
    
}
