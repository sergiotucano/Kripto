//
//  AppSettings.swift
//  Kripto
//
//  Created by Sergio Clemente on 19/09/25.
//


import SwiftUI
import Combine

class AppSettings: ObservableObject {
    @EnvironmentObject var settings: AppSettings

    @AppStorage("length") var length: Int = 12
    @AppStorage("useNumbers") var useNumbers: Bool = true
    @AppStorage("useLetters") var useLetters: Bool = true
    @AppStorage("useSpecials") var useSpecials: Bool = true
    @AppStorage("useUppercase") var useUppercase: Bool = true
    @AppStorage("useLowercase") var useLowercase: Bool = true
}
