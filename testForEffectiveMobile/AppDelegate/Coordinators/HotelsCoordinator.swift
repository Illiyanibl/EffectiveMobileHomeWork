//
//  HotelsCoordinator.swift
//  testForEffectiveMobile
//
//  Created by Illya Blinov on 29.05.24.
//

import UIKit
final class HotelsCoordinator: HotelsCoordinatorProtocol {
    var rootViewController: UIViewController = UIViewController()
    var parentCoordinator: MainCoordinatorProtocol?

    func start() -> UIViewController {
        let hotelsViewController = HotelsViwController()
        return hotelsViewController
    }


}
