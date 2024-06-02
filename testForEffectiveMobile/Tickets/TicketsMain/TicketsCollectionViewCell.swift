//
//  CityCollectionViewCell.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 30.05.24.
//

import UIKit
final class TicketsCollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()

    lazy var  paragraphStyle = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        return paragraphStyle
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 4
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()

    private let cityLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        return label
    }()



    lazy var airplaneIcon: UIView = {
        let view = UIView()
        let backgraung = UIImage(named: "airplane1")
        guard let backgraung else { return view}
        view.layer.contents = backgraung.cgImage
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSubView(){
        contentView.addSubviews([imageView, titleLabel, cityLabel, airplaneIcon])
    }

    func setupCell(imageName: String?, cityName: String, title: String) {
        let image = UIImage(named: imageName ?? "")
        guard let image else { return}
        imageView.image = image
        titleLabel.text = title
        cityLabel.text = cityName
        cityLabel.attributedText = NSMutableAttributedString(string: cityName, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            cityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            airplaneIcon.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
            airplaneIcon.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            airplaneIcon.heightAnchor.constraint(equalToConstant: 24),
            airplaneIcon.widthAnchor.constraint(equalTo: airplaneIcon.heightAnchor),
            //  titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

}
