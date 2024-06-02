//
//  TicketsViewController.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 28.05.24.
//


import UIKit
final class TicketsViewController: UIViewController {

    private (set) var ticketsViewModel: TicketsViewModelOutput = TicketsMainViewModel()
    private (set) var  offers: [Offers] = []
    var mainAction : ((MainActionCases) -> Void)?

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        var shadows = UIView()
        shadows.frame = CGRect(x: 0, y: 0, width: 172, height: 52)
        shadows.clipsToBounds = false
        label.addSubview(shadows)
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.textColor = UIColor(hex: "#D9D9D9")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 22)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        paragraphStyle.alignment = .center
        // Line height: 26.4 pt
        label.attributedText = NSMutableAttributedString(string: "Поиск дешевых авиабилетов", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.184, green: 0.188, blue: 0.208, alpha: 1).cgColor
        view.layer.cornerRadius = 16
        return view
    }()
    private lazy var findTicketstView: UIView = {
        let view = UIView()
        var shadows = UIView()
        shadows.frame =  CGRect(x: 0, y: 0, width: 296, height: 90)
        shadows.clipsToBounds = false
        view.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 16)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        var shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        view.addSubview(shapes)

        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 0.243, green: 0.247, blue: 0.263, alpha: 1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        shapes.layer.cornerRadius = 16
        return view
    }()
    lazy var findIcon: UIView = {
        let view = UIView()
        let backgraung = UIImage(named: "find")
        guard let backgraung else { return view}
        view.layer.contents = backgraung.cgImage
        return view
    }()

    lazy var findViewGroup: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        // stackView.layer.cornerRadius = 10
        return stackView
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

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#9F9F9F9F")?.withAlphaComponent(0.62)
        return view
    }()

    private let subTitleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 22)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        label.attributedText = NSMutableAttributedString(string: "Музыкально отлететь", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()

    lazy var ticketsCollection: UICollectionView = {
        let loyut = UICollectionViewFlowLayout()
        loyut.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: loyut)
        collection.dataSource = self
        collection.delegate = self
        collection.register(TicketsCollectionViewCell.self, forCellWithReuseIdentifier: TicketsCollectionViewCell.identifier)
        return collection
    }()

    override func viewDidLoad() {
        setupUI()
        setupGesture()
        bindTicketsViewModel()
        ticketsViewModel.changeStateIfNeeded()
    }

    private func setupUI(){
        findViewGroup.addArrangedSubviews([findDeparture, separatorView,findArrived])
        findTicketstView.addSubviews([findIcon, findViewGroup])
        backView.addSubviews([findTicketstView])
        view.addSubviews([titleLabel, backView, subTitleLabel, ticketsCollection])
        setupConstraints()
    }

    private func setupGesture(){
        let tapFindArrived = UITapGestureRecognizer(target: self, action: #selector(tapArrived))
        findArrived.addGestureRecognizer(tapFindArrived)
    }

    @objc func tapArrived(){
        self.mainAction?(.selectedDepatrure(findDeparture.text ?? ""))
    }

    private func bindTicketsViewModel() {
        ticketsViewModel.currentState = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                print("initial")
            case .loading:
                print("loading")
            case .loaded(let offers):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.offers = offers
                    ticketsCollection.isHidden = false
                    ticketsCollection.reloadData()
                }
            case .error:
                print("error")
            }
        }
    }

    private func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        let ticketsViewControllerConstraints = ([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 58),
            titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 172),
            titleLabel.heightAnchor.constraint(equalToConstant: 54),
            backView.widthAnchor.constraint(equalToConstant: 328),
            backView.heightAnchor.constraint(equalToConstant: 122),
            backView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            backView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 148),

            findTicketstView.widthAnchor.constraint(equalToConstant: 296),
            findTicketstView.heightAnchor.constraint(equalToConstant: 90),
            findTicketstView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            findTicketstView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),

            findIcon.widthAnchor.constraint(equalToConstant: 24),
            findIcon.heightAnchor.constraint(equalToConstant: 24),
            findIcon.leadingAnchor.constraint(equalTo: findTicketstView.leadingAnchor, constant: 8),
            findIcon.centerYAnchor.constraint(equalTo: findTicketstView.centerYAnchor),

            findViewGroup.topAnchor.constraint(equalTo: findTicketstView.topAnchor, constant: 16),
            findViewGroup.leadingAnchor.constraint(equalTo: findTicketstView.leadingAnchor, constant: 49),
            findViewGroup.trailingAnchor.constraint(equalTo: findTicketstView.trailingAnchor, constant: -8),
            findViewGroup.bottomAnchor.constraint(equalTo: findTicketstView.bottomAnchor, constant: -16),

            findArrived.heightAnchor.constraint(equalTo: findDeparture.heightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),

            subTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            subTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 302),

            ticketsCollection.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 354),
            ticketsCollection.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            ticketsCollection.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            ticketsCollection.heightAnchor.constraint(equalToConstant: 214),

        ])
        NSLayoutConstraint.activate(ticketsViewControllerConstraints)
    }
}
