//
//  CardView.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI

import SwiftUI

struct CardView: View {
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: LikeDislike = .none
    @State private var showPop = false
    
    private var word: Word
    private var onRemove: (_ word: Word) -> Void
    
    private var thresholdPercentage: CGFloat = 0.5 // when the user has draged 50% the width of the screen in either direction
    
    private enum LikeDislike: Int {
        case like, dislike, none
    }
    
    init(word: Word, onRemove: @escaping (_ word: Word) -> Void) {
        self.word = word
        self.onRemove = onRemove
    }
    
    /// What percentage of our own width have we swipped
    /// - Parameters:
    ///   - geometry: The geometry
    ///   - gesture: The current gesture translation value
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text(word.name)
                        .font(.title)
                    Spacer()
                    NavigationLink(
                        destination: WordView(word: word)
                        ) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                DefinitionView(definition: word.definitionStruct)
                    .font(.headline)
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                        if (self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                            self.swipeStatus = .like
                        } else if self.getGesturePercentage(geometry, from: value) <= -self.thresholdPercentage {
                            self.swipeStatus = .dislike
                        } else {
                            self.swipeStatus = .none
                        }
                        
                }.onEnded { value in
                    // determine snap distance > 0.5 aka half the width of the screen
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.word)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(word: ModelData().TOEFLVocabulary[0], onRemove: {
            word in
            print("remove word \(word.name)")
        })
    }
}
