//
//  School.swift
//  LearningToTestSwift
//
//  Created by Juan Manuel Gentili on 07/02/2022.
//

import Foundation

/// Simple Network Error to use in tests.
enum NetworkError: Error {
    case invalidRequest
}

/// A school in which students can study.
class School {
    
    /// Enrolled students.
    let students: [Student]
    
    /// The top students are defined as students with a GPA >= 4.0.
    var topStudents: [Student] { students(withGPALimit: 4.0) }
    
    /// Initializer.
    init(students: [Student]) {
        self.students = students
    }
    
    /// Property to test FAF functions.
    private(set) var didComplete = false
    
    func retrieveAlumni(_ completion: @escaping ((Result<[Student], NetworkError>) -> Void)) {
        /// Force error:
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            completion(.failure(.invalidRequest))
//        }
        
        /// Force success:
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.success([
                Student(name: "Juanma", grades: [1.5, 2]),
                Student(name: "Gentili", grades: [5, 10])
            ]))
        }
        
        /// Original network request.
//        Network.shared.performRequest("alumni/all") { response in
//            guard let alumni = response as? [Student] else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            completion(.success(alumni))
//        }
    }
    
    /// This was the function structure before `Result` was implemented by Apple, with two separated completion handlers for success and error.
    func retrieveAlumni(success: @escaping ([Student]) -> Void, failure: @escaping (Error) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            success([])
        }
    }
    
    /// Do something asynchronous and set `didComplete` to true when finished.
    func doSomethingAsynchronous(queue: DispatchQueue = DispatchQueue(label: "some queue")) {
        queue.async { [weak self] in
            sleep(1)
            self?.didComplete = true
        }
    }
    
}

private extension School {
    
    func students(withGPALimit gpa: Float) -> [Student] {
        students.filter {
            guard let studentGPA = $0.gpa else { return false }
            return studentGPA >= gpa
        }
    }
    
}
