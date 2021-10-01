//
//  DetailsView.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//


import UIKit

class DetailsView: UIView {
    let detailsTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.estimatedRowHeight = 121.43
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: ApplicationColors.darkBackground.rawValue)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(detailsTableView)
    }
    
    func addConstraints() {
        detailsTableView.addConstraints(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }
    
}

