//
//  NetworkManager.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    func fetchData() async throws -> TaskResults {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            throw NeworkingURLError.badURL
        }
        
        let responce = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(TaskResults.self, from: responce.0)
        return result
        
    }
}

enum NeworkingURLError: Error {
    case badURL
    case badRequest
    case badResponse
    case invalidURL
}
