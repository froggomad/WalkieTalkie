//
//  Data Parser.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

class DataParser: DataParsable {
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder = jsonDecoder
    }
    
    func parse<T: Decodable>(data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
