//
//  LocalizableStringExtension.swift
//  MyApp
//
//  Created by Lorusso, Michele on 29/11/24.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: Localization.localizedStringsTable,
            bundle: .main,
            value: self,
            comment: self)
    }
}
