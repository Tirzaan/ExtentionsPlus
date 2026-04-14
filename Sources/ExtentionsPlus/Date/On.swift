//
//  On.swift
//  ExtentionsPlus
//
//  Created by Tirzaan on 4/14/26.
//

extension Date {
    // MARK: - Quick Date Access
    static var yesterday: Date  { Calendar.current.date(byAdding: .day, value: -1, to: .now)! }
    static var tomorrow: Date   { Calendar.current.date(byAdding: .day, value: 1,  to: .now)! }
    static var lastWeek: Date   { Calendar.current.date(byAdding: .day, value: -7, to: .now)! }
    static var nextWeek: Date   { Calendar.current.date(byAdding: .day, value: 7,  to: .now)! }
    static var lastMonth: Date  { Calendar.current.date(byAdding: .month, value: -1, to: .now)! }
    static var nextMonth: Date  { Calendar.current.date(byAdding: .month, value: 1,  to: .now)! }
    static var lastYear: Date   { Calendar.current.date(byAdding: .year, value: -1, to: .now)! }
    static var nextYear: Date   { Calendar.current.date(byAdding: .year, value: 1,  to: .now)! }
    
    // MARK: - Days Offset
    static func daysAgo(_ days: Int) -> Date    { Calendar.current.date(byAdding: .day, value: -days, to: .now)! }
    static func daysAhead(_ days: Int) -> Date  { Calendar.current.date(byAdding: .day, value: days,  to: .now)! }
    static func weeksAgo(_ weeks: Int) -> Date  { Calendar.current.date(byAdding: .weekOfYear, value: -weeks, to: .now)! }
    static func monthsAgo(_ months: Int) -> Date { Calendar.current.date(byAdding: .month, value: -months, to: .now)! }
    static func yearsAgo(_ years: Int) -> Date  { Calendar.current.date(byAdding: .year, value: -years, to: .now)! }
    
    // MARK: - Custom String
    static func from(_ string: String, format: String = "MMM dd yyyy") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)
    }
    
    static func on(year: Int = Calendar.current.component(.year, from: .now), month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second))
    }
}
