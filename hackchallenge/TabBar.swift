//
//  TabBar.swift
//  hackchallenge
//
//  Created by Ben Neuwirth on 12/3/21.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        setupVCs()
        
    }
    
    // Code from https://stackoverflow.com/questions/23044218/change-uitabbar-height
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tabBar.frame.size.height = 70
        tabBar.frame.origin.y = view.frame.height - 70
        
    }
    
    func setupVCs() {
           viewControllers = [
            createNavController(for: ViewController(), title: "", image: UIImage(named: "pulse")!.withRenderingMode(.alwaysOriginal)),
           ]
        
            for vc in self.viewControllers! {
                vc.tabBarItem.title = nil
                vc.tabBarItem.imageInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
            }
       }
    
    // Code from https://medium.com/swift-productions/create-a-uitabbar-programmatically-xcode-12-swift-5-3-740d5491631c
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.title = title
            navController.tabBarItem.image = image
            navController.navigationBar.prefersLargeTitles = true
            rootViewController.navigationItem.title = title
            return navController
        }

}
