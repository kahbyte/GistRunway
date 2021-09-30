//
//  MainScreenViewController.swift
//  GistRunway
//
//  Created by Kauê Sales on 28/09/21.
//

import UIKit

protocol TableViewData {
    func reloadTableView()
}

protocol MainScreenUserIntents {
    func updateTableView()
}

class MainScreenViewController: UIViewController {
    
    private var customView: MainScreenView? = nil
    private var gistsViewModel = MainScreenViewModel()
    private var isLookingForUser = false
    let searchController = UISearchController()
    var gists: [Gist] = [Gist(id: "aaa", description: "aaa", owner: Owner(login: "aaaa", avatar_url: "aaaa"))]
    
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        gistsViewModel.tableViewDataDelegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .black
        
//        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.searchController = searchController
        self.title = "Gists"
        buildView()
    }
    
    private func buildView() {
        view = MainScreenView()
        
        guard let newView = (view as? MainScreenView) else { return }
        customView = newView
        
        customView?.mainScreenDelegate = self
        customView!.gistsTableView.delegate = self
        customView!.gistsTableView.dataSource = gistsViewModel
        customView?.gistsTableView.register(CustomGistsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        gistsViewModel.getGistsFrom(page: gistsViewModel.nextPage)
    }
    
    private func handleMarkAsFavourite() {
        print("marked as favourite")
    }
}

extension MainScreenViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 110
//        return UITableView.automaticDimension
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isLookingForUser {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

            if offsetY > contentHeight - scrollView.frame.height  {
                if !gistsViewModel.fetchingMore {
                    gistsViewModel.getGistsFrom(page: gistsViewModel.nextPage)
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favourite", handler: {  [weak self] action, view, completionHandler in
            self?.handleMarkAsFavourite()
            completionHandler(true)
        })
        
        action.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}

extension MainScreenViewController: TableViewData, MainScreenUserIntents {
    func updateTableView() {
        self.gistsViewModel.refreshGists()
    }
    
    func reloadTableView() {
        self.customView?.gistsTableView.reloadData()
        self.customView?.refreshControl.endRefreshing()
    }
}

extension MainScreenViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.gistsViewModel.adaptedGists = []
        self.gistsViewModel.adaptedGists = self.gistsViewModel.gistsToBeRestored
        reloadTableView()
        isLookingForUser = false
        print("canceled")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            isLookingForUser = true
            self.gistsViewModel.getGistsFrom(user: searchText)
        }
        
    }
    
}



