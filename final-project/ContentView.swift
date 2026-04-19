//
//  ContentView.swift
//  final-project
//
//  Created by Ikroop Burmi on 4/16/26.
//

import SwiftUI

struct ContentView: View {
    @State var setlists: [Setlist]?
    @State var artistName: String = ""
    let service = ConcertService()
    var body: some View {
        VStack{
            NavigationStack{
                TextField("Artist Name", text: $artistName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit{
                        Task{
                            do {
                                let response = try await service.searchSetlists(artistName: artistName)
                                setlists = response
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
            }
            .frame(width: 400, height: 50, alignment: .center)
                    
            if let setlists {
                List(setlists) { setlist in
                    Text(setlist.tour?.name ?? "No Tour")
                }
            } else {
                Text("Setlist Not Available")
                .font(.title2)
                .foregroundStyle(.secondary)
                .bold()
            }
        }
    }
}

#Preview {
    ContentView()
}
