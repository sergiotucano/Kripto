//
//  SettingsView.swift
//  Kripto
//
//  Created by Sergio Clemente on 19/09/25.
//


import SwiftUI

struct SettingsView: View {
    @StateObject private var settings = AppSettings()

    var body: some View {
        Form {
            Section(header: Text("Comprimento")) {
                Stepper(value: $settings.length, in: 4...32) {
                    Text("Tamanho: \(settings.length)")
                }
            }

            Section(header: Text("Opções")) {
                Toggle("Números", isOn: $settings.useNumbers)
                Toggle("Letras", isOn: $settings.useLetters)
                Toggle("Maiúsculas", isOn: $settings.useUppercase)
                Toggle("Minúsculas", isOn: $settings.useLowercase)
                Toggle("Especiais", isOn: $settings.useSpecials)
            }
        }
    }
}
