//
//  LibraryBooksApp.swift
//  LibraryBooks
//
//  Created by Angelos Staboulis on 3/12/23.
//

import SwiftUI

@main
struct LibraryBooksApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView(selectedMenu: "")
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
