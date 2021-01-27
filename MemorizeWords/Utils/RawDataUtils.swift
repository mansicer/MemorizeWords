//
//  RawDataUtils.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import Foundation

class RawDataUtils {
    static let partOfSpeechList = [
        "n.", "v.", "vt.", "vi.",
        "adj.", "adv.",
        "prep.", "conj.", "pron.",
        "num.", "art.",
        "det.", "int."
    ]
    
    static func isPartOfSpeech(_ text: String) -> Bool {
        return partOfSpeechList.contains(text)
    }
    
    static func startsWithPartOfSpeech(_ text: String) -> Bool {
        let hasPrefix = partOfSpeechList.filter {
            partOfSpeech in
            text.hasPrefix(partOfSpeech)
        }
        return !hasPrefix.isEmpty
    }
}
