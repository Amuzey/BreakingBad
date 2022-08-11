//
//  NetworkManager.swift
//  BreakingBad
//
//  Created by Алексей on 11.08.2022.
//

import Foundation

let charactersUrl = "https://www.breakingbadapi.com/api/characters"

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacters(from url: String?, complition: @escaping(Result<[Character], NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            complition(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                complition(.failure(.noData))
                return
            }
            do {
               let character = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    complition(.success(character))
                }
            } catch {
                complition(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, complition: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            complition(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                complition(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                complition(.success(imageData))
            }
        }
    }
}
