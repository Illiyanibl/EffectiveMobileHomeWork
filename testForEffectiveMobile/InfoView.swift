//
//   ScreenСover.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 29.05.24.
//

import UIKit
final class InfoView : UIView {
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 22)
        label.text = "Ожидается в новых версиях!"
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        self.addSubviews([infoLabel])
        self.backgroundColor = UIColor(hex: "#2261BC")
        setupConstraints()

    }

    private func setupConstraints(){
        let safeArea = self.safeAreaLayoutGuide
        let infoViewConstraints = ([
            infoLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate(infoViewConstraints)
    }
}
