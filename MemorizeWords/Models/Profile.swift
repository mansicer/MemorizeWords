//
//  Profile.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import Foundation

struct Profile {
    var wordCount = [String: Int]()
    var numOfWordEveryLearningIndex: Int {
        get {
            return numOfWordEveryLearning - 5
        }
        set {
            numOfWordEveryLearning = newValue + 5
        }
    }
    var numOfWordEveryLearning: Int {
        get {
            let defaults = UserDefaults.standard
            if let numOfWordEveryLearning = defaults.object(forKey: DataKey.numOfWordEveryLearning) as? Int {
                return numOfWordEveryLearning
            } else {
                defaults.setValue(10, forKey: DataKey.numOfWordEveryLearning)
                return 10
            }
        }
        set {
            let defaults = UserDefaults.standard
            defaults.setValue(newValue, forKey: DataKey.numOfWordEveryLearning)
        }
    }
}
