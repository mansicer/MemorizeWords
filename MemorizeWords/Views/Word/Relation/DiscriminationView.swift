//
//  DiscriminationView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

struct DiscriminationView: View {
    var discrimination: Discrimination
    init(discrimination: Discrimination) {
        self.discrimination = discrimination
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(discrimination.content.indices) {
                    i in
                    LeadingAlignmentText(text: discrimination.content[i].name)
                    ForEach(discrimination.content[i].content.indices) {
                        j in
                        MultiLabelTableView(
                            content: discrimination.content[i].content[j],
                            leadingItemWidth: geometry.size.width / 3,
                            alignment: .leading
                        )
                    }
                }
                .listRowBackground(Color.clear)
                .background(Color.clear)
            }
            
        }
        .frame(minHeight: 300)
    }
}

struct DiscriminationView_Previews: PreviewProvider {
    static var previews: some View {
        let vocab = ModelData().TOEFLVocabulary
        DiscriminationView(discrimination: vocab[0].discrimination!)
    }
}
