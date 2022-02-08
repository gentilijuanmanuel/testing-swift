//
//  LearningToTestSwiftApp.swift
//  LearningToTestSwift
//
//  Created by Juan Manuel Gentili on 07/02/2022.
//

import SwiftUI

@main
struct LearningToTestSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            VStack(alignment: .center, spacing: 10) {
                Text("Learning to test Swift! 🚀")
                    .font(.title)
                Text("Nothing to see here.\nThe core of this project is inside Unit/UI tests targets :)")
                    .multilineTextAlignment(.center)
            }
        }
    }
}
