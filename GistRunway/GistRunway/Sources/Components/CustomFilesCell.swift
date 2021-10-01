//
//  CustomFilesCell.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit

class CustomFilesCell: UITableViewCell {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "filesCell")
        collection.isUserInteractionEnabled = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = true
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    
        
        addSubviews()
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(collectionView)
        bringSubviewToFront(collectionView)
    }
    
    func addConstraints() {
        collectionView.addConstraints(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingLeft: 39.5, height: 121)
    }
    
}


extension CustomFilesCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 237, height: 121)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filesCell", for: indexPath)
        
        return cell
    }
    
    
}
