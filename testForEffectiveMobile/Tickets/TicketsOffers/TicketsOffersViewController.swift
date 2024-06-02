//
//  TicketsOffersViewController.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 1.06.24.
//

import UIKit
final class TicketsOffersViewController: UIViewController {
    var departure: String?
    var arrived: String?
    var offersAction : ((OffersActionCases) -> Void)?
    private (set) var ticketsOffersViewModel: TicketsOffersViewModelOutput = TicketsOffersViewModel()
    private (set) var ticketsOffers: [TicketsOffers] = []

    private lazy var findTicketstView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.backgroundColor = UIColor(hex: "#2F3035")

        let shadowPath0 = UIBezierPath(roundedRect: view.bounds, cornerRadius: 16)
        view.layer.shadowPath = shadowPath0.cgPath
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.cornerRadius = 16
        return view
    }()
    lazy var findDeparture: UITextField = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.09
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.placeholder = "Откуда - Москва"
        textField.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        textField.indent(size: 1)
        //  textField.delegate = self
        return textField
    }()

    lazy var findArrived: UITextField = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.09
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.placeholder = "Куда - Турция"
        textField.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        textField.indent(size: 1)
        //    textField.delegate = self
        return textField
    }()

    lazy var findViewGroup: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        return stackView
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#9F9F9F9F")?.withAlphaComponent(0.62)
        return view
    }()

    lazy var iconClose: UIView = {
        let imageView = UIView()
        let backgraung = UIImage(named: "close")
        guard let backgraung else { return view}
        imageView.layer.contents = backgraung.cgImage
        return imageView
    }()

    lazy var iconBackView: UIView = {
        let imageView = UIView()
        return imageView
    }()
    lazy var iconBack: UIView = {
        let imageView = UIView()
        let backgraung = UIImage(named: "laeftArrow")
        guard let backgraung else { return view}
        imageView.layer.contents = backgraung.cgImage
        return imageView
    }()

    lazy var iconRevert: UIView = {
        let imageView = UIView()
        let backgraung = UIImage(named: "revert")
        guard let backgraung else { return view}
        imageView.layer.contents = backgraung.cgImage
        return imageView
    }()

    lazy var buttonCollection: UICollectionView = {
        let loyut = UICollectionViewFlowLayout()
        loyut.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: loyut)
        //   collection.dataSource = self
        //   collection.delegate = self
        //    collection.register(TicketsCollectionViewCell.self, forCellWithReuseIdentifier: TicketsCollectionViewCell.identifier)
        return collection
    }()

    lazy var ticketsOffersTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(hex: "#1D1E20")
        table.layer.cornerRadius = 16
        table.dataSource = self
        table.delegate = self
        table.register(TicketsOffersTableViewCell.self, forCellReuseIdentifier: TicketsOffersTableViewCell.identifier)
        return table
    }()

    lazy var allTicketsButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(hex: "#2261BC")
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Mediumitalic", size: 16)
        let actionButtonAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.underlineStyle: 0]
        let actionTitle = NSMutableAttributedString(string: "Посмотреть все билеты", attributes: actionButtonAttributes)
        button.setAttributedTitle(NSAttributedString(attributedString: actionTitle), for: .normal)
        return button
    }()

    @objc private func buttonTapped(){
        offersAction?(.ticketsForDirection(findDeparture.text ?? "Москва", findArrived.text ?? "Стамбул"))
    }

    override func viewDidLoad() {
        setupUI()
        setupData()
        setupGesture()
        setupConstraints()
        bindTicketsOffersViewModel()
    }


    override func viewWillAppear(_ animated: Bool) {
        setupData()
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setupUI(){
        findViewGroup.addArrangedSubviews([findDeparture, separatorView, findArrived])
        iconBackView.addSubviews([iconBack])
        findTicketstView.addSubviews([findViewGroup, iconBackView, iconClose, iconRevert])
        view.addSubviews([findTicketstView, ticketsOffersTable, allTicketsButton])

    }

    private func setupData() {
        ticketsOffersViewModel.changeStateIfNeeded()
        findDeparture.text = departure
        findArrived.text = arrived
    }

    private func setupGesture(){
        let tapRevertIcon = UITapGestureRecognizer(target: self, action: #selector(tapRevert))
        iconRevert.addGestureRecognizer(tapRevertIcon)
    }

    @objc func tapRevert(){
        let revert  = findDeparture.text
        findDeparture.text = findArrived.text
        findArrived.text = revert
    }

    private func bindTicketsOffersViewModel() {
        ticketsOffersViewModel.currentState = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                print("initial")
            case .loading:
                print("loading")
            case .loaded(let ticketsOffers):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.ticketsOffers = ticketsOffers
                    ticketsOffersTable.isHidden = false
                    ticketsOffersTable.reloadData()
                }
            case .error:
                print("error")
            }
        }
    }

    private func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        let viewControllerConstraints = ([
            findTicketstView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            findTicketstView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            findTicketstView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 79),
            findTicketstView.heightAnchor.constraint(equalToConstant: 96),

            iconBackView.heightAnchor.constraint(equalToConstant: 24),
            iconBackView.widthAnchor.constraint(equalToConstant: 24),
            iconBackView.leadingAnchor.constraint(equalTo: findTicketstView.leadingAnchor, constant: 8),
            iconBackView.centerYAnchor.constraint(equalTo: findTicketstView.centerYAnchor),

            iconBack.heightAnchor.constraint(equalToConstant: 12),
            iconBack.widthAnchor.constraint(equalToConstant: 14),
            iconBack.centerXAnchor.constraint(equalTo: iconBackView.centerXAnchor),
            iconBack.centerYAnchor.constraint(equalTo: iconBackView.centerYAnchor),

            findViewGroup.leadingAnchor.constraint(equalTo: iconBackView.trailingAnchor, constant: 8),
            findViewGroup.trailingAnchor.constraint(equalTo: findTicketstView.trailingAnchor, constant: -16),
            findViewGroup.topAnchor.constraint(equalTo: findTicketstView.topAnchor, constant: 16),
            findViewGroup.bottomAnchor.constraint(equalTo: findTicketstView.bottomAnchor, constant: -16),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            findDeparture.heightAnchor.constraint(equalTo: findArrived.heightAnchor),

            iconClose.heightAnchor.constraint(equalToConstant: 24),
            iconClose.widthAnchor.constraint(equalToConstant: 24),
            iconClose.trailingAnchor.constraint(equalTo: findViewGroup.trailingAnchor),
            iconClose.centerYAnchor.constraint(equalTo: findArrived.centerYAnchor),

            iconRevert.heightAnchor.constraint(equalToConstant: 24),
            iconRevert.widthAnchor.constraint(equalToConstant: 24),
            iconRevert.trailingAnchor.constraint(equalTo: findViewGroup.trailingAnchor),
            iconRevert.centerYAnchor.constraint(equalTo: findDeparture.centerYAnchor),

            ticketsOffersTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            ticketsOffersTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            ticketsOffersTable.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 238),
            ticketsOffersTable.heightAnchor.constraint(equalToConstant: 288),

            allTicketsButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            allTicketsButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            allTicketsButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 544),
            allTicketsButton.heightAnchor.constraint(equalToConstant: 42),
        ])
        NSLayoutConstraint.activate(viewControllerConstraints)
    }
}

