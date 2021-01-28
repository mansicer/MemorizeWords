//
//  ContentView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .wordList
    
    enum Tab {
        case start
        case favorite
        case wordList
        case settings
    }
    
    var body: some View {
        TabView(selection: $selection) {
            LearningPage()
                .tabItem {
                    Label("学习", systemImage: "house.fill")
                }
                .tag(Tab.start)
            FavoritePage()
                .tabItem {
                    Label("为你推荐", systemImage: "heart.fill")
                }
                .tag(Tab.favorite)
            WordListPage()
                .tabItem {
                    Label("单词表", systemImage: "list.bullet")
                }
                .tag(Tab.wordList)
            SettingsPage()
                .tabItem {
                    Label("设置", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
