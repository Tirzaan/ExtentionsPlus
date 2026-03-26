//
//  IsValidEmail.swift
//  TestPackages
//
//  Created by Tirzaan on 3/19/26.
//

import SwiftUI

extension String {
    public func isValidEmail() -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        return range(of: regex, options: .regularExpression) != nil
    }
}
