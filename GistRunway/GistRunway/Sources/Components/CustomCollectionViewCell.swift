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
    
    let fileTitle: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont(name: "Helvetica Neue Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    let fileType: UILabel = {
        let label = UILabel()
        label.text = "text/plain"
        label.font = UIFont(name: "Helvetica Neue", size: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let language: UILabel = {
        let label = UILabel()
        label.text = "Swift"
        label.font = UIFont(name: "Helvetica Neue", size: 15)
        label.numberOfLines = 0
        return label
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
        container.addSubview(fileTitle)
        container.addSubview(fileType)
        container.addSubview(language)
    }
    
    func addConstraints() {
        container.addConstraints(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        fileTitle.addConstraints(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, paddingTop: 19.2, paddingLeft: 19.5, paddingRight: -19.5)
        fileType.addConstraints(top: fileTitle.bottomAnchor, leading: fileTitle.leadingAnchor, trailing: fileTitle.trailingAnchor, paddingTop: 17)
        language.addConstraints(top: fileType.bottomAnchor, leading: fileType.leadingAnchor, trailing: fileTitle.trailingAnchor, paddingTop: 6)
    }
    
    func setup(model: FilesDetail) {
        self.fileTitle.text = model.filename
        self.fileType.text = model.type
        self.language.text = model.language
    }
}
