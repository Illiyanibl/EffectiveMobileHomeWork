//
//  TicketDetailsTableViewCell.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import UIKit
final class TicketDetailsTableViewCell: UITableViewCell {
    let timeFormatter = DateFormatter()
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

    lazy var timeLabelDeparture: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-MediumItalic", size: 14)
        return label
    }()

    lazy var timeLabelArrived: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-MediumItalic", size: 14)
        return label
    }()

    lazy var timeSeparatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#9F9F9F")
        label.text = "—"
        label.font = UIFont(name: "SFProDisplay-MediumItalic", size: 14)
        return label
    }()

    lazy var aeroportLabelDeparture: UILabel = {
        let label = UILabel()
        var view = UILabel()
        label.textColor = UIColor(hex: "#9F9F9F")
        label.font = UIFont(name: "SFProDisplay-MediumItalic", size: 14)
        return label
    }()


    lazy var aeroportLabelArrived: UILabel = {
        let label = UILabel()
        var view = UILabel()
        label.textColor = UIColor(hex: "#9F9F9F")
        label.font = UIFont(name: "SFProDisplay-MediumItalic", size: 14)
        return label
    }()

    lazy var timeIntervalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14) // в макете либо шрифт не тот либо размер
        return label
    }()

    lazy var hasTransferLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14) // тоже самое
        label.text = "/ Без пересадок"
        label.isHidden = true
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupData()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
        detailView.addSubviews([colorView, timeLabelArrived, timeSeparatorLabel, timeLabelDeparture, aeroportLabelDeparture, aeroportLabelArrived])
        contentView.addSubviews([badgeView, titleLabel, detailView, timeIntervalLabel, hasTransferLabel])
    }

    private func setupData(){
        timeFormatter .dateFormat = "HH:mm"
    }

    func setupCell(price: Int, timeInterval: String?, departure: Date?, arrival: Date?, pointFrom: String, pointTo: String, hasTransfer: Bool){
        titleLabel.text = (priceFormater.string(from: price as NSNumber) ?? "") + " ₽"
        timeInterval != nil ? (timeIntervalLabel.text = (timeInterval ?? "?") + "ч в пути") : ()
        aeroportLabelArrived.text = pointTo
        aeroportLabelDeparture.text = pointFrom
        hasTransferLabel.isHidden = hasTransfer

        guard let departure, let arrival else { return }
        timeLabelDeparture.text = timeFormatter.string(from: departure)

        timeLabelArrived.text = timeFormatter.string(from: arrival)
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

            timeLabelDeparture.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 8),
            timeLabelDeparture.topAnchor.constraint(equalTo: detailView.topAnchor),

            timeSeparatorLabel.topAnchor.constraint(equalTo: detailView.topAnchor),
            timeSeparatorLabel.leadingAnchor.constraint(equalTo: timeLabelDeparture.trailingAnchor),

            timeLabelArrived.topAnchor.constraint(equalTo: detailView.topAnchor),
            timeLabelArrived.leadingAnchor.constraint(equalTo: timeSeparatorLabel.trailingAnchor),

            aeroportLabelDeparture.topAnchor.constraint(equalTo: timeLabelDeparture.bottomAnchor, constant: 0),
            aeroportLabelDeparture.leadingAnchor.constraint(equalTo: timeLabelDeparture.leadingAnchor),

            aeroportLabelArrived.topAnchor.constraint(equalTo: timeLabelArrived.bottomAnchor),
            aeroportLabelArrived.leadingAnchor.constraint(equalTo: timeLabelArrived.leadingAnchor),

            timeIntervalLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 0),
            timeIntervalLabel.trailingAnchor.constraint(equalTo: hasTransferLabel.trailingAnchor, constant: -4),
            timeIntervalLabel.widthAnchor.constraint(equalToConstant: 171),

            hasTransferLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 0),
            hasTransferLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),


        ])
        NSLayoutConstraint.activate(tableViewCellConstraints)

    }
}
