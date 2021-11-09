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
        let result = sut.save(data: testData, to: path)
        XCTAssertTrue(result)
    }

    func testUnsavedFile_isNotFound() {
        let path = "unsaved-file"
        XCTAssertFalse(sut.isFilePersisted(at: path))
    }

    func testDeletedValidFile_returnsTrue() {
        let path = "delete-file"
        let saved = sut.save(data: testData, to: path)
        XCTAssertTrue(saved)
        let deleted = sut.delete(at: path)
        XCTAssertTrue(deleted)
    }

    func testDeletedInvalidFile_returnsFalse() {
        let path = "deleted-invalid-file"
        let deleted = sut.delete(at: path)
        XCTAssertFalse(deleted)
    }

    func testValidFile_isRetrieved() {
        let path = "saved-file"
        let data = "saved-data".data(using: .utf8)!

        let result = sut.save(data: data, to: path)
        XCTAssertTrue(result)

        let returnedData = sut.load(from: path)
        XCTAssertEqual(testData, returnedData)
    }

    func testInvalidFile_isNotRetrieved() {
        let path = "invalid-file-path"
        let result = sut.load(from: path)
        XCTAssertNil(result)
    }

    private var sut: LocalPersistenceController {
        .init()
    }

    private var testData: Data {
        "test".data(using: .utf8)!
    }

}
