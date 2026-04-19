//
//  Welcome.swift
//  final-project
//
//  Created by Ikroop Burmi on 4/19/26.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let type: String
    let itemsPerPage, page, total: Int
    let setlist: [Setlist]
}

// MARK: - Setlist
struct Setlist: Codable, Identifiable{
    let id, versionID, eventDate, lastUpdated: String
    let artist: Artist
    let venue: Venue
    let sets: Sets
    let url: String
    let info: String?
    let tour: Tour?

    enum CodingKeys: String, CodingKey {
        case id
        case versionID = "versionId"
        case eventDate, lastUpdated, artist, venue, sets, url, info, tour
    }
}

// MARK: - Artist
struct Artist: Codable {
    let mbid: String
    let name: String
    let sortName: String
    let disambiguation: String
    let url: String
}

/*enum Disambiguation: String, Codable {
    case danishEuroDanceGroup = "Danish Euro‐dance group"
    case empty = ""
    case queenOfPop = "“Queen of Pop”"
}

enum ArtistName: String, Codable {
    case aqua = "Aqua"
    case dianaRoss = "Diana Ross"
    case koolTheGang = "Kool & the Gang"
    case madonna = "Madonna"
    case sabrinaCarpenter = "Sabrina Carpenter"
}

enum SortName: String, Codable {
    case aqua = "Aqua"
    case carpenterSabrina = "Carpenter, Sabrina"
    case koolTheGang = "Kool & the Gang"
    case madonna = "Madonna"
    case rossDiana = "Ross, Diana"
}*/

// MARK: - Sets
struct Sets: Codable {
    let setsSet: [Set]

    enum CodingKeys: String, CodingKey {
        case setsSet = "set"
    }
}

// MARK: - Set
struct Set: Codable {
    let name: String?
    let song: [Song]
    let encore: Int?
}

// MARK: - Song
struct Song: Codable {
    let name: String
    let tape: Bool?
    let info: String?
    let cover, with: Artist?
}

// MARK: - Tour
struct Tour: Codable {
    let name: String
}

/*enum TourName: String, Codable {
    case shortNSweetTour = "Short n' Sweet Tour"
}*/

// MARK: - Venue
struct Venue: Codable {
    let id, name: String
    let city: City
    let url: String
}

// MARK: - City
struct City: Codable {
    let id, name, state, stateCode: String
    let coords: Coords
    let country: Country
}

// MARK: - Coords
struct Coords: Codable {
    let lat, long: Double
}

// MARK: - Country
struct Country: Codable {
    let code, name: String
}
