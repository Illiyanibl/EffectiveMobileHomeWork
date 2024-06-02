//
//  TicketDetailsTableViewCell.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import UIKit
final class TicketDetailsTableViewCell: UITableViewCell {

    let priceFormater = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    lazy var badgeView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 22)
        label.text = " ₽"
        return label
    }()

    lazy var detailView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(hex: "#FF5E5E")
        return view
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var aeroportLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var timeIntervalLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var hasTransferLabel: UILabel = {
        let label = UILabel()
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
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
        detailView.addSubviews([colorView])
        contentView.addSubviews([badgeView, titleLabel, detailView, timeIntervalLabel])
    }

    func setupCell(price: Int, timeInterval: String?, hasTransfer: Bool){
        titleLabel.text = (priceFormater.string(from: price as NSNumber) ?? "") + " ₽"
        timeInterval != nil ? timeIntervalLabel.text = timeInterval : ()
    }

    private func setupConstraints() {
        let tableViewCellConstraints = ([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            detailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 58),
            detailView.heightAnchor.constraint(equalToConstant: 38),
            detailView.widthAnchor.constraint(equalToConstant: 121),
           // detailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),

            colorView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
            colorView.centerYAnchor.constraint(equalTo: detailView.centerYAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 24),
            colorView.widthAnchor.constraint(equalToConstant: 24),

            timeIntervalLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 0),
            timeIntervalLabel.leadingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: 16),
            timeIntervalLabel.widthAnchor.constraint(equalToConstant: 171),



        ])
        NSLayoutConstraint.activate(tableViewCellConstraints)

    }
}
