//
//  MainScreenView.swift
//  GistRunway
//
//  Created by Kauê Sales on 28/09/21.
//

import UIKit

class MainScreenView: UIView {
    
    
    let gistsTableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 104
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var mainScreenDelegate: MainScreenUserIntents?

    let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor(named: ApplicationColors.titleColor.rawValue)
        control.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ApplicationColors.titleColor.rawValue) as Any])
        return control
    }()
    
    init() {
        super.init(frame: .zero)
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        backgroundColor = UIColor(named: ApplicationColors.darkBackground.rawValue)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(gistsTableView)
        gistsTableView.addSubview(refreshControl)
    }
    
    func addConstraints() {
        gistsTableView.addConstraints(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        mainScreenDelegate?.updateTableView()
    }
}
