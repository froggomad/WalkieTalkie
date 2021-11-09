//
//  LocalPersistenceController.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/9/21.
//

import Foundation

class LocalPersistenceController {
    func isFilePersisted(at path: String) -> Bool {
        let filePath = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask)[0].appendingPathComponent(path)
        return FileManager.default.fileExists(atPath: filePath.path)
    }

    func save(data: Data, to path: String) -> Bool {
        do {
            let path = FileManager.default.urls(for: .documentDirectory,
                                                   in: .userDomainMask)[0].appendingPathComponent(path)
            try data.write(to: path)
        } catch {
            print("error saving file to \(path): \(error)")
        }
        return isFilePersisted(at: path)
    }

    func load(from path: String) {

    }

    func delete(at path: String) -> Bool {
        try? FileManager.default.removeItem(atPath: path)
        return isFilePersisted(at: path)
    }
}
