//
//  APIManageable.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

protocol APIManageable {
    func initRequest(with data: Requestable, completion: @escaping (Result<Data, NetworkError>) -> ())
}
