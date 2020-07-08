//
//  NetworkManager.swift
//  Launches
//
//  Created by Simon Goldring on 7/8/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func getLaunches(completed: @escaping (Result<[Launch],NetworkError>) -> Void) {
        let url = URL(string: "https://api.spacexdata.com/v4/launches")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let self = self else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let launches = try? decoder.decode([Launch].self, from: data) {
                completed(.success(launches))
            } else {
                completed(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
