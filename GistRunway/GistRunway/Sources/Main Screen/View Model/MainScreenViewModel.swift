//
//  MainScreenViewModel.swift
//  GistRunway
//
//  Created by Kauê Sales on 29/09/21.
//

import UIKit

class MainScreenViewModel: NSObject {
    var nextPage = 1
    var adaptedGists: [GistAdapter] = []
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
        let request = GistAPI(path: .getGists(page: nextPage))
        let apiLoader = APILoader(apiRequest: request)
        fetchingMore = true
        
        apiLoader.loadAPIRequest { result in
            switch result {
            case .success(let response):
                self.adapt(responses: response)
                self.fetchingMore.toggle()
                self.nextPage += 1
                print(self.nextPage)
                
                DispatchQueue.main.async {
                    self.tableViewDataDelegate?.reloadTableView()
                    print("reloaded tableview with \(self.adaptedGists.count) items")
                }
                
            case .failure(let error):
                print("failed", error)
                self.fetchingMore.toggle()
            }
        }
    }
    
    func getGistsFrom(user: String) {
        let request = GistAPI(path: .getGistsFrom(user: user.lowercased()))
        let apiLoader = APILoader(apiRequest: request)
        
        apiLoader.loadAPIRequest { result in
            switch result {
                
            case .success(let response):
                print("clonei os gists")
                self.gistsToBeRestored = self.adaptedGists
                self.adaptedGists = []
                print("to puxando o usuario")
                self.adapt(responses: response)
                DispatchQueue.main.async {
                    print("reloaded tableview with \(self.adaptedGists.count) items")
                }
                
            case .failure(let error):
                print("failed", error)
            }
        }
    }
    
    //last function that is called and fills in the view
    func adapt(responses: [Gist]) {
        for response in responses {
            if let ownerInArray = adaptedGists.first(where: {$0.owner == response.owner.login}) {
                let gist = GistAdapter(description: response.description ?? "", owner: response.owner.login, ownerImage: ownerInArray.ownerImage)
                self.adaptedGists.append(gist)
            } else {
                let userImageRequest = ImageRequest(imageURL: response.owner.avatar_url)
                let apiLoader = APILoader(apiRequest: userImageRequest)
                
                apiLoader.loadAPIRequest { result in
                    switch result {
                    case.success(let image):
                        let gist = GistAdapter(description: response.description ?? "", owner: response.owner.login, ownerImage: image!)
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
}

extension MainScreenViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        adaptedGists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomGistsTableViewCell
        
        if adaptedGists.count > 0 {
            cell.ownerName.text = adaptedGists[indexPath.row].owner
            cell.ownerImageView.image = adaptedGists[indexPath.row].ownerImage
            cell.gistDescription.text = adaptedGists[indexPath.row].description
        }
        
        return cell
    }
    
    
}
