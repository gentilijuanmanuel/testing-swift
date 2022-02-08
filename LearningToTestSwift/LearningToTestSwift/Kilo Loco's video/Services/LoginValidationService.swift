//
//  LoginValidationService.swift
//  LearningToTestSwift
//
//  Created by Juan Manuel Gentili on 07/02/2022.
//

import Foundation

/// Simple service to centralize common validations when the user is logging in.
struct LoginValidationService {
    
    /// This function returns the given `username` if it's valid.
    /// Otherwise, it returns the corresponding `LoginValidationError`.
    ///
    /// ```
    /// do {
    ///     let validatedUsername = try validateUsername("valid_username")
    /// } catch {
    ///     print("Validation error -> \(error.localizedDescription)")
    /// }
    /// ```
    ///
    /// - Parameter username: The username that should be validated.
    /// - Returns: The entered username if the validation succeeds. If not, an `LoginValidationError`.
    func validateUsername(_ username: String?) throws -> String {
        guard let username = username else { throw LoginValidationError.invalidValue }
        guard username.count > 3 else { throw LoginValidationError.usernameTooShort }
        guard username.count < 20 else { throw LoginValidationError.usernameTooLong }
        
        return username
    }
    
    /// This function returns the given `password` if it's valid.
    /// Otherwise, it returns the corresponding `LoginValidationError`.
    ///
    /// ```
    /// do {
    ///     let validatedPassword = try validatePassword("valid_password")
    /// } catch {
    ///     print("Validation error -> \(error.localizedDescription)")
    /// }
    /// ```
    ///
    /// - Parameter password: The password that should be validated.
    /// - Returns: The entered password if the validation succeeds. If not, an `LoginValidationError`.
    func validatePassword(_ password: String?) throws -> String {
        guard let password = password else { throw LoginValidationError.invalidValue }
        guard password.count >= 8 else { throw LoginValidationError.passwordTooShort }
        guard password.count < 20 else { throw LoginValidationError.passwordTooLong }
        
        return password
    }
    
}

/// Enum to express all the different validation errors that can occur durig login.
enum LoginValidationError: LocalizedError {
    case invalidValue
    case passwordTooLong
    case passwordTooShort
    case usernameTooLong
    case usernameTooShort
    
    var errorDescription: String? {
        switch self {
        case .invalidValue:
            return "You have entered an invalid value."
        case .passwordTooLong:
            return "Your password is too long."
        case .passwordTooShort:
            return "Your password is too short."
        case .usernameTooLong:
            return "Your username is too long."
        case .usernameTooShort:
            return "Your username is too short."
        }
    }
}
