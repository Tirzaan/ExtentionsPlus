//
//  TimeAgo.swift
//  ExtentionsPlus
//
//  Created by Tirzaan on 4/14/26.
//

import Foundation

extension Date {
    public var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: .now)
    }
    
    public var timeAgoShort: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: .now)
    }
}
