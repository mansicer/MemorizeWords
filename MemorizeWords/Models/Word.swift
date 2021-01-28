//
//  WordContent.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/27.
//

import SwiftUI


struct Word: Hashable, Codable, Identifiable {
    var id: String
    var definition: [String]
    var additional: [String: String]
    var relation: [String: [String]]
    var sentences: [String: [[String]]]
}


// MARK: User Data
extension Word {
//    var wordCount: Int {
//        get {
//            let defaults = UserDefaults.standard
//            if let dic = defaults.dictionary(forKey: DataKey.wordCount) as? [String: Int] {
//                return dic[id]!
//            }
//            else {
//                fatalError("User Defaults wordCount has not been created")
//            }
//        }
//        set {
//            let defaults = UserDefaults.standard
//            if var dic = defaults.dictionary(forKey: DataKey.wordCount) as? [String: Int] {
//                dic[id]! = newValue
//                defaults.setValue(dic, forKey: DataKey.wordCount)
//            }
//            else {
//                fatalError("User Defaults wordCount has not been created")
//            }
//        }
//    }
//
//    var hasRecognized: Bool {
//        wordCount > 0
//    }
}

// MARK: UI shortcuts
extension Word {
    var name: String {
        self.id
    }
    var hasAdditional: Bool {
        self.additional.count > 0
    }
    var hasRelation: Bool {
        self.relation.count > 0
    }
    var hasSentences: Bool {
        self.sentences.count > 0
    }
    
    var relationPickerList: [String] {
        var ret: [String] = []
        if self.cognate != nil {
            ret.append("同根词")
        }
        if self.synonym != nil {
            ret.append("同近义词")
        }
        if self.phrase != nil {
            ret.append("词组短语")
        }
        if self.discrimination != nil {
            ret.append("词语辨析")
        }
        return ret
    }
    
    @ViewBuilder func getRelationView(of index: Int) -> some View {
        let info = relationPickerList[index]
        if info == "同根词" {
            CognateView(cognate: self.cognate!)
        }
        else if info == "同近义词" {
            SynonymView(synonym: self.synonym!)
        }
        else if info == "词组短语" {
            PhraseView(phrase: self.phrase!)
        }
        else if info == "词语辨析" {
            DiscriminationView(discrimination: self.discrimination!)
        }
        else {
            fatalError("Can't find relation \(info)")
        }
    }
    
    var sentencePickerList: [String] {
        var ret: [String] = []
        if self.bilingual != nil {
            ret.append("双语例句")
        }
        if self.spoken != nil {
            ret.append("原声例句")
        }
        if self.authority != nil {
            ret.append("权威例句")
        }
        return ret
    }
    
    @ViewBuilder func getSentenceView(of index: Int) -> some View {
        let info = sentencePickerList[index]
        if info == "双语例句" {
            BilingualView(bilingual: self.bilingual!)
        }
        else if info == "原声例句" {
            SpokenView(spoken: self.spoken!)
        }
        else if info == "权威例句" {
            AuthorityView(authority: self.authority!)
        }
        else {
            fatalError("Can't find sentence part \(info)")
        }
    }
}

// MARK: definition reshape
extension Word {
    var definitionStruct: Definition {
        var ret = [DoubleStringTuple]()
        for text in definition {
            let textSplit = text.split(separator: " ")
            if textSplit.count == 1 {
                ret.append(DoubleStringTuple(s1: "", s2: textSplit[0].base))
            }
            else {
                let s1 = String(textSplit[0])
                let s2 = textSplit.dropFirst().joined(separator: "；")
                ret.append(DoubleStringTuple(s1: s1, s2: s2))
            }
        }
        return Definition(definations: ret)
    }
}

// MARK: relation information extension
extension Word {
    var cognate: Cognate? {
        let item = relation.filter {
            k, v in
            k == "同根词"
        }
        if item.isEmpty {
            return nil
        }
        else {
            let textList = item.values.first!
            var content: [MultiLabelClass] = []
            
            let remainTextList = textList.dropFirst(2)
            
            var partOfSpeech = ""
            var indexOfPartOfSpeech = -1
            var definationText = ""
            var labels: [String] = []
            
            for i in remainTextList.startIndex..<remainTextList.endIndex {
                let item = remainTextList[i]
                if item.isPartOfSpeech() {
                    if !labels.isEmpty {
                        content.append(MultiLabelClass(name: partOfSpeech, labels: labels))
                    }
                    partOfSpeech = item
                    indexOfPartOfSpeech = i
                    definationText = ""
                    labels = []
                } else {
                    if (i - indexOfPartOfSpeech) % 2 != 0 {
                        definationText = item
                    } else {
                        definationText += " " + item
                        labels.append(definationText)
                    }
                }
            }
            if !labels.isEmpty {
                content.append(MultiLabelClass(name: partOfSpeech, labels: labels))
            }
            return Cognate(content: content)
        }
    }
    
