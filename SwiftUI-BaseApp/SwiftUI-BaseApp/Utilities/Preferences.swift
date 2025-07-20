//
//  Preferences.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//

//import Foundation
//
//extension Defaults {
//    static let username = DefaultsKey<String?>("userName", nil)
//    static let userToken = DefaultsKey<String?>("userToken", nil)
//    static let signature = DefaultsKey<String?>("signature", nil)
//    static let userId = DefaultsKey<String?>("userId", nil)
//    static let referralCode = DefaultsKey<String?>("referralCode", nil)
//    static let endOfDay = DefaultsKey<TimeInterval?>("endOfDay", nil)
//    static let point = DefaultsKey<Double?>("point", nil)
//    static let lastShowCheckin = DefaultsKey<Date?>("lastShowCheckin", nil)
//    static let colorSchemeOption = DefaultsKey<ColorSchemeOption>("colorSchemeOption", .system)
//    static let userLanguage = DefaultsKey<Language>("userLanguage",
//                                                    LanguageCode.english.getLanguage())
//    static let languageVersion = DefaultsKey<Int>("languageVersion", 0)
//}
//
//let Preferences = UserDefaults.standard
//
//class Defaults {
//    fileprivate init() {}
//}
//
//class DefaultsKey<ValueType>: Defaults {
//    let key: String
//    let defaultValue: ValueType
//
//    init(_ key: String, _ defaultValue: ValueType) {
//        self.key = key
//        self.defaultValue = defaultValue
//    }
//}
//
//extension UserDefaults {
//    subscript(key: DefaultsKey<Bool>) -> Bool {
//        get {
//            if let value = value(forKey: key.key) as? Bool {
//                return value
//            } else {
//                return key.defaultValue
//            }
//        }
//        set { set(newValue, forKey: key.key) }
//    }
//    
//    subscript(key: DefaultsKey<Double>) -> Double {
//        get {
//            if let value = value(forKey: key.key) as? Double {
//                return value
//            } else {
//                return key.defaultValue
//            }
//        }
//        set { set(newValue, forKey: key.key) }
//    }
//}
//extension UserDefaults {
//    subscript(key: DefaultsKey<String>) -> String {
//        get { return string(forKey: key.key) ?? key.defaultValue }
//        set { set(newValue, forKey: key.key) }
//    }
//
//    subscript(key: DefaultsKey<String?>) -> String? {
//        get { return string(forKey: key.key) ?? key.defaultValue }
//        set { set(newValue, forKey: key.key) }
//    }
//}
//extension UserDefaults {
//    subscript(key: DefaultsKey<Int>) -> Int {
//        get {
//            if let value = value(forKey: key.key) as? Int {
//                return value
//            } else {
//                return key.defaultValue
//            }
//        }
//        set { set(newValue, forKey: key.key) }
//    }
//}
//
//extension UserDefaults {
//    subscript(key: DefaultsKey<[String: TimeInterval]>) -> [String: TimeInterval] {
//        get {
//            if let value = value(forKey: key.key) as? [String: TimeInterval] {
//                return value
//            } else {
//                return key.defaultValue
//            }
//        }
//        set { set(newValue, forKey: key.key) }
//    }
//
//    subscript(key: DefaultsKey<Double?>) -> Double? {
//        get {
//            if let data = value(forKey: key.key) as? Double {
//                return data
//            } else {
//                return key.defaultValue
//            }
//        }
//        set {
//            if let unwrap = newValue {
//                set(unwrap, forKey: key.key)
//            } else {
//                set(nil, forKey: key.key)
//            }
//        }
//    }
//
//    subscript(key: DefaultsKey<Bool?>) -> Bool? {
//        get {
//            if let data = value(forKey: key.key) as? Bool {
//                return data
//            } else {
//                return key.defaultValue
//            }
//        }
//        set {
//            if let unwrap = newValue {
//                set(unwrap, forKey: key.key)
//            } else {
//                set(nil, forKey: key.key)
//            }
//        }
//    }
//
//    subscript(key: DefaultsKey<Date?>) -> Date? {
//        get {
//            if let data = value(forKey: key.key) as? TimeInterval {
//                return Date(timeIntervalSince1970: data)
//            } else {
//                return key.defaultValue
//            }
//        }
//        set {
//            set(newValue?.timeIntervalSince1970, forKey: key.key)
//        }
//    }
//    
//    subscript(key: DefaultsKey<ColorSchemeOption>) -> ColorSchemeOption {
//        get {
//            if let data = value(forKey: key.key) as? String {
//                return ColorSchemeOption(rawValue: data) ?? .light
//            } else {
//                return key.defaultValue
//            }
//        }
//        set {
//            set(newValue.rawValue, forKey: key.key)
//        }
//    }
//}
//
//extension UserDefaults {
//    subscript(key: DefaultsKey<Language>) -> Language {
//        get {
//            if let data = value(forKey: key.key) as? Data,
//                let lang = try? PropertyListDecoder().decode(Language.self, from: data) {
//                return lang
//            } else {
//                return key.defaultValue
//            }
//        }
//        set {
//            set(try? PropertyListEncoder().encode(newValue), forKey: key.key)
//        }
//    }
//}
