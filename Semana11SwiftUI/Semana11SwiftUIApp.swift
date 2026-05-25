//
//  Semana11SwiftUIApp.swift
//  Semana11SwiftUI
//
//  Created by Rafael Diego Chuco Yantas on 25/05/26.
//

import SwiftUI
import SwiftData

@main
struct Semana11SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Alumno.self])
    }
}
