//
//  File.swift
//  APIPackageManager
//
//  Created by Reddanna Kotte on 06/10/25.
//

import Foundation
import Combine
import SwiftUI

public struct APIManager {
    
    public init() {
    }
    
    public func getData<T: Decodable>(from url: URL, type:[T].Type)-> AnyPublisher<[T], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [T].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public func asyncDownload<T: Decodable>(from url: URL, type:[T].Type) async throws
                                                        -> ([T]?, Error?) {
       
        do {
            let (responseData, response) = try await URLSession.shared.data(from: url)
            guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
               throw URLError(.badURL)
            }
            let json = try JSONDecoder().decode([T].self, from: responseData)
            return (json, nil)
            
        }catch {
            print("Error: \(error)")
        }
         return (nil, nil)
    }
}
