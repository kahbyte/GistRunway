//
//  FavoritesView.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit

class FavoritesView: UIView {
    let gistsTableView: UITableView = {
        let tableView = UITableView()
//        tableView.estimatedRowHeight = 104
//        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addsubViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addsubViews() {
        addSubview(gistsTableView)
    }
    
    private func addsubConstraints() {
        gistsTableView.addConstraints(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }

}
