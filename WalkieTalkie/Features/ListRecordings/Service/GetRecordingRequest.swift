//
//  GetRecordingRequest.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

struct GetRecordingRequest: Requestable {
    let path: String = "/history"
    
    let requestType: RequestType = .GET    
}
