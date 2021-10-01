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
    var favoriteGists: [GistAdapter] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        buildView()
//        fetchCoreData()
    }
    
    private func buildView() {
        view = FavoritesView()
        
        guard let newView = (view as? FavoritesView) else { return }
        customView = newView
        
        
        customView!.gistsTableView.delegate = self
        customView!.gistsTableView.dataSource = self
        customView?.gistsTableView.register(CustomGistsTableViewCell.self, forCellReuseIdentifier: "favoriteCell")
    }
    
//    func fetchCoreData() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GistsCoreData")
//        do {
//            let results:NSArray = try context.fetch(request) as NSArray
//            for result in results {
//                let gist = result as! GistsCoreData
//                let adaptedGist = GistAdapter(description: gist.desc, owner: gist.ownerName, ownerImage: (UIImage(data: gist.image) ?? UIImage(named: "pp"))!)
//                favoriteGists.append(adaptedGist)
//                print(gist.ownerName!, gist.desc)
//            }
//        } catch {
//            print("error")
//        }
//
//    }
    
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
        customView?.gistsTableView.deleteRows(at: [index], with: .automatic)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GistsCoreData")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let gist = result as! GistsCoreData
                
                if(gist.ownerName == favoriteGists[index.row].owner && gist.desc == favoriteGists[index.row].description) {
                    context.delete(gist)
                    favoriteGists.remove(at: index.row)
                    try context.save()
                }
            }
        } catch {
            print("error")
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteGists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! CustomGistsTableViewCell
        if favoriteGists.count > 0 {
            let info = favoriteGists[indexPath.row]
            cell.setup(model: info)
        }
        
        return cell
    }


}
