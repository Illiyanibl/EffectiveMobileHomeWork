//
//  TicketDetailsViewController.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 2.06.24.
//

import UIKit
final class TicketDetailsViewController: UIViewController {
    var departure: String?
    var arrived: String?
    private (set) var ticketsDetailsViewModel: TicketsDetailsViewModelOutput = TicketDetailsViewModel()
    private (set) var tickets: [Tickets] = []
    
    lazy var backView: UIView = {
        let view = UIView()
        let backgraung = UIImage(named: "backArrow")
        guard let backgraung else { return view}
        view.layer.contents = backgraung.cgImage
        view.tintColor = UIColor(hex: "#2261BC")
        return view
    }()
    
    lazy var detailsFindView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#242529")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#9F9F9F")
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        return label
    }()
    
    lazy var ticketsDetailsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = UIColor(hex: "#1D1E20")
        table.layer.cornerRadius = 16
        table.dataSource = self
        table.delegate = self
        table.register(TicketDetailsTableViewCell.self, forCellReuseIdentifier: TicketDetailsTableViewCell.identifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupConstraints()
    }
    
    private func setupUI(){
        detailsFindView.addSubviews([backView, titleLabel])
        view.addSubviews([ticketsDetailsTable, detailsFindView])
        ticketsDetailsViewModel.changeStateIfNeeded()
        detailsFindView.backgroundColor = UIColor(hex: "#242529")
    }
    
    private func setupData(){
        bindTicketsOffersViewModel()
        guard let departure, let arrived else { return }
        titleLabel.text = "\(departure)-\(arrived)"
    }
    
    private func bindTicketsOffersViewModel() {
        ticketsDetailsViewModel.currentState = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                print("initial")
            case .loading:
                print("loading")
            case .loaded(let tickets):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.tickets = tickets
                    ticketsDetailsTable.isHidden = false
                    ticketsDetailsTable.reloadData()
                }
            case .error:
                print("error")
            }
        }
    }
    
    private func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide
        let viewControllerConstraints = ([
            ticketsDetailsTable.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 138),
            ticketsDetailsTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            ticketsDetailsTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            ticketsDetailsTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -32),
            
            backView.leadingAnchor.constraint(equalTo: detailsFindView.leadingAnchor, constant: 4),
            backView.widthAnchor.constraint(equalToConstant: 24),
            backView.heightAnchor.constraint(equalToConstant: 24),
            backView.centerYAnchor.constraint(equalTo: detailsFindView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: backView.centerYAnchor, constant: -1),
            
            detailsFindView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            detailsFindView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            detailsFindView.heightAnchor.constraint(equalToConstant: 56),
            detailsFindView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 48),
            
        ])
        NSLayoutConstraint.activate(viewControllerConstraints)
    }
}
