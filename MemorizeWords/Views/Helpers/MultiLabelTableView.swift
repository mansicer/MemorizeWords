//
//  MultiLabelTableView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

struct MultiLabelTableView: View {
    let content: MultiLabelClass
    let leadingItemWidth: CGFloat
    let alignment: Alignment
    var body: some View {
        HStack(alignment: .top) {
            Text(content.name)
                .frame(width: leadingItemWidth, alignment: alignment)
            VStack {
                ForEach(content.labels.indices) {
                    LeadingAlignmentText(text: content.labels[$0])
                }
            }
        }
    }
}

struct MultiLabelTableView_Previews: PreviewProvider {
    static var previews: some View {
        let vocab = ModelData().TOEFLVocabulary
        MultiLabelTableView(content: (vocab[1].cognate?.content.first)!, leadingItemWidth: 40, alignment: .topLeading)
    }
}
