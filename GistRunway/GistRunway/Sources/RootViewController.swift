//
//  RootViewController.swift
//  GistRunway
//
//  Created by Kauê Sales on 29/09/21.
//

import UIKit

class RootViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: ApplicationColors.titleColor.rawValue)]

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(named: ApplicationColors.darkBackground.rawValue)
        
        appearance.largeTitleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        appearance.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
       
        
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        
        let mainScreen = MainScreenViewController()
        
        self.viewControllers = [mainScreen]
    }

}
