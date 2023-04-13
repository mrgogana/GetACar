//
//  String+PriceTests.swift
//  GetACarTests
//
//  Created by Navpreet Gogana on 2023-04-12.
//

import XCTest
@testable import GetACar

final class String_PriceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPriceString() throws {
        
        let keyExpected = "expected"
        let keyInput = "input"
        
        let testData = [[keyExpected: "Price: 120K", keyInput: 120000.0],
                        [keyExpected: "Price: 6K", keyInput: 6000.0],
                        [keyExpected: "Price: 300.0", keyInput: 300.0],
                        [keyExpected: "Price: 2M", keyInput: 2000000.0]]
        
        for testObj in testData {
            guard let input = testObj[keyInput] as? Double, let expected = testObj[keyExpected] as? String else { return }
            let output = String.priceString(price: input)
            XCTAssertEqual(output, expected)
        }
    }


}
