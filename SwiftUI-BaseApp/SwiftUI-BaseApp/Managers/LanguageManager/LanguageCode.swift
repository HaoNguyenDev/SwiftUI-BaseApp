//
//  LanguageCode.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 15/7/25.
//


import Foundation

import Foundation

public struct LanguageJsonModel: Codable {
    public var version: Int
    public var data: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case version = "version"
        case data = "data"
    }
}

enum LanguageCode: String, CaseIterable, TitleItem {
    case eng
    case chs
    case vi
    
    var title: String {
        switch self {
        case .eng:
            return "English"
        case .chs:
            return "中文"
        case .vi:
            return "Viet Nam"
        }
    }
    
    func getLanguage() -> Language {
        switch self {
        case .eng:
            return  Language(displayName: "English",
                               languageCode: "eng",
                               flagName: "language_flag_2",
                               fileName: "lang_en")
        case .chs:
            return Language(displayName: "中文",
                              languageCode: "chs",
                              flagName: "language_flag_1",
                              fileName: "lang_cn")
        case .vi:
            return Language(displayName: "Viet Nam",
                              languageCode: "vi",
                              flagName: "language_flag_3",
                              fileName: "lang_vi")
        }
    }
}

struct Language: Codable {
    var displayName: String
    var languageCode: String
    var flagName: String
    var fileName: String
    
    init(displayName: String, languageCode: String, flagName: String, fileName: String) {
        self.displayName = displayName
        self.languageCode = languageCode
        self.flagName = flagName
        self.fileName = fileName
    }
    
    
    var isChinaLanguage: Bool {
        return languageCode == LanguageCode.eng.rawValue
    }
}
