//
//  CustomGistsTableViewCell.swift
//  GistRunway
//
//  Created by Kauê Sales on 28/09/21.
//

import UIKit

class CustomGistsTableViewCell: UITableViewCell {
    
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let ownerImageView: CircularImageView = {
        let imageView = CircularImageView()
        imageView.image = UIImage(named: "pp")
        return imageView
    }()
    
    let ownerName: UILabel = {
        let label = UILabel()
        label.text = "Tutuzao lolps"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let gistDescription: UILabel = {
        let label = UILabel()
        label.text = "receita-de-miojo"
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private let gistStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        addSubviews()
        addConstraints()
        ownerImageView.layer.cornerRadius = ownerImageView.frame.size.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func addSubviews() {
        addSubview(container)
        container.backgroundColor = UIColor(named: ApplicationColors.viewWhite.rawValue)!
        container.addSubview(ownerImageView)
        container.addSubview(gistStack)
        gistStack.addArrangedSubview(ownerName)
        gistStack.addArrangedSubview(gistDescription)
//        ownerImageView.layer.cornerRadius = 12
        
    }
    
    func addConstraints() {
        container.addConstraints(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 13, paddingLeft: 13, paddingBottom: -13, paddingRight: -13) //nao faz a view crescer
        ownerImageView.addConstraints(leading: container.leadingAnchor, centerY: container.centerYAnchor, paddingLeft: 12, width: 72, height: 72)
        gistStack.addConstraints(top: container.topAnchor, bottom: container.bottomAnchor, leading: ownerImageView.trailingAnchor, trailing: container.trailingAnchor, paddingTop: 20.5, paddingLeft: 12.9, paddingBottom: 20.5)
    }
}
