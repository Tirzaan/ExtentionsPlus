//
//  indefiniteArticle.swift
//  TestPackages
//
//  Created by Tirzaan on 3/11/26.
//

import Foundation
import SwiftUI

extension String {
    /// Returns the correct English indefinite article ("a" or "an") for the string.
    ///
    /// Handles:
    /// - Words that start with a vowel letter but sound like a consonant (e.g., "unicorn")
    /// - Silent-H words (e.g., "hour", "honest")
    /// - Initialisms pronounced with a vowel sound (e.g., "FBI", "F.B.I.", "R2D2")
    /// - Numbers pronounced with a vowel sound (e.g., "8-ball", "11th")
    /// - Normal vowel starts ("apple") and default consonant starts ("banana")
    ///
    /// - Parameter uppercased: If true, returns "A"/"An" instead of lowercase. Default is false.
    /// - Returns: "a" or "an" (or "A"/"An" if uppercased is true)
    public func indefiniteArticle(uppercased: Bool = false) -> String {
        let a = uppercased ? "A" : "a"
        let an = uppercased ? "An" : "an"
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return a }
        
        if isConsonantSoundWord(trimmed) { return a }
        if isInitialismWithVowelSound(trimmed) { return an }
        if isSilentHWord(trimmed) { return an }
        if startsWithVowel(trimmed) { return an }
        if startsWithVowelSoundNumber(trimmed) { return an }
        
        return a
    }
    
    public func withIndefiniteArticle(uppercased: Bool = false) -> String {
        return "\(self.indefiniteArticle(uppercased: uppercased)) \(self)"
    }
    
    // ── 1. Consonant-sound exceptions (vowel letter but consonant sound)
    private func isConsonantSoundWord(_ word: String) -> Bool {
        let exceptions: Set<String> = [
            "nasa","nato","unesco","one","once","unicorn","uniform","university",
            "utensil","utopia","euphemism","european","eulogy","ukulele","ufo",
            "youtube","y","yuan","ewe","ouija","union","unit","universe","uni-", "ubiquitous", "eucalyptus", "euphemism", "eureka", "unitarian", "ubiquity"
        ]
        let lower = word.lowercased()
        return exceptions.contains(where: lower.hasPrefix)
    }
    
    // ── 2. Initialisms with vowel sound (FBI, F.B.I., R2D2)
    private func isInitialismWithVowelSound(_ word: String) -> Bool {
        let vowelSoundInitials: Set<Character> = ["f","h","l","m","r","s","x"]
        
        // Check the first letter (ignoring case)
        guard let firstChar = word.first?.lowercased().first, vowelSoundInitials.contains(firstChar) else { return false }
        
        // Split on hyphens, take the first part
        let firstPart = word.split(separator: "-").first.map(String.init) ?? word
        
        // Fully uppercase, single letter, or contains number → initialism
        let isUppercase = firstPart == firstPart.uppercased()
        let hasNumber = firstPart.contains(where: { $0.isNumber })
        
        return isUppercase || firstPart.count == 1 || hasNumber
    }
    
    // ── 3. Silent / unsounded H words
    private func isSilentHWord(_ word: String) -> Bool {
        let silentPattern = #"^h(our|onou?r(able)?|eir|onest|erb|istoric(al)?|ourly|onoured?|onestly|omage|onorific|ereditary|ours|onestly|our|onor)"#
        let extraSilentH: Set<String> = [
            "honest","honestly","honor","honour","heir","heirloom","herb","herbal",
            "hour","hourly","homage","honorary","honorable","honorific"
        ]
        if extraSilentH.contains(where: word.lowercased().hasPrefix) { return true }
        return (try? NSRegularExpression(pattern: silentPattern, options: [.caseInsensitive]))?
            .firstMatch(in: word.lowercased(), range: NSRange(word.startIndex..<word.endIndex, in: word)) != nil
    }
    
    // ── 4. Normal vowel start
    private func startsWithVowel(_ word: String) -> Bool {
        guard let first = word.lowercased().first else { return false }
        return "aeiou".contains(first)
    }
    
    // ── 5. Numbers pronounced with vowel sound (8, 11, 18, 80–89…)
    private func startsWithVowelSoundNumber(_ word: String) -> Bool {
        guard let first = word.first, first.isNumber else { return false }
        let digits = word.prefix { $0.isNumber }
        let leadingTwo = digits.prefix(2)
        return digits.hasPrefix("8") || leadingTwo == "11" || leadingTwo == "18" && digits.count > 3 || digits == "18" || leadingTwo.hasPrefix("8")
    }
}


@available(iOS 13.0, *)
struct indefiniteArticlePreview: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text("Enter text to see it with an indefinite article")
            
            Text("Example: '\("Apple".withIndefiniteArticle(uppercased: true))' or '\("Car".withIndefiniteArticle(uppercased: true))'")
                .font(.footnote)
                .foregroundColor(.secondary)
            
            HStack {
                Text(text.indefiniteArticle(uppercased: true))
                    .padding(.leading, 6)
                
                TextField("Enter text here...", text: $text)
            }
        }
    }
}

@available(iOS 13.0.0, *)
struct indefiniteArticlePreview_Previews: PreviewProvider {
    static var previews: some View {
        indefiniteArticlePreview()
    }
}
