//
//  BilingualView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI

struct BilingualView: View {
    var bilingual: Bilingual
    
    var body: some View {
        VStack {
            ForEach(bilingual.content.indices) {
                idx in
                LeadingAlignmentText(text: bilingual.content[idx].s1)
                LeadingAlignmentText(text: bilingual.content[idx].s2)
                if idx + 1 < bilingual.content.count {
                    Divider()
                }
            }
        }
    }
}
