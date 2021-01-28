//
//  SpokenView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI

struct SpokenView: View {
    let spoken: Spoken
    
    var body: some View {
        VStack {
            ForEach(spoken.content.indices) {
                idx in
                LeadingAlignmentText(text: spoken.content[idx].s1)
                LeadingAlignmentText(text: spoken.content[idx].s2)
                if idx + 1 < spoken.content.count {
                    Divider()
                }
            }
        }
    }
}

//struct SpokenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpokenView()
//    }
//}
