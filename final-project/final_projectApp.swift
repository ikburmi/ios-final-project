//
//  final_projectApp.swift
//  final-project
//
//  Created by Ikroop Burmi on 4/16/26.
//

import SwiftUI
import SwiftData

@main
struct final_projectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ConcertRating.self)
    }
}
