//
//  VIPER_UIKit_CombineTests.swift
//  VIPER-UIKit-CombineTests
//
//  Created by Markel Juaristi on 27/5/23.
//

import XCTest
@testable import VIPER_UIKit_Combine

final class VIPER_UIKit_CombineTests: XCTestCase {
    /*
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
*/
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    ///TESTING IMAGELOADER:
    var imageLoader: ImageLoader!
    var imageView: UIImageView!

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        imageLoader = nil
        imageView = nil
        try super.tearDownWithError()
    }

    func testValidImageLoading() throws {
        let imageLoadingExpectation = expectation(description: "Image loading should succeed")
        // Replace this URL with a valid URL that actually returns an image
        guard let imageURL = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/10/50febd76d20e2") else {
            XCTFail("Invalid image URL")
            return
        }

        imageLoader.loadImage(from: imageURL, into: imageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            if self.imageView.image != self.imageLoader.defaultImage {
                imageLoadingExpectation.fulfill()
            } else {
                XCTFail("Image loading failed")
            }
        }

        waitForExpectations(timeout: 10.0)
    }

    func testInvalidImageLoading() throws {
        let imageLoadingExpectation = expectation(description: "Image loading should fail")
        guard let imageURL = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/10/50febd76d20e2") else {
            XCTFail("Invalid image URL")
            return
        }

        imageLoader.loadImage(from: imageURL, into: imageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            if self.imageView.image == self.imageLoader.defaultImage {
                imageLoadingExpectation.fulfill()
            } else {
                XCTFail("Default image should be loaded for invalid URLs")
            }
        }

        waitForExpectations(timeout: 10.0)
    }

}
