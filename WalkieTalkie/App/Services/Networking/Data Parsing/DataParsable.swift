//
//  DataParsable.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

protocol DataParsable {
    func parse<T: Decodable>(data: Data) throws -> T
}
