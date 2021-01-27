//
//  MemorizeWordsApp.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/26.
//

import SwiftUI

@main
struct MemorizeWordsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData())
        }
    }
}
