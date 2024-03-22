//
//  MarvelTabBarController.swift
//  MarvelApp
//
//  Created by Berkay on 22.03.2024.
//

import UIKit

class MarvelTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createSearchNavigationController(), createFavoriteNavigationContoller()]
    }
    
    func createSearchNavigationController() -> UINavigationController {
        let searchVC = MainPageVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        // UIButton oluşturma ve eylem atanması
        let customButton = UIButton(type: .system)
        customButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
        
        // UIButton'i barButtonItem olarak ayarlama
        let barButtonItem = UIBarButtonItem(customView: customButton)
        searchVC.navigationItem.rightBarButtonItem = barButtonItem
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteNavigationContoller() -> UINavigationController {
        let favoritesListVC = MainPageVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }

    @objc func customButtonTapped() {
        // İlgili tabBarItem'da butona basıldığında yapılacak eylem
        let nextVC = SearchViewController()
        // Doğru şekilde navigationController yerine self.selectedViewController'i kullanıyoruz
        (self.selectedViewController as? UINavigationController)?.pushViewController(nextVC, animated: true)
    }

}

