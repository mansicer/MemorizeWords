//
//  StringUtils.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import Foundation

extension String {
    func isPartOfSpeech() -> Bool {
        RawDataUtils.isPartOfSpeech(self)
    }
    
    func startsWithPartOfSpeech() -> Bool {
        RawDataUtils.startsWithPartOfSpeech(self)
    }
}

extension Array where Element == String {
    func combineEveryTwoElements() -> [DoubleStringTuple] {
        var ret = [DoubleStringTuple]()
        for i in 0..<self.count/2 {
            ret.append(DoubleStringTuple(s1: self[i*2], s2: self[i*2 + 1]))
        }
        return ret
    }
}
