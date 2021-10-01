////
////  ViewController.swift
////  GistRunway
////
////  Created by Kauê Sales on 27/09/21.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    @IBOutlet weak var username: UILabel!
//    @IBOutlet weak var userPfp: UIImageView!
//    @IBOutlet weak var gistDescription: UILabel!
//    var responses: [Gist] = []
//    var adaptedResponses: [GistAdapter] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//
//        testAPI()
//    }
//
//    func testAPI() {
//        let request = GistAPI(path: .gists)
//
//        let apiLoader = APILoader(apiRequest: request)
//        apiLoader.loadAPIRequest { result in
//            switch result {
//            case .success(let response):
//                self.adaptResponses(response: response[0])
//
//            case .failure(let error):
//                print("failed", error)
//            }
//        }
//
//    }
//
//    func adaptResponses(response: Gist) {
//        let userImageRequest = ImageLoader(imageURL: response.owner.avatar_url)
//        let apiLoader = APILoader(apiRequest: userImageRequest)
//        var userImage = UIImage()
//
//        apiLoader.loadAPIRequest { result in
//            switch result {
//            case.success(let image):
//                userImage = image!
//            case .failure(let error):
//                print(error)
//            }
//        }
//        let gist = GistAdapter(description: response.description ?? "lazy user omegalul", owner: response.owner.login, ownerImage: userImage)
//
//
//
//        DispatchQueue.main.async {
//            self.username.text = gist.owner
//            self.gistDescription.text = gist.description
//            self.userPfp.image = userImage
//        }
//
//    }
//
//}
//
