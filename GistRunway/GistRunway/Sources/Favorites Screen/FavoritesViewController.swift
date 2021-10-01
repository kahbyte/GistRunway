//
//  FavoritesViewController.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    private var customView: FavoritesView? = nil
    private var favoritesViewModel = FavoritesViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        buildView()
    }
    
    private func buildView() {
        view = FavoritesView()
        
        guard let newView = (view as? FavoritesView) else { return }
        customView = newView
        
        
        customView!.gistsTableView.delegate = self
        customView!.gistsTableView.dataSource = self
        customView?.gistsTableView.register(CustomGistsTableViewCell.self, forCellReuseIdentifier: "favoriteCell")
        
        favoritesViewModel.fetchCoreData()
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil, handler: {  [weak self] action, view, completionHandler in
            self?.handleRemoveFavorite(index: indexPath)
            completionHandler(true)
        })
        
        action.image = UIImage(systemName: "star.slash.fill")

        action.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [action])
    }

    private func handleRemoveFavorite(index: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGists")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            let result = results[index.row] as! FavoriteGists
            
            context.delete(result)
            favoritesViewModel.favoriteGists.remove(at: index.row)
            try context.save()
            customView?.gistsTableView.reloadData()
        } catch {
            print("error")
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel.favoriteGists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! CustomGistsTableViewCell
        if favoritesViewModel.favoriteGists.count > 0 {
            let info = favoritesViewModel.favoriteGists[indexPath.row]
            cell.setup(model: info)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGist = favoritesViewModel.favoriteGists[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        print(selectedGist)
        
        let detailsVC = DetailsViewController()
        detailsVC.detailsViewModel.model = favoritesViewModel.favoriteGists[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }


}
