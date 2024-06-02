//
//  Coordinators.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 28.05.24.
//

import UIKit
typealias Action = ((_ : UIViewController) -> Void)

enum AppFlow {
    case tikets
    case hotel
    case shortWay
    case subscriptions
    case profile
}

protocol FlowCoordinatorProtocol: AnyObject {
    var parentCoordinator: MainCoordinatorProtocol? { get set }
}

protocol Coordinator: FlowCoordinatorProtocol {
    var rootViewController: UIViewController { get set }

    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

protocol MainCoordinatorProtocol: Coordinator {
    var ticketsCoordinator: TicketsCoordinatorProtocol { get }
    var hotelsCoordinator: HotelsCoordinatorProtocol { get }
    var shortWayCoordinator: ShortWayCoordinatorProtocol { get }
    var subscriptionsCoordinator: SubscriptionsCoordinatorProtocol { get }
    var profileCoordinator: ProfileCoordinatorProtocol { get }
    func moveTo(flow: AppFlow)
}

protocol TicketsCoordinatorProtocol: Coordinator {}
protocol HotelsCoordinatorProtocol: Coordinator {}
protocol ShortWayCoordinatorProtocol: Coordinator {}
protocol SubscriptionsCoordinatorProtocol: Coordinator {}
protocol ProfileCoordinatorProtocol: Coordinator {}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }

    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}
