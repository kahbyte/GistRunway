//
//  DetailsViewController.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit

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
        customView?.detailsTableView.dataSource = detailsViewModel
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

extension DetailsViewController: TableViewData {
    func reloadTableView() {
        customView?.detailsTableView.reloadData()
        header?.detailsView.commentsQuantityLabel.text = "\(detailsViewModel.adaptedComments.count)"
        header?.detailsView.forkQuantityLabel.text = "\(detailsViewModel.forksCount)"
    }
}

