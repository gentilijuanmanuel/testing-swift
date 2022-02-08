//
//  LoginValidationServiceTests.swift
//  LearningToTestSwiftTests
//
//  Created by Juan Manuel Gentili on 07/02/2022.
//

@testable import LearningToTestSwift
import XCTest

class LoginValidationServiceTests: XCTestCase {

    var validation: LoginValidationService!
    
    override func setUp() {
        super.setUp()
        validation = LoginValidationService()
    }

    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    
    func testIsValidUsername() throws {
        XCTAssertNoThrow(try validation.validateUsername("kilo loco"))
    }
    
    func testUsernameIsNil() throws {
        let expectedError = LoginValidationError.invalidValue
        var error: LoginValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername(nil)) { thrownError in
            error = thrownError as? LoginValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testUserNameIsTooShort() throws {
        let expectedError = LoginValidationError.usernameTooShort
        var error: LoginValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername("loc")) { thrownError in
            error = thrownError as? LoginValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testUsernameIsTooLong() throws {
        let expectedError = LoginValidationError.usernameTooLong
        var error: LoginValidationError?
        let username = "very long user name1"
        
        XCTAssertTrue(username.count == 20)
        
        XCTAssertThrowsError(try validation.validateUsername(username)) { thrownError in
            error = thrownError as? LoginValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testIsValidPassword() throws {
        XCTAssertNoThrow(try validation.validatePassword("helloooo"))
    }
    
    func testPasswordIsNil() throws {
        let expectedError = LoginValidationError.invalidValue
        var error: LoginValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword(nil)) { thrownError in
            error = thrownError as? LoginValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testPasswordIsTooShort() throws {
        let expectedError = LoginValidationError.passwordTooShort
        var error: LoginValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("loc")) { thrownError in
            error = thrownError as? LoginValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testPasswordIsTooLong() throws {
        let expectedError = LoginValidationError.passwordTooLong
        var error: LoginValidationError?
        let password = "very long passworddddd"
        
        XCTAssertTrue(password.count > 20)
        
        XCTAssertThrowsError(try validation.validatePassword(password)) { thrownError in
            error = thrownError as? LoginValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }

}

