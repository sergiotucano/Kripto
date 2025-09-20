//
//  PasswordItem.swift
//  Kripto
//
//  Created by Sergio Clemente on 19/09/25.
//


import Foundation

struct PasswordItem: Identifiable, Codable {
    let id: UUID
    let description: String
    let value: String
    let createdAt: Date
}
