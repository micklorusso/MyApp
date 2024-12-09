//
//  LanguageManager.swift
//  MyApp
//
//  Created by Lorusso, Michele on 29/11/24.
//

import Foundation
import UIKit

class LanguageManager {
    static func switchLanguage(to languageCode: String) {
        Bundle.setLanguage(languageCode)

        guard
            let sceneDelegate = UIApplication.shared.connectedScenes.first?
                .delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else {
            return
        }

        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
            sceneDelegate.coordinator = mainCoordinator
            sceneDelegate.window = window
            window.rootViewController = navigationController
            window.makeKeyAndVisible()

            mainCoordinator.start()
    }

    static func getCurrentLanguageCode() -> String {
        UserDefaults.standard.string(forKey: Localization.languageKey)
            ?? Localization.defaultLanguage
    }
}

extension Bundle {
    private static var onLanguageDispatch: Void = {
        object_setClass(Bundle.main, LocalizedBundle.self)
    }()

    class LocalizedBundle: Bundle, @unchecked Sendable {
        override func localizedString(
            forKey key: String, value: String?, table tableName: String?
        ) -> String {
            let languageCode = LanguageManager.getCurrentLanguageCode()
            let bundle =
                Bundle(
                    path: Bundle.main.path(
                        forResource: languageCode, ofType: "lproj")!) ?? self
            return bundle.localizedString(
                forKey: key, value: value, table: tableName)
        }
    }

    static func initializeLanguage() {
        _ = onLanguageDispatch
    }

    static func setLanguage(_ language: String) {
        UserDefaults.standard.set(
            language, forKey: Localization.languageKey)
        UserDefaults.standard.synchronize()
        _ = onLanguageDispatch
    }
}
