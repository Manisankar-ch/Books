//
//  BooksUITests.swift
//  BooksUITests
//
//  Created by Softsuave-iOS dev on 07/02/25.
//

import XCTest

final class BooksUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
        let addTaskButton = app.buttons["Add_Book"]
        addTaskButton.tap()
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
      
        let addTaskNavBarTitle = app.staticTexts["New Book"]
        XCTAssertTrue(addTaskNavBarTitle.exists)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFieldValidation() {
        let titleTextField = app.textFields["Title"]
        let authorTextField = app.textFields["Author"]
        let createButtonView = app.buttons["Create"]
        XCTAssertFalse(createButtonView.isEnabled)
        
        titleTextField.tap()
        titleTextField.typeText("Book name")
        authorTextField.tap()
        authorTextField.typeText("Author")
        
        let screenshot = createButtonView.screenshot()
        let elementAttachment = XCTAttachment(screenshot: screenshot)
        elementAttachment.name = "Button Screenshot"
        elementAttachment.lifetime = .keepAlways
        add(elementAttachment)
        
        XCTAssertFalse(!createButtonView.isEnabled)
        createButtonView.tap()
        XCTAssertFalse(createButtonView.waitForExistence(timeout: 0.5))
    }
    

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
        }
    }
}
