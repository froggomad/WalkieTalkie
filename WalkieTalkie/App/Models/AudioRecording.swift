//
//  AudioRecording.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

struct AudioRecording: Codable, Identifiable, Equatable {
    let id: Int
    let usernameFrom: String?
    let usernameTo: String
    var timestamp: Date
    let recording: String
    
    var url: URL {
        return URL(string: "http://localhost:3000/recordings/example_transmission.mp3")!
    }
    
    init(id: Int, usernameFrom: String?, usernameTo: String, timestamp: Date, recording: String) {
        self.id = id
        self.usernameFrom = usernameFrom
        self.usernameTo = usernameTo
        self.timestamp = timestamp
        self.recording = recording
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        usernameFrom = try container.decodeIfPresent(String.self, forKey: .usernameFrom)
        usernameTo = try container.decode(String.self, forKey: .usernameTo)
        let timeString = try container.decode(String.self, forKey: .timestamp)
        let date = Date(timeIntervalSince1970: Double(timeString) ?? 0)
        timestamp = date
        recording = try container.decode(String.self, forKey: .recording)
    }
}

extension AudioRecording {
    static let previewRecording = AudioRecording(id: 0, usernameFrom: "Someone Else", usernameTo: "You", timestamp: Date(), recording: "example_transmission.mp3")
    static let mockData =
    """
    [{"id":1,"username_from":"farbrother0","timestamp":"1606314693","recording":"/recordings/example_transmission.mp3","username_to":"kyle_ski"},
    {"id":2,"username_from":"cleadstone1","timestamp":"1622161046","recording":"/recordings/example_transmission.mp3","username_to":"dev_skier"},
    {"id":3,"username_from":"vantwis2","timestamp":"1615387670","recording":"/recordings/example_transmission.mp3","username_to":"dev_skier"},
    {"id":4,"username_from":"blackader3","timestamp":"1624820784","recording":"/recordings/example_transmission.mp3","username_to":"kyle_ski"},
    {"id":5,"username_from":"mirams4","timestamp":"1598303164","recording":"/recordings/example_transmission.mp3","username_to":"kyle_ski"},
    {"id":6,"username_from":"milazzo5","timestamp":"1573953999","recording":"/recordings/example_transmission.mp3","username_to":"kyle_ski"},
    {"id":7,"username_from":"carrol6","timestamp":"1577643368","recording":"/recordings/example_transmission.mp3","username_to":"kyle_ski"},
    {"id":8,"username_from":"oduggan7","timestamp":"1585917178","recording":"/recordings/example_transmission.mp3","username_to":"kyle_ski"},
    {"id":9,"username_from":"eshepherdson8","timestamp":"1598809380","recording":"/recordings/example_transmission.mp3","username_to":"dev_skier"},
    {"id":10,"username_from":null,"timestamp":"1583119110","recording":"/recordings/example_transmission.mp3","username_to":"dev_skier"}
    ]
    """.data(using: .utf8)!
}
