//
//  LocalPersistenceController.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/9/21.
//

import Foundation

class LocalPersistenceController {
    func isFilePersisted(at path: String) -> Bool {
        let filePath = userDocumentPath(path)
        return FileManager.default.fileExists(atPath: filePath.path)
    }

    func save(data: Data, to path: String) -> Bool {
        do {
            let filePath = userDocumentPath(path)
            createDirectory(at: filePath)

            try data.write(to: filePath)
        } catch {
            print("error saving file to \(path): \(error)")
        }

        return isFilePersisted(at: path)
    }

    func load(from path: String) -> Data? {
        let filepath = userDocumentPath(path)
        return try? Data(contentsOf: filepath)
    }

    func delete(at path: String) -> Bool {
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print("Error deleting file: \(error.localizedDescription)")
        }
        return isFilePersisted(at: path)
    }

    func userDocumentPath(_ path: String) -> URL {
        FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask)[0].appendingPathComponent(path, isDirectory: true)
    }

    private func createDirectory(at path: URL) {
        if !FileManager.default.fileExists(atPath: path.absoluteString) {
            do {
                try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error creating directory: \(error.localizedDescription)")
            }
        }
    }
}
