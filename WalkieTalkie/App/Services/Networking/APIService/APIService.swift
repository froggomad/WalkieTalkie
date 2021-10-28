//
//  APIService.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

class APIService: APIManageable {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func processRequest(with requestable: Requestable, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        guard let request = try? requestable.walkieTalkieURLRequest() else {
            completion(.failure(.badRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.error(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.badResponse(statusCode: nil)))
                return
            }
            
            let statusCode = response.statusCode
            guard statusCode == 200 else {
                completion(.failure(.badResponse(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}

class MockAPIService: APIManageable {
    func processRequest(with data: Requestable, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        completion(.success(AudioRecording.mockData))
    }
}
