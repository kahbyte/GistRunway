//
//  CustomCollectionViewCell.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: ApplicationColors.viewWhite.rawValue)
        view.layer.cornerRadius = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(container)
        
    }
    
    func addConstraints() {
        container.addConstraints(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }
}
