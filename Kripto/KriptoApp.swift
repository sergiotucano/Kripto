//
//  KriptoApp.swift
//  Kripto
//
//  Created by Sergio Clemente on 19/09/25.
//

import SwiftUI

@main
struct KriptoApp: App {
    @StateObject private var store = PasswordStore()
    @StateObject private var settings = AppSettings() // <-- aqui

    var body: some Scene {
        WindowGroup {
            TabView {
                GenerateView()
                    .tabItem { Label("Gerar", systemImage: "key.fill") }

                SavedListView()
                    .tabItem { Label("Senhas", systemImage: "lock.shield") }

                SettingsView()
                    .tabItem { Label("Config", systemImage: "gear") }
            }
            .environmentObject(store)
            .environmentObject(settings) // <-- passar settings
        }
    }
}

