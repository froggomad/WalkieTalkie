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
        let url = URL(string: "example-file")!
        sut.save(url: url)
        XCTAssertTrue(sut.isFilePersisted(url: url))
    }

    private var sut: LocalPersistenceController {
        .init()
    }

}
