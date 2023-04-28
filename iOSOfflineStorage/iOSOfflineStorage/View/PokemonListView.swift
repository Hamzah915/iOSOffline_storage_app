//
//  ContentView.swift
//  Week5SwiftUIPropertyWrappersPractice
//
//  Created by Payam Karbassi on 24/04/2023.
//

import SwiftUI
import CoreData

struct PokemonListView: View {
    @State var isNextScreenShow = false
    // another way of doing it pokemonViewModel, but needs to be delcared somewhere else, system might remove data if it gets to much(nil the value)
    //@ObservedObject var pokemonViewModel : PokemonViewModel
    
    @StateObject var pokemonViewModel = PokemonViewModel(manager: NetworkManager())
    @State var isErrorOccured = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let fetchRequest: NSFetchRequest<PokemonModelEntity> = PokemonModelEntity.fetchRequest()
    @FetchRequest(entity: PokemonModelEntity.entity(), sortDescriptors:[])
    var results: FetchedResults<PokemonModelEntity>
    
    
    
    var body: some View {
        NavigationStack{
            VStack {
                if pokemonViewModel.networkErrorEnum != nil {
                    showAlert()
                }else {
                    List (results){pokemon in
                        NavigationLink {
                            PokemonDetailsPage(pokemon: pokemon)
                        } label: {
                            VStack(alignment: .leading){
                                PokemonListCell(imageUrl: "", name: pokemon.pokemonName ?? "default value")
                            }.multilineTextAlignment(.leading)
                        }
                    }
                }
            }.onAppear{
                Task{
//                    await getAPIData()
                    // getting path for SQLite
                    guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else{
                        return
                    }
                    
                    let sqlitePath = url.appendingPathComponent("iOSOfflineStorage.sqlite")
                    print(sqlitePath.path)
                }
                
            }.refreshable {
                await getAPIData()
            }//.padding()
        }

        
    }
    func getAPIData()async{
        await pokemonViewModel.getListOfPokemons(withUrlString: APIEndPoint.pokemonListEndPointUrl, viewContext: viewContext)
        if pokemonViewModel.networkErrorEnum != nil {
            isErrorOccured = true
        }
    }
    @ViewBuilder
    func showAlert()-> some View{
        ProgressView().alert(isPresented: $isErrorOccured) {
            Alert(title: Text("Oops there was a problem!"),
                  message: Text(pokemonViewModel.networkErrorEnum?.errorDescription ?? ""),
                  dismissButton: .default(Text("Okay"), action: {
                print("Alert controller is being dismissed")
            }))
        }
    }
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
