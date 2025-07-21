//
//  LanguageManager.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 15/7/25.
//


import Foundation

final class LanguageManager {
    static let shared = LanguageManager()
    
    private(set) var language: Language {
        didSet {
            loadLocalModel()
        }
    }
    
    private var localModel: LanguageJsonModel?
    var localVersion: Int { localModel?.version ?? 0 }

    let allSupportLanguages = [
        LanguageCode.english.getLanguage(),
        LanguageCode.china.getLanguage(),
        LanguageCode.vietnam.getLanguage()
    ]
    
    private init() {
        let languageCode = UserSettings.shared.userLanguageCode
        language = UserSettings.shared.getLanguage(languageCode).getLanguage()
        loadLocalModel()
    }

    public func setLanguage(language: Language) {
        let selectedLanguage = allSupportLanguages.first(where: { $0.languageCode == language.languageCode }) ?? language
        self.language = selectedLanguage
        UserSettings.shared.userLanguageCode = selectedLanguage.languageCode
    }

    public func valueForKey(_ key: String) -> String {
        return localModel?.data[key] ?? key
    }

    // MARK: - Private
    private func loadLocalModel() {
        guard let url = Bundle.main.url(forResource: language.fileName, withExtension: "json") else {
            Logger.shared.error("❌ File not found for language: \(language.fileName)")
            localModel = nil
            return
        }
        do {
            let data = try Data(contentsOf: url)
            localModel = try JSONDecoder().decode(LanguageJsonModel.self, from: data)
        } catch {
            Logger.shared.error("❌ Failed to load or parse JSON for language \(language.languageCode): \(error)")
            localModel = nil
        }
    }
}
