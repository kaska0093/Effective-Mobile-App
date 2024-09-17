//
//  NetworkManager.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import Foundation

class NetworkManager: NetworkManagerInputProtocol {
    

    func fetchData() async throws -> TaskResultsFromNetwork {
        
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            throw NeworkingURLError.badURL
        }
        
        let responce = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(TaskResultsFromNetwork.self, from: responce.0)
        return result
    }
    
    func fetchDataComplition(complition: @escaping (Result<TaskResultsFromNetwork, Error>) -> Void) {
        
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            complition(.failure(NeworkingURLError.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                if let error {
                    complition(.failure(error))
                }
                return
            }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                        let taskData = try decoder.decode(TaskResultsFromNetwork.self, from: data)
                        complition(.success(taskData))
                } catch {
                    complition(.failure(NeworkingURLError.invalidURL))
                }
        }.resume()
    }
}

enum NeworkingURLError: Error {
    case badURL
    case badRequest
    case badResponse
    case invalidURL
}
