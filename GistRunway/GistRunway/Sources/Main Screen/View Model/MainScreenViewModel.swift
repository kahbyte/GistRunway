//
//  MainScreenViewModel.swift
//  GistRunway
//
//  Created by Kauê Sales on 29/09/21.
//

import UIKit
import CoreData

class MainScreenViewModel: NSObject {
    var nextPage = 1
    var adaptedGists: [GistAdapter] = []
    var comments: [Comments] = []
    var gistsToBeRestored: [GistAdapter] = []
    var fetchingMore = false
    
    //MARK: API
    var tableViewDataDelegate: TableViewData?
    
    
    func refreshGists() {
        adaptedGists = []
        nextPage = 1
        getGistsFrom(page: nextPage)
    }
    
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
    
    //last function that is called and fills in the view
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
    
    func persistFavorite(model: GistAdapter) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "GistsCoreData", in: context)
        let newFavorite = GistsCoreData(entity: entity!, insertInto: context)
        newFavorite.ownerName = model.owner
        newFavorite.image = model.ownerImage.cgImage?.dataProvider?.data as Data?
        newFavorite.desc = model.description
        
        do {
            try context.save()
            print("feito")
        } catch {
            print("failed")
        }
        
        
    }
}

extension MainScreenViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        adaptedGists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomGistsTableViewCell
        
        if adaptedGists.count > 0 {
            let info = adaptedGists[indexPath.row]
            cell.setup(model: info)
        }
        
        return cell
    }
    
}
