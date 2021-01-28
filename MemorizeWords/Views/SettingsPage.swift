//
//  SettingsPage.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

struct SettingsPage: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: LearningNumberSettingView(),
                    label: {
                        HStack {
                            Image(systemName: "text.badge.checkmark")
                            Text("设置每日学习单词数量")
                        }
                    })
            }
            .navigationTitle("设置")
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
            .environmentObject(ModelData())
    }
}
