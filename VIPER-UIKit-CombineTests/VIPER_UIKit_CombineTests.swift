//
//  VIPER_UIKit_CombineTests.swift
//  VIPER-UIKit-CombineTests
//
//  Created by Markel Juaristi on 27/5/23.
//

import XCTest
@testable import VIPER_UIKit_Combine

final class VIPER_UIKit_CombineTests: XCTestCase {

    var imageLoader: ImageLoader!
    var imageView: UIImageView!
    
    let heroData: Data = """
    {
        "id": 1,
        "name": "Test Hero",
        "description": "Test Description",
        "thumbnail": {
            "path": "https://test.com",
            "extension": "jpg"
        }
    }
    """.data(using: .utf8)!

    let serieData: Data = """
    {
        "id": 1,
        "title": "Test Serie",
        "description": "Test Description",
        "thumbnail": {
            "path": "https://test.com",
            "extension": "jpg"
        }
    }
    """.data(using: .utf8)!

    override func setUpWithError() throws {
        try super.setUpWithError()
        imageLoader = ImageLoader()
        imageView = UIImageView()
    }

    override func tearDownWithError() throws {
        imageLoader = nil
        imageView = nil
        try super.tearDownWithError()
    }

    func testHeroModel() throws {
        let decoder = JSONDecoder()
        do {
            let hero = try decoder.decode(Hero.self, from: heroData)
            XCTAssertEqual(hero.id, 1)
            XCTAssertEqual(hero.name, "Test Hero")
            XCTAssertEqual(hero.description, "Test Description")
            XCTAssertEqual(hero.thumbnail.path, "https://test.com")
            XCTAssertEqual(hero.thumbnail.thumbnailExtension, "jpg")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

    func testSerieModel() throws {
        let decoder = JSONDecoder()
        do {
            let serie = try decoder.decode(Serie.self, from: serieData)
            XCTAssertEqual(serie.id, 1)
            XCTAssertEqual(serie.title, "Test Serie")
            XCTAssertNil(serie.description)
            XCTAssertEqual(serie.thumbnail.path, "https://test.com")
            XCTAssertEqual(serie.thumbnail.thumbnailExtension, "jpg")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

    func testValidImageLoading() throws {
        let imageLoadingExpectation = expectation(description: "Image loading should succeed")
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
        guard let imageURL = URL(string: "http://invalid-url.com") else {
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

