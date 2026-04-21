//
//  ProfileView.swift
//  final-project
//
//  Created by Ikroop Burmi on 4/19/26.
//
import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query var savedRatings: [ConcertRating]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack {
            ZStack{
                Color("Blue-bg")
                    .ignoresSafeArea()
                VStack{
                    if savedRatings.isEmpty {
                        Text("No ratings saved yet")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .bold()
                    } else {
                        List {
                            ForEach(savedRatings) { rating in
                                RatingRowView(rating: rating)
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    let rating = savedRatings[index]
                                    modelContext.delete(rating)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("My Ratings")
    }
}
struct RatingRowView: View {
    let rating: ConcertRating
    var body: some View {
        VStack(alignment: .leading) {
            Text(rating.tourName).font(.system(size:20)).bold()
            Text(rating.artistName).foregroundStyle(.secondary)
            Text("Overall: \(rating.overallRating, specifier: "%.1f") / 10")
            if !rating.desc.isEmpty {
                Text(rating.desc).foregroundStyle(.secondary)
            }
        }
        .font(.system(size: 18, design: .monospaced))
    }
}
