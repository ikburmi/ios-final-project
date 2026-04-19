//
//  SecretsDecoder.swift
//  final-project
//
//  Created by Ikroop Burmi on 4/16/26.
//

import Foundation

enum Secrets{
    static var apiKey: String {
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("API_KEY not found in Info.plist")
        }
        return key
    }
}
