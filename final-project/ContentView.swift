//
//  ContentView.swift
//  final-project
//
//  Created by Ikroop Burmi on 4/16/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View{
        NavigationStack{
            ZStack{
                Color("Blue-bg")
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Welcome to ")
                        Image("Encore_Text")
                            .resizable()
                            .frame(width: 100, height: 80)
                        Text("!")
                    }
                    Text("1. Search for a concert using the artist's name. \n\n2. Add ratings and a description. \n\n3. View all past concerts on your profile.\n")
                        .padding(20)
                    
                    NavigationLink{
                        SearchView()
                    }label: {
                        Text("Let's begin!")
                        
                    }
                    Text(" ")
                    Text(" ")
                    
                }
                .font(.system(size:18, design: .monospaced))
            }
        }
    }
}
struct SearchView: View{
    @State var setlists: [Setlist]?
    @State var artistName: String = ""
    let service = ConcertService()
    var uniqueTours: [String] {
        guard let setlists else { return [] }
        let tourNames = setlists.compactMap { $0.tour?.name }
        return Array(Swift.Set(tourNames))
    }
    var body: some View {
        
        NavigationStack{
        ZStack{
            Color("Blue-bg")
                .ignoresSafeArea(edges: .all)
            
            VStack{
            
                TextField("Artist Name", text: $artistName)
                    .font(.system(size: 18, design: .monospaced))
                    .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 0.5)
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    .padding()
                    .onSubmit{
                        Task{
                            do {
                                let response = try await ConcertService.searchSetlists(artistName: artistName)
                                setlists = response
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                if setlists != nil {
                    List(uniqueTours, id: \.self) { tour in
                        NavigationLink{
                            ConcertDetailView(artistName: self.artistName, tourName: tour)
                        }label:{
                            Text(tour)
                            .font(.system(size: 18, design: .monospaced))
                        }
                        //.listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    List(){
                    }
                    .scrollContentBackground(.hidden)
                    
                }
                //Footer
                //Spacer()
                HStack{
                    NavigationLink{
                        ContentView()
                    }label: {
                        Image("Encore_Text")
                            .resizable()
                            .frame(width: 100, height: 80)
                    }
                    
                    
                    Spacer()
                    NavigationLink{
                        ProfileView()
                    }label:{
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color(.black))
                    }
                }
                .opacity(0.7)
                .padding(10)
            }
            .frame(maxWidth: 400, maxHeight: 800)
        }
    }
    }
}
struct ConcertDetailView: View {
    let service = ConcertService()
    @State var artistName: String
    @State var tourName: String
    @State var vocalRating: Double = 0.0
    @State var setlistRating: Double = 0.0
    @State var venueRating: Double = 0.0
    @State var visualProdRating: Double = 0.0
    @State var description: String = ""
    @State var saved: Bool = false

    @Environment(\.modelContext) var modelContext
    @Query var savedRatings: [ConcertRating]

    var overallRating: Double {
        (vocalRating + setlistRating + venueRating + visualProdRating) / 4.0
    }

    // Check if this tour is already saved
    var existingRating: ConcertRating? {
        savedRatings.first { $0.tourName == tourName && $0.artistName == artistName }
    }

    var body: some View {
        ZStack{
            Color("Blue-bg")
                .ignoresSafeArea(edges: .all)
            VStack {
                Text(tourName)
                    .font(.system(size: 35,design: .monospaced))
                    .fontWeight(.bold)
                Text(artistName)
                Spacer()
                Text("Rating")
                    .font(.system(size: 25,design: .monospaced))
                    .bold()
                
                HStack{
                    VStack{
                        Text("Vocals: \(vocalRating, specifier: "%.0f")")
                        Slider(value: $vocalRating, in: 0...10, step: 1.0).padding(20)
                    }
                    VStack{
                        Text("Setlist: \(setlistRating, specifier: "%.0f")")
                        Slider(value: $setlistRating, in: 0...10, step: 1.0).padding(20)
                    }
                    
                }
                .padding(20)
                HStack{
                    VStack{
                        Text("Venue: \(venueRating, specifier: "%.0f")")
                        Slider(value: $venueRating, in: 0...10, step: 1.0).padding(20)
                    }
                    VStack{
                        Text("Visual Production: \(visualProdRating, specifier: "%.0f")")
                        Slider(value: $visualProdRating, in: 0...10, step: 1.0).padding(20)
                    }
                }
                
                Text("Overall Rating: \(overallRating, specifier: "%.1f")")
                Spacer()
                
                Text("Description:")
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Save button
                Button(saved ? "Saved!" : "Save Rating") {
                    saveRating()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("Pink_bg"))
                .padding()
                Spacer()
            }
            .font(.system(size:18,design: .monospaced))
            .padding(20)
            .onAppear {
                // Pre-fill if already saved
                if let existing = existingRating {
                    vocalRating = existing.vocalRating
                    setlistRating = existing.setlistRating
                    venueRating = existing.venueRating
                    visualProdRating = existing.visualProdRating
                    description = existing.desc
                }
            }
        }
    }
    func saveRating() {
        if let existing = existingRating {
            // Update existing rating
            existing.vocalRating = vocalRating
            existing.setlistRating = setlistRating
            existing.venueRating = venueRating
            existing.visualProdRating = visualProdRating
            existing.desc = description
        } else {
            // Create new rating
            let rating = ConcertRating(
                artistName: artistName,
                tourName: tourName,
                vocalRating: vocalRating,
                setlistRating: setlistRating,
                venueRating: venueRating,
                visualProdRating: visualProdRating,
                desc: description
            )
            modelContext.insert(rating)
        }
        saved = true
    }
}
#Preview {
    ContentView()
}
