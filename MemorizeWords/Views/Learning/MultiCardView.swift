//
//  MultiCardView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI

struct MultiCardView: View {
    @EnvironmentObject var modelData: ModelData
    @State var words: [Word]
    
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(words.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(words.count - 1 - id) * 10
    }
    
    private func getWordID(_ word: Word) -> Int {
        return words.firstIndex(of: word) ?? 0
    }
    
    private var maxID: Int {
        return self.words.map { getWordID($0) }.max() ?? 0
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LinearGradient(
                    gradient: Gradient(
                        colors: [Color.init(#colorLiteral(red: 0.8509803922, green: 0.6549019608, blue: 0.7803921569, alpha: 1)), Color.init(#colorLiteral(red: 1, green: 0.9882352941, blue: 0.862745098, alpha: 1))]
                    ),
                    startPoint: .bottom,
                    endPoint: .top
                )
                    .frame(
                        width: geometry.size.width * 1.5,
                        height: geometry.size.height
                    )
                    .background(Color.init(#colorLiteral(red: 0.8509803922, green: 0.6549019608, blue: 0.7803921569, alpha: 1)))
                    .clipShape(Circle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                
                VStack(spacing: 24) {
                    DateView()
                    ZStack {
                        ForEach(self.words) { word in
                            Group {
                                // Range Operator
                                if (self.maxID - 3)...self.maxID ~= getWordID(word) {
                                    CardView(word: word, onRemove: {
                                        removedWord in
                                        modelData.incrementWordCount(word.name)
                                        // Remove that word from our array
                                        self.words.removeAll {
                                            $0.id == removedWord.id
                                        }
                                    })
                                        .animation(.spring())
                                        .frame(width: self.getCardWidth(geometry, id: getWordID(word)), height: 400)
                                        .offset(x: 0, y: self.getCardOffset(geometry, id: getWordID(word)))
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }.padding()
    }
}

struct DateView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Friday, 10th January")
                        .font(.title)
                        .bold()
                    Text("Today")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct MultiCardView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        let words = Array(modelData.TOEFLVocabulary[0...10])
        MultiCardView(words: words)
            .environmentObject(modelData)
    }
}
