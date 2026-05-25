//
//  Semana11SwiftUIApp.swift
//  Semana11SwiftUI
//
//  Created by Rafael Diego Chuco Yantas on 25/05/26.
//

import SwiftUI
import CoreData

@main
struct Semana11SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
