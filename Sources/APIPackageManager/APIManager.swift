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
    public func getData<T:Decodable>(from url: URL, type:[T].Type)-> AnyPublisher<[T], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [T].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
