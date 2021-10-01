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
    
    var model: [FileDetails] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubviews()
        addConstraints()
    }
    
    weak var detailsViewDelegate: DetailsViewControllerProtocol?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(collectionView)
        bringSubviewToFront(collectionView)
    }
    
    func addConstraints() {
        collectionView.addConstraints(top: contentView.topAnchor, bottom:  contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingLeft: 39.5, height: 122.5)
    }
}


extension CustomFilesCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 237, height: 121)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let rawURL = model[indexPath.row].raw_url else { return }
        guard let url = URL(string: rawURL) else { return }
        detailsViewDelegate?.openFileUrl(url: url)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filesCell", for: indexPath) as! CustomCollectionViewCell
        cell.setup(model: model[indexPath.row])
        return cell
    }
    
    
}
