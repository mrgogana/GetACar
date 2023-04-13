//
//  GetACarTests.swift
//  GetACarTests
//
//  Created by Navpreet Gogana on 2023-04-10.
//

import XCTest
@testable import GetACar

final class GetACarTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataStorage() throws {
        
        let testData = ["test1", "test2", "test3", "test4"]
        
        let storageService: DataStorageService = UserDataStorage()
        
        for testObj in testData {
            guard let testData = testObj.data(using: .utf8) else { return }
            storageService.storeCarList(jsonData: testData)
            guard let outputData = storageService.getStoreCarList(), let output = String(data: outputData, encoding: .utf8) else { return }
            XCTAssertEqual(output, testObj)
        }
    }

}
