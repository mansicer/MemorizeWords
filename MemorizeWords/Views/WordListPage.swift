//
//  WordListPage.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

struct WordListPage: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showRecognizedFirstly = false
    var filteredVocabulary: [Word] {
        if showRecognizedFirstly {
            return modelData.TOEFLVocabulary.sorted {
                word1, word2 in
                if modelData.isRecognized(word: word1.id) == modelData.isRecognized(word: word2.id) {
                    return word1.id.lowercased() < word2.id.lowercased()
                } else {
                    if modelData.isRecognized(word: word1.id) {
                        return true
                    } else {
                        return false
                    }
                }
            }
        } else {
            return modelData.TOEFLVocabulary.sorted {
                word1, word2 in
                word1.id.lowercased() < word2.id.lowercased()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showRecognizedFirstly, label: {
                    Text("优先显示已学习单词")
                })
                ForEach(filteredVocabulary) { word in
                    NavigationLink(
                        destination: WordView(word: word),
                        label: {
                            HStack {
                                Text(word.name)
                                Spacer()
                                Text("已学习\($modelData.profile.wordCount[word.name].wrappedValue!)次")
                            }
                        })
                }
            }
            .navigationTitle("单词表")
        }
    }
}

struct WordListPage_Previews: PreviewProvider {
    static var previews: some View {
        WordListPage()
            .environmentObject(ModelData())
    }
}
