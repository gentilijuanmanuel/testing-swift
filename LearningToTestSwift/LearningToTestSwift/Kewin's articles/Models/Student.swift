//
//  Student.swift
//  LearningToTestSwift
//
//  Created by Juan Manuel Gentili on 07/02/2022.
//

/// A student in a school.
struct Student {
    
    /// The name of the student.
    let name: String
    
    /// The list of all grades for the student.
    let grades: [Float]
    
    /// The current grade point average of the student.
    var gpa: Float? {
        guard !grades.isEmpty else { return nil }
        return grades.reduce(0, +) / Float(grades.count)
    }
    
}
