//
//  NetworkManager.swift
//  Launches
//
//  Created by Simon Goldring on 7/8/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    let cache = NSCache<NSString, UIImage>()
    
    func getLaunches(completed: @escaping (Result<[Launch],NetworkError>) -> Void) {
        let url = URL(string: "https://api.spacexdata.com/v4/launches")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
            return
        }
        task.resume()
    }
}
