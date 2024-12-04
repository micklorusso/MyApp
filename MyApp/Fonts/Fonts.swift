//
//  Fonts.swift
//  MyApp
//
//  Created by Lorusso, Michele on 04/12/24.
//

import UIKit

struct AppFonts {
    static func pokemonFontHollow(ofSize size: CGFloat) -> UIFont? {
        let fontName = "PokemonHollowNormal"
        if let font = UIFont(name: fontName, size: size) {
            return font
        }
        print("Failed to load font \(fontName)")
        return UIFont()
    }

    static func pokemonFontSolid(ofSize size: CGFloat) -> UIFont? {
        let fontName = "PokemonSolidNormal"
        if let font = UIFont(name: fontName, size: size) {
            return font
        }
        print("Failed to load font \(fontName)")
        return UIFont()
    }

    static func systemFontRegular(ofSize size: CGFloat) -> UIFont? {
        return UIFont.systemFont(ofSize: size)
    }

    static func systemFontBold(ofSize size: CGFloat) -> UIFont? {
        return UIFont.boldSystemFont(ofSize: size)
    }

}
