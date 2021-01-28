//
//  FavoritePage.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import SwiftUI
import CoreML

struct FavoritePage: View {
    static let numOfFavoriteItem = 20
    
    @EnvironmentObject var modelData: ModelData
    
    var favoriteVocabulary: [Word] {
        let model = try! WordRecommender(configuration: MLModelConfiguration())
        var items = [String: Double]()
        for (k, v) in modelData.profile.wordCount {
            items[k] = Double(v)
        }
        let k = FavoritePage.numOfFavoriteItem
        let modelOutput = try! model.prediction(
            items: items,
            k: Int64(k),
            restrict_: modelData.TOEFLVocabulary.map {$0.name},
            exclude: nil
        )
        let words = modelOutput.recommendations
        var ret = modelData.TOEFLVocabulary.filter {
            w in
            words.contains(w.name)
        }
        if ret.count < k {
            let remainNum = k - ret.count
            let remainWords = modelData.TOEFLVocabulary.shuffled()[0..<remainNum]
            ret.append(contentsOf: remainWords)
        }
        return ret
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteVocabulary) { word in
                    NavigationLink(
                        destination: WordView(word: word),
                        label: {
                            HStack {
                                Text(word.name)
                            }
                        })
                }
            }
            .navigationTitle("为你推荐")
        }
    }
}

struct FavoritePage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePage()
            .environmentObject(ModelData())
    }
}
