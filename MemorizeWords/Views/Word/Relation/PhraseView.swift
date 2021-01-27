//
//  PhraseView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

struct PhraseView: View {
    var phrase: Phrase
    var body: some View {
        VStack {
            ForEach(phrase.content.indices) {
                idx in
                LeadingAlignmentText(text: phrase.content[idx].s1)
                LeadingAlignmentText(text: phrase.content[idx].s2)
                if idx + 1 < phrase.content.count {
                    Divider()
                }
            }
        }
    }
}

struct PhraseView_Previews: PreviewProvider {
    static var previews: some View {
        let vocab = ModelData().TOEFLVocabulary
        PhraseView(phrase: vocab[0].phrase!)
    }
}
