//
//  SmallWorldTest_UIKitTests.swift
//  SmallWorldTest_UIKitTests
//
//  Created by Sabih Haris on 10/12/2023.
//

import XCTest
@testable import SmallWorldTest_UIKit

final class SmallWorldTest_UIKitTests: XCTestCase {

    let moviesResources = MoviesResources()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testMovies_CheckNil() {
        var results = [MovieResult]();
        moviesResources.getMovies { response in
            results = response?.results ?? []
            XCTAssertNil(results)
        }
    }
    
    func testMovies_CheckTitleIsNotNil() {
        var results = [MovieResult]();
        moviesResources.getMovies { response in
            results = response?.results ?? []
            
            for i in results {
                XCTAssertNil(i.originalTitle)
                XCTAssertTrue(i.originalTitle!.count > 0)
            }
        }
    }
    
    func testMovies_CheckIdIsNotNil() {
        var results = [MovieResult]();
        moviesResources.getMovies { response in
            results = response?.results ?? []
            
            for i in results {
                XCTAssertNil(i.id)
            }
        }
    }

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

}
