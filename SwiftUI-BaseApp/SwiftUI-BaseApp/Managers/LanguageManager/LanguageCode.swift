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

enum LanguageCode: Int {
    case english = 1
    case china
    case vietnam
    
    
    func getLanguage() -> Language {
        switch self {
        case .english:
            return  Language(displayName: "English",
                               languageCode: "eng",
                               flagName: "language_flag_2",
                               fileName: "lang_en.json")
        case .china:
            return Language(displayName: "中文",
                              languageCode: "chs",
                              flagName: "language_flag_1",
                              fileName: "lang_cn.json")
        case .vietnam:
            return Language(displayName: "Viet Nam",
                              languageCode: "vi",
                              flagName: "language_flag_3",
                              fileName: "lang_vi.json")
        }
    }
}

struct Language: Codable {
    var displayName: String
    var languageCode: String
    var flagName: String
    var remoteFileName: String
    
    init(displayName: String, languageCode: String, flagName: String, fileName: String) {
        self.displayName = displayName
        self.languageCode = languageCode
        self.flagName = flagName
        self.remoteFileName = fileName
    }
    
    
    var isChinaLanguage: Bool {
        return languageCode == "chs"
    }
}
