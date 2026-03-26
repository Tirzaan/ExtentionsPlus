//
//  ToString.swift
//  ExtentionsPlus
//
//  Created by Tirzaan on 3/26/26.
//
import Foundation

@available(iOS 16, *)
extension Date {
    /// Formats the date as an ISO 8601 string (RFC 3339 compliant).
    ///
    /// - Parameters:
    ///   - includeMilliseconds: If `true`, includes up to 3 fractional second digits.
    ///     Defaults to `true`.
    ///   - timeZone: Time zone for formatting (defaults to UTC/GMT → `Z` suffix).
    /// - Returns: e.g. `"2026-03-19T18:56:00.123Z"` (UTC) or with offset like `-0600`.
    public func toString(
        includeMilliseconds: Bool = true,
        timeZone: TimeZone = .gmt
    ) -> String {
        // Use ISO8601DateFormatter for consistent, cross-platform formatting
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withDashSeparatorInDate,
            .withColonSeparatorInTime,
            .withTimeZone
        ]

        if includeMilliseconds {
            formatter.formatOptions.insert(.withFractionalSeconds)
        }

        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
    
    /// Convenience computed property (milliseconds + UTC by default)
    public var iso8601: String {
        toString()
    }
}