    var synonym: Synonym? {
        let item = relation.filter {
            k, v in
            k == "同近义词"
        }
        if item.isEmpty {
            return nil
        }
        else {
            let textList = item.values.first!
            var returnList: [String] = []
            var remainStringList: [String] = []
            for text in textList {
                if text.startsWithPartOfSpeech() {
                    if !remainStringList.isEmpty {
                        returnList.append(remainStringList.joined(separator: " "))
                    }
                    returnList.append(text)
                    remainStringList = []
                } else {
                    remainStringList.append(text)
                }
            }
            if !remainStringList.isEmpty {
                returnList.append(remainStringList.joined(separator: " "))
            }
            
            var content = [DoubleStringTuple]()
            for i in 0..<returnList.count/2 {
                content.append(DoubleStringTuple(
                    s1: returnList[i*2],
                    s2: returnList[i*2+1]
                ))
            }
            return Synonym(content: content)
        }
    }
    
    var discrimination: Discrimination? {
        let item = relation.filter {
            k, v in
            k == "词语辨析"
        }
        if item.isEmpty {
            return nil
        }
        else {
            // TODO: check if display right
            let textList = item.values.first!
            let blockBeginText = textList.filter {
                element in
                element.contains(",")
            }
            
            var blocks = [MultiClassBlock]()
            for i in 0..<blockBeginText.count {
                let startIndex = textList.firstIndex(of: blockBeginText[i])!
                let endIndex: Int
                if i != blockBeginText.count - 1 {
                    endIndex = textList.firstIndex(of: blockBeginText[i+1])!
                }
                else {
                    endIndex = textList.count
                }
                
                if (endIndex - startIndex) % 2 == 0 {
                    // two lines description
                    let name = textList[startIndex...startIndex+1].joined(separator: "\n")
                    let combination = Array(textList[startIndex+2..<endIndex]).combineEveryTwoElements()
                    let content = combination.map {
                        element in
                        MultiLabelClass(name: element.s1, labels: [element.s2])
                    }
                    blocks.append(MultiClassBlock(name: name, content: content))
                }
                else {
                    // one line description
                    let name = textList[startIndex]
                    let combination = Array(textList[startIndex+1..<endIndex]).combineEveryTwoElements()
                    let content = combination.map {
                        element in
                        MultiLabelClass(name: element.s1, labels: [element.s2])
                    }
                    blocks.append(MultiClassBlock(name: name, content: content))
                }
            }
            return Discrimination(content: blocks)
        }
    }
    
    var phrase: Phrase? {
        let item = relation.filter {
            k, v in
            k == "词组短语"
        }
        if item.isEmpty {
            return nil
        }
        else {
            let textList = item.values.first!
            
            var content = [DoubleStringTuple]()
            for i in 0..<textList.count/2 {
                content.append(DoubleStringTuple(
                    s1: textList[i*2],
                    s2: textList[i*2+1]
                ))
            }
            return Phrase(content: content)
        }
    }
}

// MARK: sentence information extension
extension Word {
    var bilingual: Bilingual? {
        let item = sentences.filter {
            k, v in
            k == "双语例句"
        }
        if item.isEmpty {
            return nil
        }
        else {
            let value = item.values.first!
            var content = [DoubleStringTuple]()
            for sentence in value {
                let tuple = DoubleStringTuple(s1: sentence[0], s2: sentence[1])
                content.append(tuple)
            }
            return Bilingual(content: content)
        }
    }
    
    var spoken: Spoken? {
        let item = sentences.filter {
            k, v in
            k == "原声例句"
        }
        if item.isEmpty {
            return nil
        }
        else {
            let value = item.values.first!
            var content = [DoubleStringTuple]()
            for sentence in value {
                let tuple = DoubleStringTuple(s1: sentence[0], s2: sentence[1])
                content.append(tuple)
            }
            return Spoken(content: content)
        }
    }
    
    var authority: Authority? {
        let item = sentences.filter {
            k, v in
            k == "权威例句"
        }
        if item.isEmpty {
            return nil
        }
        else {
            let value = item.values.first!
            var content = [String]()
            for sentence in value {
                content.append(sentence[0])
            }
            return Authority(content: content)
        }
    }
}
