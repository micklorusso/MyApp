//
//  Util.swift
//  MyApp
//
//  Created by Lorusso, Michele on 27/11/24.
//

import FirebaseAuth
import Foundation
import UIKit

class Util {

    static func loadImage(imageStr: String?, in imageView: UIImageView) {
        if let image = imageStr {
            if let imageUrl = URL(string: image) {
                URLSession.shared.dataTask(with: imageUrl) {
                    data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    } else {
                        print(
                            "Failed to load image: \(error?.localizedDescription ?? "Unknown error")"
                        )
                    }
                }.resume()
            } else {
                print("Invalid URL")
            }
        }
    }

    static func loadTypes(
        types: [String], in typesStackView: UIStackView, labelColor: UIColor,
        font: UIFont?
    ) {
        let currentTypes = typesStackView.arrangedSubviews.compactMap {
            ($0 as? UILabel)?.text
        }
        if currentTypes != types {
            typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            for type in types {
                let typeLabel = UILabel()
                typeLabel.text = type
                typeLabel.font = font
                typeLabel.textColor = labelColor
                typesStackView.addArrangedSubview(typeLabel)
            }
        }
    }

}
