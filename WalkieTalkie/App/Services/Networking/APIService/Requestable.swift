//
//  RequestProtocol.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case badRequest
    case badDecode(Error)
    case badResponse(statusCode: Int?)
    case noData
    case error(Error)
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
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
        components.scheme = "http"
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
