//
//  ConcertService.swift
//  final-project
//
//  Created by Ikroop Burmi on 4/19/26.
//
import Foundation

class ConcertService{
    static func searchSetlists(artistName: String) async throws -> [Setlist] {
        let query = artistName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://api.setlist.fm/rest/1.0/search/setlists?artistName=\(query)")!
        
        do{
            var request = URLRequest(url: url)
            request.setValue(Secrets.apiKey, forHTTPHeaderField: "x-api-key")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
                    
            let (data, _) = try await URLSession.shared.data(for: request)
                    
            let response = try JSONDecoder().decode(Welcome.self, from: data)
            return response.setlist

        }catch let error as DecodingError {
            switch error {
            case .typeMismatch(_, let context):
                print(context.debugDescription)
            case .valueNotFound(_, let context):
                print(context.debugDescription)
            case .keyNotFound(_, let context):
                print(context.debugDescription)
            case .dataCorrupted(let context):
                print(context.debugDescription)
            @unknown default:
                print(error.localizedDescription)
            }
            throw error
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }    
}
