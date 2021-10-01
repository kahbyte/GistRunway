//
//  MainScreenViewModel.swift
//  GistRunway
//
//  Created by Kauê Sales on 29/09/21.
//

import UIKit
import CoreData

class MainScreenViewModel: NSObject {
    
    //MARK: - VARIAVEIS DE CONTROLE
    var nextPage = 1
    var adaptedGists: [GistAdapter] = []
    var comments: [Comments] = []
    var gistsToBeRestored: [GistAdapter] = []
    var fetchingMore = false
    
    //Allows data reloading into the table view inside the main view controller
    var tableViewDataDelegate: TableViewData?
    
    //Get the new gists created. The array becomes empty, and it stores the new data.
    func refreshGists() {
        adaptedGists = []
        nextPage = 1
        getGistsFrom(page: nextPage)
    }
    
    //it requests 30 gists for every page
    func getGistsFrom(page: Int) {
        let request = GistAPI<Gist>(path: .getGists(page: nextPage))
        let apiLoader = APILoader(apiRequest: request)
        fetchingMore = true
        
        apiLoader.loadAPIRequest { result in
            switch result {
            case .success(let response):
                self.adapt(responses: response)
                self.fetchingMore.toggle()
                self.nextPage += 1
                
            case .failure(let error):
                print("failed", error)
                self.fetchingMore.toggle()
            }
        }
    }
    
    //gists from a said user.
    func getGistsFrom(user: String) {
        let request = GistAPI<Gist>(path: .getGistsFrom(user: user.lowercased()))
        let apiLoader = APILoader(apiRequest: request)
        
        apiLoader.loadAPIRequest { result in
            switch result {
                
            case .success(let response):
                self.gistsToBeRestored = self.adaptedGists
                self.adaptedGists = []
                self.adapt(responses: response)
                
            case .failure(let error):
                print("failed", error)
            }
        }
    }
    
    /*I'm really really proud of this one. If someone is already in the adapted gists array, there's
     absolutely no need to fetch the image again. Recycling is life ♻️*/
    func adapt(responses: [Gist]) {
        for response in responses {
            if let ownerInArray = adaptedGists.first(where: {$0.owner == response.owner.login}) {
                let gist = GistAdapter(description: response.description ?? "", owner: response.owner.login, ownerImage: ownerInArray.ownerImage, commentsURL: response.comments_url, forksURL: response.forks_url, files: response.fileList)
                self.adaptedGists.append(gist)
            } else {
                let userImageRequest = ImageRequest(imageURL: response.owner.avatar_url)
                let apiLoader = APILoader(apiRequest: userImageRequest)
                
                apiLoader.loadAPIRequest { result in
                    switch result {
                    case.success(let image):
                        let gist = GistAdapter(description: response.description ?? "", owner: response.owner.login, ownerImage: image!, commentsURL: response.comments_url, forksURL: response.forks_url, files: response.fileList)
                        self.adaptedGists.append(gist)
                        
                        DispatchQueue.main.async {
                            self.tableViewDataDelegate?.reloadTableView()
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    
    /*persists a favorite and its files locally.*/
    func persistFavorite(model: GistAdapter) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        guard let favsEntity = NSEntityDescription.entity(forEntityName: "FavoriteGists", in: context) else { return }
        
        let newFavorite = FavoriteGists(entity: favsEntity, insertInto: context)
        
        newFavorite.desc = model.description
        newFavorite.owner = model.owner
        newFavorite.commentsURL = model.commentsURL
        newFavorite.forksURL = model.forksURL
        newFavorite.profilePic = model.ownerImage.pngData()
        newFavorite.files = [[String]]()
        
        
        
        //after not knowing how to properly deal with the core data relationship logic yet, Kauê is now living in 2077... [sorry for this]
        for file in model.files {
            let fileData = [file.filename ?? "", file.type ?? "", file.language ?? "", file.raw_url ?? ""]
            newFavorite.files?.append(fileData)
        }
        
        
        do {
            try context.save()
        } catch {
            print("failed")
        }
    }
}
