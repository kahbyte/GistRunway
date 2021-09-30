//
//  FavoritesViewController.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var customView: FavoritesView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        buildView()
    }
    
    private func buildView() {
        view = FavoritesView()
        
        guard let newView = (view as? FavoritesView) else { return }
        customView = newView
        
        customView!.gistsTableView.delegate = self
        customView!.gistsTableView.dataSource = self
        customView?.gistsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "favoriteCell")
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favourite", handler: {  [weak self] action, view, completionHandler in
            self?.handleRemoveFavorite()
            completionHandler(true)
        })
        
        action.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    private func handleRemoveFavorite() {
        print("removed favourite")
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
