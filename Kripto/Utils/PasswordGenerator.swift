//
//  PasswordGenerator.swift
//  Kripto
//
//  Created by Sergio Clemente on 19/09/25.
//


import Foundation

struct PasswordGenerator {
    static func generate(settings: AppSettings) -> String {
        var chars = ""
        if settings.useNumbers { chars += "0123456789" }
        if settings.useLetters {
            if settings.useUppercase { chars += "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
            if settings.useLowercase { chars += "abcdefghijklmnopqrstuvwxyz" }
        }
        if settings.useSpecials { chars += "!@#$%^&*()_-+=[]{}|:;,.<>?/" }

        return String((0..<settings.length).compactMap { _ in chars.randomElement() })
    }
}
