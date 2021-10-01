//
//  DetailsViewModel.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit

class DetailsViewModel: NSObject {
    var adaptedComments: [CommentAdapter] = []
    var tableViewSections = ["Files", "Comments"]
    var forksCount: Int = 0
    var model: GistAdapter!
    
    var tableViewDataDelegate: TableViewData?
    
    func getComments(url: String) {
        let request = GistAPI<Comments>(path: .getComments(url: url))
        let apiLoader = APILoader(apiRequest: request)
        
        apiLoader.loadAPIRequest { result in
            switch result {
                
            case .success(let response):
                self.adapt(comments: response)
                
            case .failure(let error):
                print("failed", error)
            }
        }
    }
    
    func getForksQuantity(url: String) {
        let request = GistAPI<Forks>(path: .getComments(url: url))
        let apiLoader = APILoader(apiRequest: request)
        
        apiLoader.loadAPIRequest { result in
            switch result {
                
            case .success(let response):
                self.forksCount = response.count
                
            case .failure(let error):
                print("failed", error)
            }
        }
    }
    
    func adapt(comments: [Comments]) {
        for comment in comments {
            if let userCommented = adaptedComments.first(where: {$0.userName == comment.user.login }) {
                let commentary = CommentAdapter(userName: comment.user.login, userImage: userCommented.userImage, body: comment.body)
                
                self.adaptedComments.append(commentary)
            } else {
                let userImageRequest = ImageRequest(imageURL: comment.user.avatar_url)
                let apiLoader = APILoader(apiRequest: userImageRequest)
                
                apiLoader.loadAPIRequest { result in
                    switch result {
                    case.success(let image):
                        let commentary = CommentAdapter(userName: comment.user.login, userImage: image!, body: comment.body)
                        self.adaptedComments.append(commentary)
                        
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



