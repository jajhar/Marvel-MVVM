//
//  ComicPageUITests.swift
//  MarvelUITests
//
//  Created by Julia Ajhar on 2/12/24.
//

import XCTest

final class ComicPageUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_comicPage_loads() throws {
        let app = XCUIApplication()
        app.launch()
        
        let page = ComicPage(app: app)
        XCTAssert(page.comicTitle.waitForExistence(timeout: 10))
        XCTAssert(page.comicDescription.waitForExistence(timeout: 10))
    }
}

class Page {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
}

class ComicPage: Page {
    var comicTitle: XCUIElement {
        app.staticTexts["comicTitle"]
    }
    
    var comicDescription: XCUIElement {
        app.staticTexts["comicDescription"]
    }
}
