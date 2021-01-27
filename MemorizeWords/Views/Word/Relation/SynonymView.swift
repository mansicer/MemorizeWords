//
//  SynonymView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

struct SynonymView: View {
    var synonym: Synonym
    var body: some View {
        VStack {
            ForEach(synonym.content.indices) {
                idx in
                LeadingAlignmentText(text: synonym.content[idx].s1)
                LeadingAlignmentText(text: synonym.content[idx].s2)
                if idx + 1 < synonym.content.count {
                    Divider()
                }
            }
        }
    }
}

struct SynonymView_Previews: PreviewProvider {
    static var previews: some View {
        let vocab = ModelData().TOEFLVocabulary
        SynonymView(synonym: vocab[0].synonym!)
    }
}
