//
//  MainTabBarViewController.swift
//  La3ebAssesment
//
//  Created by Sharaf on 25/05/2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setControllers()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Tab bar ")
    }

    private func setControllers() {
        let gameViewModel = GamesViewModel()
        let gameViewController = GamesViewController(viewModel:gameViewModel)
        
       let favoritesViewController = FavoritesViewController()
      
        let rawViewControllers: [UIViewController] = [gameViewController,favoritesViewController]
        
        let navigationViewControllers = rawViewControllers.map(UINavigationController.init)
        setupNavigationAppearance(navigationViewControllers)
        setViewControllers(navigationViewControllers, animated: true)
    }
    
    private func setupAppearance() {
        UITabBar.appearance().barTintColor = .systemBlue
        UITabBar.appearance().unselectedItemTintColor = .white
        guard #available(iOS 13.0, *) else { return }
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) { tabBar.scrollEdgeAppearance = tabBar.standardAppearance }
    }
    
    private func setupNavigationAppearance(_ navigationControllers: [UINavigationController]) {
       
        
        let titles: [String] = ["Games","Favorites"]
        
        let unselectedImageNames = ["gamecontroller",
                                    "question-mark"
                                    ]
        
        let selectedImageNames = ["gamecontroller.fill",
                                  "selected-myorders"]
        
        navigationControllers.enumerated().forEach({ index, navigationController in
            let item = UITabBarItem(title: titles[index],
                                    image: UIImage(named: unselectedImageNames[index]),
                                    selectedImage: UIImage(named: selectedImageNames[index]))
            navigationController.tabBarItem = item
            navigationController.navigationBar.tintColor = .blue
        })
    }
}

