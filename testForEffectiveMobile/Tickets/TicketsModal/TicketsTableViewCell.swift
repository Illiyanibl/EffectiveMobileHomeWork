//
//  TicketsTableViewCell.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 1.06.24.
//

import UIKit
final class TicketsTableViewCell: UITableViewCell {

    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        return label
    }()
    lazy var imageCell: UIView = {
        let image = UIView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(hex: "#5E5F61")
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        contentView.backgroundColor = UIColor(hex: "#2F3035")
        contentView.addSubviews([cityLabel, imageCell, descriptionLabel])
    }

    func setupCell(city: String, image: String, description: String){
        cityLabel.text = city
        descriptionLabel.text = description
        guard let setupImage = UIImage(named: image) else { return }
        imageCell.layer.contents = setupImage.cgImage
    }

    private func setupConstraints(){
        let ticketsTableViewCellConstraints = ([
            imageCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCell.widthAnchor.constraint(equalToConstant: 40),
            imageCell.heightAnchor.constraint(equalToConstant: 40),
            //contentView.bottomAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: 8),

            cityLabel.topAnchor.constraint(equalTo: imageCell.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 8),

            descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 0),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 8),
        ])
        NSLayoutConstraint.activate(ticketsTableViewCellConstraints)

    }

}
