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
    private let searchController = UISearchController()
    
    private var favorites: UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.image = UIImage(systemName: "star.fill")
        button.tintColor = UIColor(named: ApplicationColors.titleColor.rawValue)
        button.action = #selector(pushToFavoritesScreen)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        favorites.target = self
        gistsViewModel.tableViewDataDelegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .black
        
        print(gistsViewModel.fetchingMore)
        
        self.navigationItem.rightBarButtonItem = favorites
        self.navigationItem.searchController = searchController
        self.title = "Gists"
        buildView()
    }
    
    
    @objc private func pushToFavoritesScreen(_ sender: UIBarButtonItem) {
        let favoritesVC = FavoritesViewController()
        self.navigationController?.pushViewController(favoritesVC, animated: true)
    }
    
    private func buildView() {
        view = MainScreenView()
        
        guard let newView = (view as? MainScreenView) else { return }
        customView = newView
        
        customView?.mainScreenDelegate = self
        customView!.gistsTableView.delegate = self
        customView!.gistsTableView.dataSource = self
        customView?.gistsTableView.register(CustomGistsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        gistsViewModel.getGistsFrom(page: gistsViewModel.nextPage)
    }
   
    private func handleMarkAsFavourite(index: Int) {
        gistsViewModel.persistFavorite(model: gistsViewModel.adaptedGists[index])
    }
}

extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.gistsViewModel.adaptedGists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomGistsTableViewCell
        
        if gistsViewModel.adaptedGists.count > 0 {
            let info = gistsViewModel.adaptedGists[indexPath.row]
            cell.setup(model: info)
        }
        
        return cell
    }
    
}

extension MainScreenViewController: UITableViewDelegate {
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
        let action = UIContextualAction(style: .normal, title: nil, handler: {  [weak self] action, view, completionHandler in
            self?.handleMarkAsFavourite(index: indexPath.row)
            completionHandler(true)
        })
        
        action.image = UIImage(systemName: "star.fill")
        action.backgroundColor = .systemYellow
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGist = gistsViewModel.adaptedGists[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        print(selectedGist)
        
        let detailsVC = DetailsViewController()
        detailsVC.detailsViewModel.model = gistsViewModel.adaptedGists[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
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


