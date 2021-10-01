//
//  DetailsViewController.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit
import WebKit

protocol DetailsViewControllerProtocol: AnyObject {
    func openFileUrl(url: URL)
}

class DetailsViewController: UIViewController {
    private var customView: DetailsView? = nil
    var detailsViewModel = DetailsViewModel()
    private var header: DetailsHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        
        // Do any additional setup after loading the
        detailsViewModel.tableViewDataDelegate = self
        detailsViewModel.getComments(url: detailsViewModel.model.commentsURL)
        detailsViewModel.getForksQuantity(url: detailsViewModel.model.forksURL)
        buildView()
    }
    
    func buildView() {
        view = DetailsView()
        
        guard let newView = (view as? DetailsView) else { return }
        customView = newView
        customView?.detailsTableView.delegate = self
        customView?.detailsTableView.dataSource = self
        customView?.detailsTableView.register(CustomGistsTableViewCell.self, forCellReuseIdentifier: "commentsCell")
        customView?.detailsTableView.register(CustomFilesCell.self, forCellReuseIdentifier: "filesCell")
        
        header = DetailsHeaderView()
        header?.setup(model: detailsViewModel.model)
        let size = header?.systemLayoutSizeFitting(DetailsHeaderView.layoutFittingCompressedSize)
        header?.frame = CGRect(x: 0, y: 0, width: 0, height: size!.height)
        customView?.detailsTableView.tableHeaderView = header
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .clear
            headerView.backgroundView?.backgroundColor = .clear
            headerView.textLabel?.textColor = UIColor(named: ApplicationColors.titleColor.rawValue)
            headerView.textLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 20)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 23
    }
    

}

extension DetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailsViewModel.tableViewSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return detailsViewModel.adaptedComments.count
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return detailsViewModel.tableViewSections[0]
        case 1:
            return detailsViewModel.tableViewSections[1]
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "filesCell", for: indexPath) as! CustomFilesCell
            cell.model = detailsViewModel.model.files
            cell.detailsViewDelegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath) as! CustomGistsTableViewCell
            cell.setup(model: detailsViewModel.adaptedComments[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }

}

extension DetailsViewController: TableViewData, DetailsViewControllerProtocol {
    func openFileUrl(url: URL) {
        let web = WKWebView.init(frame: UIScreen.main.bounds)
        web.load(URLRequest(url: url))
        
        let controller = UIViewController()
        controller.view.addSubview(web)
        present(controller, animated: true)  
    }
    
    func reloadTableView() {
        customView?.detailsTableView.reloadData()
        header?.detailsView.commentsQuantityLabel.text = "\(detailsViewModel.adaptedComments.count)"
        header?.detailsView.forkQuantityLabel.text = "\(detailsViewModel.forksCount)"
    }
}

