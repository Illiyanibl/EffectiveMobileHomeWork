//
//  MainCoordinator.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 28.05.24.
//

import UIKit

final class MainCoordinator: MainCoordinatorProtocol {

    var parentCoordinator: MainCoordinatorProtocol?
    var ticketsCoordinator: TicketsCoordinatorProtocol = TicketsCoordinator()
    var hotelsCoordinator: HotelsCoordinatorProtocol = HotelsCoordinator()
    var shortWayCoordinator: ShortWayCoordinatorProtocol = ShortWayCoordinator()
    var subscriptionsCoordinator: SubscriptionsCoordinatorProtocol = SubscriptionsCoordinator()
    var profileCoordinator: ProfileCoordinatorProtocol = ProfileCoordinator()

    var rootViewController: UIViewController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barStyle = .default
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.view.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = UIColor(hex: "#2261BC")
        tabBarController.tabBar.unselectedItemTintColor = UIColor(hex: "#9F9F9F")
        return tabBarController
    }()


    func start() -> UIViewController {
        ticketsCoordinator.parentCoordinator = self
        hotelsCoordinator.parentCoordinator = self
        shortWayCoordinator.parentCoordinator = self
        subscriptionsCoordinator.parentCoordinator = self
        profileCoordinator.parentCoordinator = self

        let ticketsViewController = ticketsCoordinator.start()
        let hotelsViewController = hotelsCoordinator.start()
        let shortWayViewController = shortWayCoordinator.start()
        let subscriptionsViewController = subscriptionsCoordinator.start()
        let profileViewController = profileCoordinator.start()

        ticketsViewController.tabBarItem = UITabBarItem(title: "Авиабилеты", image: UIImage(named: "airplane1"), tag: 0)
        hotelsViewController.tabBarItem = UITabBarItem(title: "Отели", image: UIImage(named: "hotelSmall"), tag: 1)
        shortWayViewController.tabBarItem = UITabBarItem(title: "Короче", image: UIImage(named: "shortWay"), tag: 2)
        subscriptionsViewController.tabBarItem = UITabBarItem(title: "Подписки", image: UIImage(named: "bell"), tag: 3)
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "person"), tag: 4)


        (rootViewController as? UITabBarController)?.viewControllers = [ticketsViewController, hotelsViewController, shortWayViewController, subscriptionsViewController, profileViewController]

        return rootViewController
    }

    func moveTo(flow: AppFlow) {
        switch flow {
        case .tikets:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .hotel:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        case .shortWay:
            (rootViewController as? UITabBarController)?.selectedIndex = 2
        case .subscriptions:
            (rootViewController as? UITabBarController)?.selectedIndex = 3
        case .profile:
            (rootViewController as? UITabBarController)?.selectedIndex = 4
        }
    }

}
