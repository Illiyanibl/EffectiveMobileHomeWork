//
//  TicketsCoordinator.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 28.05.24.
//

import UIKit
enum MainActionCases {
    case selectedDepatrure(String)
}
enum ModalActionCases {
    case selectedDirection(String, String)
    case tapEmptyView
}
enum OffersActionCases {
    case ticketsForDirection(String, String)
}

final class TicketsCoordinator: TicketsCoordinatorProtocol {
    var rootViewController: UIViewController = UIViewController()
    var parentCoordinator: MainCoordinatorProtocol?
    let defaults = UserDefaults.standard

    func start() -> UIViewController {
        let ticketsViewController = TicketsViewController()
        let ticketsModalViewController = TicketsModalViewController()
        let ticketsOffersViewController = TicketsOffersViewController()
        let ticketDetailsViewController = TicketDetailsViewController()
        let savedCity = defaults.string(forKey: "city")
        ticketsViewController.mainAction = { [weak self] in
            switch $0 {
            case .selectedDepatrure(let city):
                city.count > 0 ? self?.saveCity(city: city) : ()
                ticketsModalViewController.departureFrom = city
                ticketsModalViewController.ticketsModalService = TicketsModalservice()
                self?.presentScreen(viewController: ticketsModalViewController)
            }
        }

        ticketsModalViewController.modalAction = { [weak self] in
            switch $0 {
            case .selectedDirection(let departure, let arrived):
                print("From \(departure) to \(arrived)")
                ticketsOffersViewController.departure = departure
                ticketsOffersViewController.arrived = arrived
                self?.showScreen(viewController: ticketsOffersViewController)
            case .tapEmptyView:
                let findView = ticketsModalViewController.view
                let infoView = InfoView()
                infoView.infoLabel.text = "Окно закрывается тапом"
                infoView.action = {
                    ticketsModalViewController.view = findView
                }
                ticketsModalViewController.view = infoView
            }
        }

        ticketsOffersViewController.offersAction = { [weak self] in
            switch $0 {
            case .ticketsForDirection(let departure, let arrived):
                ticketDetailsViewController.departure = departure
                ticketDetailsViewController.arrived = arrived
                self?.showScreen(viewController: ticketDetailsViewController)
            }
        }
        savedCity != nil ? ticketsViewController.fromCity = savedCity : ()
        rootViewController = UINavigationController(rootViewController: ticketsViewController)
        return rootViewController
    }

    func showScreen(viewController : UIViewController) {
        navigationRootViewController?.pushViewController(viewController, animated: true)
    }

    func presentScreen(viewController : UIViewController){
        navigationRootViewController?.present(viewController, animated: true)
    }

    func saveCity(city: String){
        defaults.set(city, forKey: "city")
    }

}
