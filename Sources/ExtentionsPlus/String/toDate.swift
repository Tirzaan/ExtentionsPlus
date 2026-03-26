//
//  toDate.swift
//  ExtentionsPlus
//
//  Created by Tirzaan on 3/26/26.
//

import SwiftUI
import Foundation

/// Presets for common date formats in String.toDate().
/// Use .iso8601 (default) for most API/JSON work.
public enum DateFormatPreset: CaseIterable, Equatable {
    /// ISO 8601 standard (no fractional seconds) – e.g. "2026-03-19T11:33:00Z"
    case iso8601
    /// ISO 8601 with milliseconds – e.g. "2026-03-19T11:33:45.123Z"
    case iso8601Millis
    /// Basic date only – very common in storage/DB
    case yyyyMMdd
    /// European/UK style
    case ddMMyyyy
    /// US style
    case MMddyyyy
    /// Date + time no TZ – common in logs
    case yyyyMMddHHmmss
    /// Escape hatch for anything else
    case custom(String)

    public static var allCases: [DateFormatPreset] {
        return [.iso8601, .iso8601Millis, .yyyyMMdd, .ddMMyyyy, .MMddyyyy, .yyyyMMddHHmmss]
    }

    var format: String {
        switch self {
        case .iso8601:
            return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .iso8601Millis:
            return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .yyyyMMdd:
            return "yyyy-MM-dd"
        case .ddMMyyyy:
            return "dd/MM/yyyy"
        case .MMddyyyy:
            return "MM/dd/yyyy"
        case .yyyyMMddHHmmss:
            return "yyyy-MM-dd HH:mm:ss"
        case .custom(let fmt):
            return fmt
        }
    }
}

extension String {
    /// Converts string to Date.
    /// - Tries ISO 8601 variants first (most reliable for APIs).
    /// - Falls back to the specified preset format.
    /// - Uses POSIX locale + UTC to avoid parsing surprises.
    ///
    /// - Parameter preset: Format to try after ISO fails (default: .iso8601)
    /// - Returns: Date if successful, nil otherwise
    public func toDate(_ preset: DateFormatPreset = .iso8601) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [
            .withInternetDateTime,
            .withDashSeparatorInDate,
            .withColonSeparatorInTime,
            .withTimeZone,
            .withFractionalSeconds
        ]
        
        // Attempt full ISO with fractions
        if let date = isoFormatter.date(from: self) {
            return date
        }
        
        // Fallback to basic ISO (no fractions) if needed
        isoFormatter.formatOptions.remove(.withFractionalSeconds)
        if let date = isoFormatter.date(from: self) {
            return date
        }
        
        // Now try the user-provided preset
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)  // Assume UTC unless TZ in string
        formatter.dateFormat = preset.format
        
        if let date = formatter.date(from: self) {
            return date
        }
        
        if preset != .yyyyMMddHHmmss {
            formatter.dateFormat = DateFormatPreset.yyyyMMddHHmmss.format
            if let date = formatter.date(from: self) {
                return date
            }
        }
        
        return nil
    }
}
