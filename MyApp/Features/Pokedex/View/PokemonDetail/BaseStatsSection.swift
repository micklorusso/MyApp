//
//  BaseStatsSection.swift
//  MyApp
//
//  Created by Lorusso, Michele on 28/11/24.
//

import UIKit

class BaseStatsSection: UIView {
    @IBOutlet weak var verticalStackView: UIStackView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewInit()
    }

    func configure(pokemon: PokemonDetailModel) {
        for (index, stat) in pokemon.stats.enumerated() {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.alignment = .center
            horizontalStack.distribution = .fillEqually
            horizontalStack.spacing = 15
            horizontalStack.translatesAutoresizingMaskIntoConstraints = false
            horizontalStack.heightAnchor.constraint(equalToConstant: 54)
                .isActive = true

            let nameLabel = UILabel()
            nameLabel.text = stat.name
            nameLabel.textAlignment = .center

            let valueLabel = UILabel()
            valueLabel.text = "\(Int(stat.value))"
            valueLabel.textAlignment = .center

            let progressBar = UIProgressView(progressViewStyle: .default)
            progressBar.progress = stat.valueFloat
            progressBar.tintColor = index % 2 == 0 ? UIColor.green : UIColor.red

            horizontalStack.addArrangedSubview(nameLabel)
            horizontalStack.addArrangedSubview(valueLabel)
            horizontalStack.addArrangedSubview(progressBar)

            verticalStackView.addArrangedSubview(horizontalStack)
        }
    }

}
