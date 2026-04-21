//
//  ConcertRating.swift
//  final-project
//
//  Created by Ikroop Burmi on 4/19/26.
//

import SwiftData
import Foundation

@Model
class ConcertRating {
    var artistName: String
    var tourName: String
    var vocalRating: Double
    var setlistRating: Double
    var venueRating: Double
    var visualProdRating: Double
    var desc: String
    var dateAdded: Date
    
    var overallRating: Double {
        (vocalRating + setlistRating + venueRating + visualProdRating) / 4.0
    }
    
    init(artistName: String, tourName: String, vocalRating: Double, setlistRating: Double, venueRating: Double, visualProdRating: Double, desc: String) {
        self.artistName = artistName
        self.tourName = tourName
        self.vocalRating = vocalRating
        self.setlistRating = setlistRating
        self.venueRating = venueRating
        self.visualProdRating = visualProdRating
        self.desc = desc
        self.dateAdded = .now
    }
}
