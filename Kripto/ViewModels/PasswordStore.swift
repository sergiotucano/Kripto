//
//  PasswordStore.swift
//  Kripto
//
//  Created by Sergio Clemente on 19/09/25.
//


import Foundation
import LocalAuthentication
import Combine


class PasswordStore: ObservableObject {
    @Published var passwords: [PasswordItem] = []
    @Published var lastGeneratedPassword: String? = nil

    private let keychain = KeychainHelper()
    private let key = "kripto_passwords"

    init() {
        loadPasswords()
    }

    func generatePassword(settings: AppSettings = AppSettings()) {
        lastGeneratedPassword = PasswordGenerator.generate(settings: settings)
    }

    func savePassword(description: String) {
        guard let pwd = lastGeneratedPassword else { return }
        let item = PasswordItem(id: UUID(), description: description, value: pwd, createdAt: Date())
        passwords.append(item)
        persistPasswords()
    }

    func deletePassword(_ item: PasswordItem) {
        passwords.removeAll { $0.id == item.id }
        persistPasswords()
    }

    func authenticate(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Acesse suas senhas") { success, _ in
                DispatchQueue.main.async { completion(success) }
            }
        } else {
            completion(false)
        }
    }

    private func persistPasswords() {
        if let data = try? JSONEncoder().encode(passwords) {
            keychain.save(data, service: key, account: "user")
        }
    }

    private func loadPasswords() {
        if let data = keychain.read(service: key, account: "user"),
           let items = try? JSONDecoder().decode([PasswordItem].self, from: data) {
            passwords = items
        }
    }
}
