//
//  MoveItem.swift
//  TestPackages
//
//  Created by Tirzaan on 3/18/26.
//
import SwiftUI

extension Array {
    public func moveItem<T>(in array: inout [T], from oldIndex: Int, to newIndex: Int) {
        guard oldIndex != newIndex,
              oldIndex >= 0, oldIndex < array.count,
              newIndex >= 0, newIndex <= array.count else { return }
        
        let item = array.remove(at: oldIndex)
        array.insert(item, at: newIndex)
    }
}
