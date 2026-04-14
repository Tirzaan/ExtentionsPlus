//
//  Day.swift
//  ExtentionsPlus
//
//  Created by Tirzaan on 4/14/26.
//

import Foundation

extension Date {
    public var isToday: Bool     { Calendar.current.isDateInToday(self) }
    public var isYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    public var isTomorrow: Bool  { Calendar.current.isDateInTomorrow(self) }
    public var isWeekend: Bool   { Calendar.current.isDateInWeekend(self) }
    
    // Returns a friendly label
    public var dayLabel: String {
        if isToday     { return "Today" }
        if isYesterday { return "Yesterday" }
        if isTomorrow  { return "Tomorrow" }
        return self.formatted(date: .abbreviated, time: .omitted) // "Apr 12, 2026"
    }
}
