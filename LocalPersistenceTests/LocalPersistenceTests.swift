//
//  LocalPersistenceTests.swift
//  LocalPersistenceTests
//
//  Created by Kenneth Dubroff on 11/9/21.
//

import XCTest
@testable import WalkieTalkie

class LocalPersistenceTests: XCTestCase {

    func testSavedFile_isFound() {
        let path = "example-file"
        let result = sut.save(data: "test".data(using: .utf8)!, to: path)
        XCTAssertTrue(result)
    }

    func testUnsavedFile_isNotFound() {
        let path = "unsaved-file"
        XCTAssertFalse(sut.isFilePersisted(at: path))
    }

    private var sut: LocalPersistenceController {
        .init()
    }

}
