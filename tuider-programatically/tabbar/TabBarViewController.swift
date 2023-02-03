//
//  TabBarViewController.swift
//  tuider-programatically
//
//  Created by Gatien DIDRY on 24/11/2022.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        self.viewControllers = [
            self.createNavController(
                for: ProposalsViewController(),
                image: UIImage(systemName: "heart.fill")!
            ),
            self.createNavController(for: MessagesViewController(), image: UIImage(systemName: "message.fill")!),
            self.createNavController(for: ProfilViewController(), image: UIImage(systemName: "person.fill")!)

        ]

    }

    fileprivate func createNavController(
        for rootViewController: UIViewController,
        image: UIImage
        ) -> UIViewController {

        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true

        return navController
    }

}
