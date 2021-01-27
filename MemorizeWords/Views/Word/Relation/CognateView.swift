//
//  CognateView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

struct CognateView: View {
    let cognate: Cognate
    var body: some View {
        VStack {
            ForEach(cognate.content.indices) {
                idx in
                MultiLabelTableView(content: cognate.content[idx], leadingItemWidth: 40, alignment: .topLeading)
                if idx + 1 < cognate.content.count {
                    Divider()
                }
            }
        }
    }
}

struct CognateView_Previews: PreviewProvider {
    static var previews: some View {
        let vocab = ModelData().TOEFLVocabulary
        CognateView(cognate: vocab[0].cognate!)
    }
}
