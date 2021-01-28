//
//  Profile.swift
//  MemorizeWords
//
//  Created by sicer on 2021/1/28.
//

import Foundation

struct Profile {
    var wordCount = [String: Int]()
    var numOfWordEveryLearning: Int {
        get {
            let defaults = UserDefaults.standard
            if let numOfWordEveryLearning = defaults.object(forKey: DataKey.numOfWordEveryLearning) as? Int {
                return numOfWordEveryLearning - 5
            } else {
                defaults.setValue(10, forKey: DataKey.numOfWordEveryLearning)
                return 10 - 5
            }
        }
        set {
            let defaults = UserDefaults.standard
            defaults.setValue(newValue + 5, forKey: DataKey.numOfWordEveryLearning)
        }
    }
}
