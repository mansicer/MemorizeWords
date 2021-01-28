//
//  DefinitionView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI

struct DefinitionView: View {
    let definition: Definition
    var needsTwoColumns: Bool {
        definition.definations.filter {
            element in
            !element.s1.isEmpty
        }.count > 0
    }
    var body: some View {
        if needsTwoColumns {
            ForEach(definition.definations.indices) {
                idx in
                MultiLabelTableView(
                    content: MultiLabelClass(
                        name: definition.definations[idx].s1, labels: [definition.definations[idx].s2]
                    ),
                    leadingItemWidth: 50,
                    alignment: .leading
                )
                if idx < definition.definations.count - 1 {
                    Divider()
                }
            }
        }
        else {
            ForEach(definition.definations.indices) {
                idx in
                LeadingAlignmentText(text: definition.definations[idx].s2)
                Divider()
            }
        }
    }
}
