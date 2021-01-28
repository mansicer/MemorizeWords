//
//  WordChoosingView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI

struct WordChoosingView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var action: Int? = 0
    let words: [Word]
    
    var body: some View {
        VStack {
            NavigationLink(destination: Text("LearningDetail"), tag: 1, selection: $action) {
                EmptyView()
            }
            List {
                ForEach(words) {
                    word in
                    HStack {
                        Text(word.name)
                        Spacer()
                        Text("已学习\($modelData.profile.wordCount[word.name].wrappedValue!)次")
                    }
                }
            }
        }
        .navigationTitle("今天学习的单词: ")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarItems(trailing: Button(action: {
            action = 1
        }) {
            Text("开始学习")
                .foregroundColor(.blue)
        })
    }
}

struct WordChoosingView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        WordChoosingView(words: modelData.getLearningWords())
            .environmentObject(modelData)
    }
}
