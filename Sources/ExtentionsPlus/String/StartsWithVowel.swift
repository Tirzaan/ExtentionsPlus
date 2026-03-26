//
//  StartsWithVowel.swift
//  TestPackages
//
//  Created by Tirzaan on 3/17/26.
//

extension String {
    public func startsWithVowel() -> Bool {
        let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
        guard let first = self.first else { return false }
        return vowels.contains(Character(first.lowercased()))
    }
}
