//
//  SubscriptionsCoordinator.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 29.05.24.
//

import UIKit
final class SubscriptionsCoordinator: SubscriptionsCoordinatorProtocol {
    var rootViewController: UIViewController = UIViewController()
    var parentCoordinator: MainCoordinatorProtocol?

    func start() -> UIViewController {
        let subscriptionsViewController = SubscriptionsViewController()
        return subscriptionsViewController
    }
}
