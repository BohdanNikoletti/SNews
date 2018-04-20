//
//  SNewsUITests.swift
//  SNewsUITests
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import XCTest

final class SNewsUITests: XCTestCase {
  
  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testExample() {
    app.launch()
    let newsTable = app.tables["newsTable"]
    let exists = NSPredicate(format: "exists == 1")
    
    expectation(for: exists, evaluatedWith: newsTable, handler: nil)
    waitForExpectations(timeout: 3, handler: nil)
    
    XCTAssertTrue(newsTable.exists)
    newsTable.cells.element(boundBy:0).tap()
    XCTAssertTrue(app.otherElements["newsDetail"].exists)
  }
  
}
