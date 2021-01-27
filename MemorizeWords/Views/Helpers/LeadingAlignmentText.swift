//
//  LeadingAlignmentText.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI

struct LeadingAlignmentText: View {
    let text: String
    var body: some View {
        HStack {
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
    }
}
