//
//  FavoritesViewModel.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit
import CoreData

class FavoritesViewModel {
    var favoriteGists: [GistAdapter] = []
    
    func fetchCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGists")
        
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                let gist = result as! FavoriteGists
                var files:[FileDetails] = []
                
                for info in gist.files! {
                    let file = FileDetails(filename: info[0], type: info[1], language: info[2], raw_url: info[3])
                    files.append(file)
                }
                
                let adaptedGist = GistAdapter(description: gist.desc!, owner: gist.owner!, ownerImage: (UIImage(data: gist.profilePic!) ?? UIImage())!, commentsURL: gist.commentsURL!, forksURL: gist.forksURL!, files: files)
                favoriteGists.append(adaptedGist)
            }
        } catch {
            print("error")
        }
    }
}
