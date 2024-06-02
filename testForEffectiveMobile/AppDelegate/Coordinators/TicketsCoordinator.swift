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
}
enum OffersActionCases {
    case ticketsForDirection(String, String)
}

final class TicketsCoordinator: TicketsCoordinatorProtocol {
    var rootViewController: UIViewController = UIViewController()
    var parentCoordinator: MainCoordinatorProtocol?
    
    func start() -> UIViewController {
        let ticketsViewController = TicketsViewController()
        let ticketsModalViewController = TicketsModalViewController()
        let ticketsOffersViewController = TicketsOffersViewController()
        let ticketDetailsViewController = TicketDetailsViewController()
        
        ticketsViewController.mainAction = { [weak self] in
            switch $0 {
            case .selectedDepatrure(let city):
                print("Улетаем из \(city)")
                ticketsModalViewController.departureFrom = city
                ticketsModalViewController.ticketsModalService = TicketsModalservice()
                self?.presentScreen(viewController: ticketsModalViewController)
            }
        }
        
        ticketsModalViewController.modalAction = { [weak self] in
            switch $0 {
            case .selectedDirection(let departure, let arrived):
                print("Улетаем из \(departure) в \(arrived)")
                ticketsOffersViewController.departure = departure
                ticketsOffersViewController.arrived = arrived
                self?.showScreen(viewController: ticketsOffersViewController)
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
        
        rootViewController = UINavigationController(rootViewController: ticketsViewController)
        return rootViewController
    }
    
    func showScreen(viewController : UIViewController) {
        navigationRootViewController?.pushViewController(viewController, animated: true)
    }
    
    func presentScreen(viewController : UIViewController){
        navigationRootViewController?.present(viewController, animated: true)
    }
    
    
}
