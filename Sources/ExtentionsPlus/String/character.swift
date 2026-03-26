//
//  CharacterStrExt.swift
//  TestPackages
//
//  Created by Tirzaan on 3/11/26.
//

extension String {
    public func character(at index: Int) -> String? {
        guard let i = self.index(startIndex, offsetBy: index, limitedBy: endIndex) else {
            return nil
        }
        return String(self[i])
    }
    
    public func characterSafe(at index: Int) -> String {
        return character(at: index) ?? ""
    }
    
    public func range(_ start: Int, _ end: Int) -> String {
        guard start >= 0,
              end >= start,
              let startIdx = index(startIndex, offsetBy: start, limitedBy: endIndex),
              let endIdx = index(startIdx, offsetBy: end - start + 1, limitedBy: endIndex)
        else {
            return ""
        }

        return String(self[startIdx..<endIdx])
    }
}
