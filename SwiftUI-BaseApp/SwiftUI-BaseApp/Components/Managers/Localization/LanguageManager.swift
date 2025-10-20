//
//  LanguageManager.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 15/7/25.
//


import Foundation
/// @Observable will support notification to all views using the localized() extension chain to reload the view to get the new value, no need inject environment LanguageManager object
@Observable final class LanguageManager {
    static let shared = LanguageManager()
    private(set) var language: Language {
        didSet {
            loadLocalModel()
        }
    }
    
    private var localModel: LanguageJsonModel?
    var localVersion: Int { localModel?.version ?? 0 }

    let allSupportLanguages = [
        LanguageCode.eng.getLanguage(),
        LanguageCode.chs.getLanguage(),
        LanguageCode.vi.getLanguage()
    ]
    
    private init() {
        language = LanguageCode.eng.getLanguage() //userSettings.getLanguage(languageCode).getLanguage()
        loadLocalModel()
    }
    
    func setLanguage(language: Language) {
        let selectedLanguage = allSupportLanguages.first(where: { $0.languageCode == language.languageCode }) ?? language
        self.language = selectedLanguage
        loadLocalModel()
    }

    func valueForKey(_ key: String) -> String {
        return localModel?.data[key.lowercased()] ?? key
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
