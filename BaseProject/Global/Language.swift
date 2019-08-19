//
//  Language.swift
//  Flowtime
//
//  Created by Anonymous on 2019/7/1.
//  Copyright © 2019 Enter. All rights reserved.
//

import Foundation

enum LanguageMode: String {
    case zh_CH = "zh_ch"
    case en    = "en"
    case other = "other"

    func isEngish() -> Bool {
        return self.rawValue == "en"
    }
}

struct Language {
    static var currentMode: LanguageMode {
        return Language.detectLanguage()
    }

    fileprivate static func detectLanguage() -> LanguageMode {
        if let currentLanguage = Locale.preferredLanguages.first,
            let country = currentLanguage.split(separator: "-").first {
            if country.contains(LanguageMode.zh_CH.rawValue) {
                return LanguageMode.zh_CH
            }

            if country.contains(LanguageMode.en.rawValue) {
                return LanguageMode.en
            }
        }

        return LanguageMode.other
    }
}
