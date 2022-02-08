//
//  SchoolTests.swift
//  LearningToTestSwift
//
//  Created by Juan Manuel Gentili on 07/02/2022.
//

import XCTest
@testable import LearningToTestSwift

class SchoolTests: XCTestCase {
    
    // Mock students
    private let student1 = Student(name: "#1", grades: [2.0, 3.5, 4.0])
    private let student2 = Student(name: "#2", grades: [4.0, 4.0, 4.0])
    private let student3 = Student(name: "#3", grades: [1.0, 1.5])
    private let student4 = Student(name: "#4", grades: [])
    private let student5 = Student(name: "#5", grades: [4.0, 4.0, 4.0])
    
    // MARK: - topStudents (computed variable)
    
    /// Scenario with no students at all
    func testTopStudentsWithNoStudents() {
        let school = School(students: [])
        
        XCTAssertTrue(school.topStudents.isEmpty)
    }
    
    /// Scenario with no top students
    func testTopStudentsWithNoTopStudents() {
        let school = School(students: [student1, student3, student4])
        
        XCTAssertTrue(school.topStudents.isEmpty)
    }
    
    /// Scenario with two top students (#2 and #5)
    func testTopStudentsWithTwoTopStudents() {
        let school = School(students: [student1, student2, student3, student4, student5])
        let topStudents = school.topStudents
        
        XCTAssertFalse(topStudents.isEmpty)
        XCTAssertEqual(topStudents.count, 2)
        XCTAssertEqual(topStudents.first?.name, "#2")
        XCTAssertEqual(topStudents.last?.name, "#5")
    }
    
    /// Scenario with one top student (#2)
    func testTopStudentsWithOneTopStudent() {
        let school = School(students: [student1, student2, student3, student4])
        let topStudents = school.topStudents
        
        XCTAssertFalse(topStudents.isEmpty)
        XCTAssertEqual(topStudents.count, 1)
        XCTAssertEqual(topStudents.first?.name, "#2")
    }
    
    // MARK: - retrieveAlumni(_:)
        
    /// Retrieving the alumni should fetch the two alumni for the school.
    func testRetrieveAlumni() {
        let school = School(students: [])
        var result: Result<[Student], NetworkError>?
        
        // Create the expectation.
        let expectation = self.expectation(description: "Waiting for the retrieveAlumni call to complete.")
        
        // Perform the async call.
        
        school.retrieveAlumni { response in
            // Save the response
            result = response
            
            // Fullfil the expectation
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            switch result {
            case .success(let alumni):
                XCTAssertEqual(alumni.count, 2)
            case .failure, .none:
                XCTFail()
            }
        }
    }
    
    /// For the inverted test, we still manually fulfill the expectation,
    /// but because it is inverted, we do not expect it to be fulfilled.
    func testRetrieveAlumniNoFailure() {
        let school = School(students: [])
        
        // Create expectation
        let expectation = self.expectation(description: "Expecting the retrieveAlumni call not to fail.")
        expectation.isInverted = true
        
        school.retrieveAlumni { _ in
            // Nothing.
        } failure: { _ in
            expectation.fulfill()
        }
        
        // Wait for expectations for a maximum of 2 seconds.
        
        /// `waitForExpectations` call will meet its timeout and when it does, the test completes. For the same reason, testing with inverted
        /// expectations may significantly slow down your unit test suite, as each test with an inverted expectation has to wait for the
        /// timeout to complete.
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testDoSomethingAsynhronous() {
        let school = School(students: [])
        
        // Create our test queue
        let queue = DispatchQueue(label: "test-queue")
        
        // didComplete is initially false.
        XCTAssertFalse(school.didComplete)
        
        // Inject our test queue.
        school.doSomethingAsynchronous(queue: queue)
        // Synchronize the queue to wait for it to complete.
        queue.sync {
            // Do nothing, just synchronize.
        }
        
        // didComplete should now be true.
        XCTAssertTrue(school.didComplete)
    }

}

