//
//  TabBarController.swift
//  OutStagram
//
//  Created by Terry on 2022/01/31.
//

import UIKit

class TabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController()) //네비게이션바 인베디드
        feedViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "house"),
                                                     selectedImage: UIImage(systemName: "house.fill"))
        
        let profileViewController = UIViewController()
        profileViewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: UIImage(systemName: "person"),
                                                     selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [feedViewController, profileViewController]
    }
}
