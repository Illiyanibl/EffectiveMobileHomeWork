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
        view.addSubviews([ticketsDetailsTable])
        ticketsDetailsViewModel.changeStateIfNeeded()


    }

    private func setupData(){
        bindTicketsOffersViewModel()
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

        ])
        NSLayoutConstraint.activate(viewControllerConstraints)
    }
}
