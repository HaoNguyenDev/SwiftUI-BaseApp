//
//  LanguageManager.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 15/7/25.
//


import Foundation

final class LanguageManager {
    static let shared = LanguageManager()
    
    var localVersion: Int = 0
    var currentVersion: Int {
        get {
            return Preferences[.languageVersion]
        }
        set {
            Preferences[.languageVersion] = newValue
        }
    }
    
    let allSupportLanguages = [LanguageCode.english.getLanguage(),
                               LanguageCode.china.getLanguage(),
                               LanguageCode.vietnam.getLanguage()]
    
    private let fileManager = FileManager.default
    private let LocalizeBundleName = "Localizable.bundle"
    private let LanguageFolder       = "languages.lproj"
    private var localModel: LanguageJsonModel?
    private(set) var language: Language! {
        didSet {
            getLocalModel()
        }
    }
    
    private lazy var bundle: Bundle? = {
        fileManager.getFolderPath(bundleName: LocalizeBundleName, folderPath: LanguageFolder)
    }()
    
    private init() {
        print("Init language: \(Preferences[.userLanguage])")
        language = Preferences[.userLanguage]
//        language = LanguageCode.vietnam.getLanguage()
        localVersion = localModel?.version ?? 0
    }
    
    public func setLanguage(language: Language) {
        // Make sure Language save is always right format
        let language = allSupportLanguages.first(where: { $0.displayName == language.displayName }) ?? language
        self.language = language
        Preferences[.userLanguage] = language
        //TODO: Set language code for NetworkManager here
    }
    
    private func getLocalModel() {
        localModel = {
            guard let defaultLangURL = Bundle.main.url(forAuxiliaryExecutable: language.fileName) else {
                return nil
            }
            return getLangModelByLocalURL(defaultLangURL)
        }()
    }
    
    public func valueForKey(_ key: String) -> String {
        var value: String? = bundle?.localizedString(forKey: key, value: nil, table: language.languageCode)
        // In case localizedString not found, search for value by local file's dictionary
        if value == key {
            value = localModel?.data[key]
        }
        return value ?? key
    }
}

private extension LanguageManager {
    private func getLangModelByLocalURL(_ url: URL) -> LanguageJsonModel? {
        guard let jsonString = try? String(contentsOf: url, encoding: .utf8),
              let data = jsonString.data(using: .utf8) else {
            return nil
        }
        return try? JSONDecoder().decode(LanguageJsonModel.self, from: data)
    }
}
