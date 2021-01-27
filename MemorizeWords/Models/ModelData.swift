//
//  ModelData.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import Foundation

final class ModelData: ObservableObject {
    var TOEFLVocabulary: [Word] = loadVocabulary("toefl_vocab.json")
    @Published var profile = Profile()
    init() {
        let defaults = UserDefaults.standard
        
        if let wordCount = defaults.dictionary(forKey: DataKey.wordCount) as? [String: Int] {
            profile.wordCount = wordCount
            print("load \(wordCount.count) words from user data successfully")
        } else {
            // initialize word count
            let wordList = TOEFLVocabulary.map {
                $0.id
            }
            var wordCount = profile.wordCount
            for word in wordList {
                wordCount[word] = 0
            }
            defaults.setValue(wordCount, forKey: DataKey.wordCount)
            print("initialize \(wordCount.count) words to user data")
        }
    }
    
    func getWordCount(_ name: String) -> Int {
        profile.wordCount[name]!
    }
    
    func setWordCount(_ name: String, _ num: Int) {
        profile.wordCount[name] = num
        let defaults = UserDefaults.standard
        defaults.setValue(profile.wordCount, forKey: DataKey.wordCount)
    }
    
    func incrementWordCount(_ name: String) {
        setWordCount(name, getWordCount(name) + 1)
    }
    
    func isRecognized(word name: String) -> Bool {
        getWordCount(name) > 0
    }
}

func loadVocabulary<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
