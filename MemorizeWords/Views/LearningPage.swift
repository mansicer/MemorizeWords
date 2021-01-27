//
//  LearningPage.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI

struct LearningPage: View {
    @EnvironmentObject var modelData: ModelData
    var numOfLearnedWords : Int {
        modelData.profile.wordCount.filter {
            key, value in
            value > 0
        }.count
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("你已经学习了")
                .font(.title)
                .padding(5)
            Text("\(numOfLearnedWords)个")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("单词")
                .font(.title)
                .padding(5)
            Spacer()
            Button(action: {
                
            }, label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color(red: 0, green: 0.6, blue: 0.9))
                        .frame(width: 150, height: 150, alignment: .center)
                    Text("Start")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }
            })
            Spacer()
        }
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        LearningPage()
            .environmentObject(ModelData())
    }
}