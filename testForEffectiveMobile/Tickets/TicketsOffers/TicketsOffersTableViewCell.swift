//
//  TicketsOffersTableViewCell.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import UIKit
final class TicketsOffersTableViewCell: UITableViewCell {
    
    lazy var paragraphStyle = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        return paragraphStyle
    }()

    let priceFormater = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Mediumitalic", size: 14)
        label.attributedText = NSMutableAttributedString(string: "Уральские авиалинии", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#2261BC")
        label.font = UIFont(name: "SFProDisplay-Mediumitalic", size: 14)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular.otf", size: 14)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 1
        return label
    }()
    
    lazy var colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
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
        contentView.backgroundColor = UIColor(hex: "#1D1E20")
        contentView.addSubviews([titleLabel, priceLabel, colorView, timeLabel])
    }
    func setupCell(id:Int, title: String, price: Int, timeRange: [String]){
        titleLabel.attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let formatedPrice = priceFormater.string(from: price as NSNumber) ?? ""
        priceLabel.attributedText = NSMutableAttributedString(string: formatedPrice + " ₽ >", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        var timeString = ""
        timeRange.forEach(){ timeString += $0 + " "}
        print(timeString)
        timeLabel.attributedText = NSMutableAttributedString(string: timeString, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        switch id {
        case 1:
            colorView.backgroundColor = UIColor(hex: "#FF5E5E")
        case 10:
            colorView.backgroundColor = UIColor(hex: "#2261BC")
        default:
            break
        }
    }
    
    private func setupConstraints(){
        let tableViewCellConstraints = ([
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            colorView.heightAnchor.constraint(equalToConstant: 24),
            colorView.widthAnchor.constraint(equalToConstant: 24),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 8),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            timeLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 8),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate(tableViewCellConstraints)
    }
}
