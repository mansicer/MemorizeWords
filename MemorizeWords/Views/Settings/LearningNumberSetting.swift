//
//  LearningNumberSetting.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI

struct LearningNumberSettingView: View {
    @EnvironmentObject var modelData: ModelData
    private var numOfWordRange = Array(5...50)
    
    var body: some View {
        List {
            Text("选择每次想要学习的单词量")
            Picker("learningNumberSetting",
                   selection: $modelData.profile.numOfWordEveryLearning) {
                ForEach(numOfWordRange.indices) {
                    idx in
                    Text("\(numOfWordRange[idx])")
                }
            }
        }
    }
}

struct LearningNumberSettingView_Previews: PreviewProvider {
    static var previews: some View {
        LearningNumberSettingView()
            .environmentObject(ModelData())
    }
}
