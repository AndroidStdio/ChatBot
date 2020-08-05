//
//  NetworkManager.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import Foundation


final class NetworkManager {
    
    // Making the network manager a singleton, cause its considered bad practice to have multiple object lifecycles of the network manager.
    private init() {}
    static let shared = NetworkManager()
    
    // simple get method, takes in a request , gives data or error
    func get(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(data))
            }
        })
        task.resume()
    }
    
    //builds the request based on endpoint, with optional payload parameter for put only
    func buildRequest(url: URL, endpoint: Endpoint, payload: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch endpoint {
        case .chat:
            request.httpMethod = HttpMethod.get.rawValue
        }
        return request
    }
    
}
