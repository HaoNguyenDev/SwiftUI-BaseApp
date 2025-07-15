//
//  AppSetupUtilities.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 15/7/25.
//

import SwiftUI

class AppSetupUtilities {
    static func setLanguage(_ language: Language) {
        LanguageManager.shared.setLanguage(language: language)
    }
    
    static func setupKzAPI(url: String, token: String, language: String) throws {
/*        guard let urlVal = URL(string: Env.apiURL) else {
              throw NSError(domain: "URL invalid", code: 500)
          }
          API.shared.config(with: urlVal,
                                    token: token,
                                    platform: "ios",
                                    domain: url,
                                    language: language) */
    }
    
    static func setupOddsAPI(domain: String, signValue: String, acpId: String, sourceId: String, language: String) throws {
/*        guard let mainOddsURL = URL(string: domain) else {
            throw NSError(domain: "Odds domain invalid", code: 500)
        }
        KzOddAPIClient.shared.config(with: mainOddsURL,
                                     sign: signValue,
                                     requestid: OddsRequestUtilities.generateRequestId(),
                                     language: language,
                                     sbCompany: 1,
                                     acpId: acpId,
                                     sourceId: sourceId) */
    }
    
}
