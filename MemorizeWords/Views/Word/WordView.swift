//
//  WordView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

struct WordView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var selectedRelationIndex = 0
    @State private var selectedSentencesIndex = 0
    let word: Word
    
    var wordIndex: Int {
        modelData.TOEFLVocabulary.firstIndex(where: { $0.id == word.name })!
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer(minLength: 20)
            // MARK: word name
            HStack {
                Text(word.name)
                    .font(.largeTitle)
                Spacer()
                VStack {
                    Text("已学习\($modelData.profile.wordCount[word.name].wrappedValue!)次")
                    Button(action: {
                        modelData.incrementWordCount(word.name)
                    }, label: {
                        Text("打卡")
                        Image(systemName: "checkmark.circle")
                    })
                }
            }
            Spacer(minLength: 20)
            
            // MARK: word definition
            DefinitionView(definition: word.definitionStruct)
                .padding(5)
                .font(.headline)
            
            // MARK: word relation
            if (word.hasRelation) {
                Spacer(minLength: 20)
                VStack {
                    Picker("relation", selection: $selectedRelationIndex) {
                        ForEach(word.relationPickerList.indices) {
                            Text(word.relationPickerList[$0]).tag($0)
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                    word.getRelationView(of: selectedRelationIndex)
                        .padding(8)
                }
                .background(ViewUtils.getViewBlurBackground())
            }
        }
        .padding()
        .background(ViewUtils.getBlurBackgroundImage("background_img1"))
        .navigationBarTitle(word.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        let vocab = ModelData().TOEFLVocabulary
        WordView(word: vocab[0])
            .environmentObject(ModelData())
    }
}
