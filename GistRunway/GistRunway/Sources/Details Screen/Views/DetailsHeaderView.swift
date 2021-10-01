//
//  DetailsHeaderView.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit

class DetailsHeaderView: UIView {
    let userImageView: CircularImageView = {
        let imageView = CircularImageView()
        imageView.image = UIImage(named: "pp")
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor(named: ApplicationColors.titleColor.rawValue)?.cgColor
        
        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue Bold", size: 30)
        label.text = "Tutuzao"
        label.textColor = UIColor(named: ApplicationColors.titleColor.rawValue)
        return label
    }()
    
    let gistName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue Bold", size: 20)
        label.text = "Kaisa k/da AR"
        label.textColor = UIColor(named: ApplicationColors.titleColor.rawValue)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    let detailsView = GistsDetailedInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: GistAdapter) {
        userImageView.image = model.ownerImage
        userName.text = model.owner
        gistName.text = model.description
    }
    
    func addSubviews() {
        addSubview(userImageView)
        addSubview(userName)
        addSubview(gistName)
        addSubview(detailsView)
    }
    
    func addConstraints() {
        userImageView.addConstraints(top: safeAreaLayoutGuide.topAnchor, centerX: centerXAnchor, paddingTop: 67, width: 227.15, height: 227.15)
        userName.addConstraints(top: userImageView.bottomAnchor, centerX: centerXAnchor, paddingTop: 36)
        gistName.addConstraints(top: userName.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 35.9,  paddingLeft: 39.5, paddingRight: -39.5)
        detailsView.addConstraints(top: gistName.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 11.9, paddingLeft: 39.5, paddingBottom: -36, paddingRight: -39.5)
        
    }

}


