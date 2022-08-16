//
//  NetworkManager.swift
//  BreakingBad
//
//  Created by Алексей on 11.08.2022.
//

import Foundation
import Alamofire

let charactersUrl = "https://www.breakingbadapi.com/api/characters"

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacters(from url: String, completion: @escaping(Result<[Character], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let charaters = Character.getCharacters(from: value)
                    completion(.success(charaters))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataRequest in
                switch dataRequest.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
