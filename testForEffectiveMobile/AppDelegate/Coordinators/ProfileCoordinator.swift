//
//  ProfileCoordinator.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 29.05.24.
//

import UIKit
final class ProfileCoordinator: ProfileCoordinatorProtocol {
    var rootViewController: UIViewController = UIViewController()
    var parentCoordinator: MainCoordinatorProtocol?

    func start() -> UIViewController {
        let profileViewController = ProfileViewController()
        return profileViewController
    }
}
