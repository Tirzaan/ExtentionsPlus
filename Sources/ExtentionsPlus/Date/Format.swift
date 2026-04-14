//
//  Format.swift
//  ExtentionsPlus
//
//  Created by Tirzaan on 4/14/26.
//

import Foundation

extension Date {
    // MARK: - Time Strings
    public var timeShort: String {
        self.formatted(date: .omitted, time: .shortened)      // "8:15 AM"
    }
    
    public var timeFull: String {
        self.formatted(date: .omitted, time: .complete)        // "8:15:00 AM PST"
    }
    
    public var timeStandard: String {
        self.formatted(date: .omitted, time: .standard)        // "8:15:00 AM"
    }
    
    // MARK: - Date Strings
    public var dateShort: String {
        self.formatted(date: .abbreviated, time: .omitted)     // "Apr 14, 2026"
    }
    
    public var dateFull: String {
        self.formatted(date: .complete, time: .omitted)        // "Tuesday, April 14, 2026"
    }
    
    public var dateNumeric: String {
        self.formatted(date: .numeric, time: .omitted)         // "4/14/2026"
    }
    
    // MARK: - Combined
    public var dateTimeShort: String {
        self.formatted(date: .abbreviated, time: .shortened)   // "Apr 14, 2026, 8:15 AM"
    }
    
    // MARK: - Custom Format
    public func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension FormatStyle where Self == Date.FormatStyle {
    public static var timeOnly: Date.FormatStyle {
        .dateTime.hour().minute()                              // "8:15 AM"
    }
    
    public static var dateOnly: Date.FormatStyle {
        .dateTime.month(.abbreviated).day().year()             // "Apr 14, 2026"
    }
    
    public static var fullDateTime: Date.FormatStyle {
        .dateTime.weekday(.wide).month(.wide).day().year().hour().minute() // "Tuesday, April 14, 2026, 8:15 AM"
    }
}
