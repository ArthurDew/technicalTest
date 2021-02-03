//
//  JsonModel.swift
//  LydiaTest
//
//  Created by Arthur de Wurstemberger on 29/01/2021.
//

import Foundation

// MARK: - Data
struct Data: Decodable {
    let results: [Result]
    let info: Info
}

// MARK: - Info
struct Info: Decodable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct Result: Decodable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

// MARK: - Dob
struct Dob: Decodable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Decodable {
    let name: String
    let value: String?
}

// MARK: - Location
struct Location: Decodable {
    let street: Street
    let city, state, country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

enum Postcode: Decodable {
    init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
        do {
          self = try .integer(container.decode(Int.self))
        } catch DecodingError.typeMismatch {
          do {
            self = try .string(container.decode(String.self))
          }
        }
    }
    
    case integer(Int)
    case string(String)
}

// MARK: - Coordinates
struct Coordinates: Decodable {
    let latitude, longitude: String
}

// MARK: - Street
struct Street: Decodable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Decodable {
    let offset, description: String
}

// MARK: - Login
struct Login: Decodable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - Name
struct Name: Decodable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Decodable {
    let large, medium, thumbnail: String
}
