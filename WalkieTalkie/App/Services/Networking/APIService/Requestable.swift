//
//  RequestProtocol.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badRequest
    case badResponse(statusCode: Int?)
    case noData
    case error(Error)
}

protocol Requestable {
    var path: String { get }
    var requestType: RequestType { get }
}

extension Requestable {
    
    var host: String {
        APIConstants.host
    }
    
    func walkieTalkieURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.port = APIConstants.port
        
        guard let url = components.url else { throw  NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
}
