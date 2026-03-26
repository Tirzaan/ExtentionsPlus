//
//  Editable.swift
//  TestPackages
//
//  Created by Tirzaan on 3/18/26.
//


import SwiftUI
import SwiftUI

public enum EditType: Equatable {
    case delete
    case move
    case both
}

@available(iOS 13.0, *)
extension DynamicViewContent {
    /// Applies both delete and move handlers in a single modifier to avoid chaining issues.
    /// Use with ForEach over a mutable, range-replaceable collection with Int indices.
    public func editable<C>(_ editType: EditType = .both, items: Binding<C>) -> some View
    where C: RangeReplaceableCollection & MutableCollection,
          C.Index == Int {

        self
            .onDelete { indexSet in
                guard editType == .delete || editType == .both else { return }
                
                var copy = items.wrappedValue
                for offset in indexSet.sorted(by: >) {
                    let idx = copy.index(copy.startIndex, offsetBy: offset)
                    copy.remove(at: idx)
                }
                items.wrappedValue = copy
            }
            .onMove { indices, newOffset in
                guard editType == .move || editType == .both else { return }
                
                var temp = Array(items.wrappedValue)
                temp.move(fromOffsets: indices, toOffset: newOffset)

                var rebuilt = C()
                rebuilt.reserveCapacity(temp.count)
                for element in temp {
                    rebuilt.append(element)
                }
                items.wrappedValue = rebuilt
            }
    }
}

@available(iOS 13.0, *)
struct EditableView: View {
    @State private var value = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    var body: some View {
        List {
            ForEach(value, id: \.self) { x in
                Text("Row \(x)")
            }
            .editable(.both, items: $value)
            
            Text(verbatim: String(describing: value))
        }
    }
}

@available(iOS 13.0.0, *)
struct EditableView_Previews: PreviewProvider {
    static var previews: some View {
        EditableView()
    }
}
