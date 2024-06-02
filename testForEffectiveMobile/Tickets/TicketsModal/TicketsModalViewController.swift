//
//  TicketsModalViewController.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 1.06.24.
//

import UIKit
final class TicketsModalViewController: UIViewController {

    var departureFrom: String?
    var modalAction : ((ModalActionCases) -> Void)?
    var popularPlaces: [TicketsModalModel] = []
    var ticketsModalService: TicketsModalModelProtocol?

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
    
    lazy var findViewGroup: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        return stackView
    }()

    lazy var topFindViewGroup: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()

    private let topSeparatorView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var bottomFindViewGroup: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    private let botomSeparatorView: UIView = {
        let view = UIView()
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
        textField.delegate = self
        return textField
    }()

    lazy var iconDeparture: UIView = {
        let imageView = UIView()
        let backgraung = UIImage(named: "airplane2")
        guard let backgraung else { return view}
        imageView.layer.contents = backgraung.cgImage
        return imageView
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
        textField.delegate = self
        return textField
    }()

    lazy var iconArrived: UIView = {
        let imageView = UIView()
        let backgraung = UIImage(named: "find")
        guard let backgraung else { return view}
        imageView.layer.contents = backgraung.cgImage
        return imageView
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

    lazy var shortcutsView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    lazy var popularPlacesTableView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#2F3035")
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()


    lazy var  popularPlacesTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor(hex: "#2F3035")
        table.register(TicketsTableViewCell.self, forCellReuseIdentifier: TicketsTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupGesture()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }

    private func setupUI(){
        view.backgroundColor = UIColor(hex: "#242529")
        setupSubView()
    }
    private func setupData(){
        popularPlaces = ticketsModalService?.getModel() ?? []
        popularPlacesTable.reloadData()
        departureFrom != nil ? findDeparture.text = departureFrom : ()
    }

    func setupArrived(_ city: String) {
        findArrived.text = city
    }

    private func setupSubView(){
        topFindViewGroup.addArrangedSubviews([topSeparatorView, findDeparture])
        bottomFindViewGroup.addArrangedSubviews([botomSeparatorView, findArrived])
        findViewGroup.addArrangedSubviews([topFindViewGroup, separatorView, bottomFindViewGroup])
        findTicketstView.addSubviews([findViewGroup, iconDeparture, iconArrived, iconClose])
        popularPlacesTableView.addSubviews([popularPlacesTable])
        view.addSubviews([findTicketstView, shortcutsView, popularPlacesTableView])
    }

    private func setupGesture(){
        let tapIconCloseGesture = UITapGestureRecognizer(target: self, action: #selector(tapIconClose))
        iconClose.addGestureRecognizer(tapIconCloseGesture)
    }

    @objc func tapIconClose(){
        findArrived.text = ""
    }

    private func setupConstraints(){
        let ticketsModalViewControllerConstraints = ([
            findTicketstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            findTicketstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            findTicketstView.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            findTicketstView.heightAnchor.constraint(equalToConstant: 96),

            findViewGroup.leadingAnchor.constraint(equalTo: findTicketstView.leadingAnchor, constant: 16),
            findViewGroup.trailingAnchor.constraint(equalTo: findTicketstView.trailingAnchor, constant: -16),
            findViewGroup.topAnchor.constraint(equalTo: findTicketstView.topAnchor, constant: 16),
            findViewGroup.bottomAnchor.constraint(equalTo: findTicketstView.bottomAnchor, constant: -16),

            separatorView.heightAnchor.constraint(equalToConstant: 1),
            topFindViewGroup.heightAnchor.constraint(equalTo: bottomFindViewGroup.heightAnchor),
            topSeparatorView.widthAnchor.constraint(equalToConstant: 24),
            botomSeparatorView.widthAnchor.constraint(equalToConstant: 24),

            iconDeparture.widthAnchor.constraint(equalToConstant: 24),
            iconDeparture.heightAnchor.constraint(equalToConstant: 24),
            iconDeparture.trailingAnchor.constraint(equalTo: findDeparture.leadingAnchor, constant: -2),
            iconDeparture.bottomAnchor.constraint(equalTo: findDeparture.bottomAnchor, constant: -2),

            iconArrived.widthAnchor.constraint(equalToConstant: 24),
            iconArrived.heightAnchor.constraint(equalToConstant: 24),
            iconArrived.trailingAnchor.constraint(equalTo: findArrived.leadingAnchor, constant: -2),
            iconArrived.bottomAnchor.constraint(equalTo: findArrived.bottomAnchor, constant: -2),

            iconClose.widthAnchor.constraint(equalToConstant: 24),
            iconClose.heightAnchor.constraint(equalToConstant: 24),
            iconClose.trailingAnchor.constraint(equalTo: findViewGroup.trailingAnchor),
            iconClose.centerYAnchor.constraint(equalTo: iconArrived.centerYAnchor),

            shortcutsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            shortcutsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 168),
            shortcutsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            shortcutsView.heightAnchor.constraint(equalToConstant: 90),
            
            popularPlacesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            popularPlacesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            popularPlacesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 284),
            popularPlacesTableView.heightAnchor.constraint(equalToConstant: 216),

            popularPlacesTable.leadingAnchor.constraint(equalTo: popularPlacesTableView.leadingAnchor, constant: 16),
            popularPlacesTable.trailingAnchor.constraint(equalTo: popularPlacesTableView.trailingAnchor, constant: -16),
            popularPlacesTable.topAnchor.constraint(equalTo: popularPlacesTableView.topAnchor, constant: 16),
            popularPlacesTable.bottomAnchor.constraint(equalTo: popularPlacesTableView.bottomAnchor),


        ])
        NSLayoutConstraint.activate(ticketsModalViewControllerConstraints)
    }
}
