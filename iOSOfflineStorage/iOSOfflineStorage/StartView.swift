//
//  StartView.swift
//  iOSOfflineStorage
//
//  Created by Hamzah Azam on 26/04/2023.
//

import SwiftUI

struct StartView: View {
    
    var body: some View {
        NavigationStack{
            VStack{
                Group{
                    NavigationLink {
                        UserDefaultsScreen()
                    } label: {
                        Text("UserDefaults Screen")
                    }
                    
                    NavigationLink{
                        KeyChainScreen()
                    } label: {
                        Text("KeyChain Screen")
                    }

                    NavigationLink{
                        PokemonListView()
                    } label: {
                        Text("CoreData Screen")
                    }
                    
                    
                    
                }.padding().buttonStyle(.borderedProminent)
            }
        }
    }
}

struct StartViews_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
