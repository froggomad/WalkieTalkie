//
//  LocalPersistenceTests.swift
//  LocalPersistenceTests
//
//  Created by Kenneth Dubroff on 11/9/21.
//

import XCTest
@testable import WalkieTalkie

class LocalPersistenceTests: XCTestCase {

    func testSavedFile_returnsTrue() {
        let path = "example-file"
        sut.save(data: "test".data(using: .utf8)!, to: path)
        XCTAssertTrue(sut.isFilePersisted(at: path))
    }

    func testUnsavedFile_returnsFalse() {
        let path = "unsaved-file"
        XCTAssertFalse(sut.isFilePersisted(at: path))
    }

    private var sut: LocalPersistenceController {
        .init()
    }

}
