//
//  iOSOfflineStorageApp.swift
//  iOSOfflineStorage
//
//  Created by Hamzah Azam on 26/04/2023.
//

import SwiftUI

@main
struct iOSOfflineStorageApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            StartView().environment(\.managedObjectContext, persistenceController.container.viewContext)
//            ContentView()
        }
    }
}
