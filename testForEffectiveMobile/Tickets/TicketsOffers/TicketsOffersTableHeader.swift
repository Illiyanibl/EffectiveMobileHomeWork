//
//  TicketsOffersTableHeader.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import UIKit

final class TicketsOffersTableHeader: UIView {

    lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        label.attributedText = NSMutableAttributedString(string: "Прямые рейсы", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label

    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        self.addSubviews([titleLabel])
    }

    private func setupConstraints(){
        let viewHaderConstraints = ([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate(viewHaderConstraints)
    }

}
