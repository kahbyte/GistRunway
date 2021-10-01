//
//  GistsDetailedInfoView.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit

class GistsDetailedInfoView: UIView {
    
    let detailsStackView = createStackView(alignment: .center, axis: .horizontal, spacing: 0)
    let forkStack = createStackView(alignment: .center, axis: .vertical, spacing: 4)
    let commentsStack = createStackView(alignment: .center, axis: .vertical, spacing: 4)
    
    let forkLabel: UILabel = {
        let label = UILabel()
        label.text = "Forks"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let forkQuantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 29)
        return label
    }()
    
    
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let commentsQuantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 29)
        return label
    }()
    
    
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: ApplicationColors.finalPurpleBackground.rawValue)
        self.layer.cornerRadius = 10
        
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(detailsStackView)
        let separator = SeparatorView(orientation: .vertical, color: .lightGray)
//        detailsStackView.backgroundColor = .cyan
        
        addArrangedSubviews(to: detailsStackView, views: [forkStack, separator, commentsStack])
        addArrangedSubviews(to: forkStack, views: [forkLabel, forkQuantityLabel])
        addArrangedSubviews(to: commentsStack, views: [commentsLabel, commentsQuantityLabel])
    }
    
    func addConstraints() {
        detailsStackView.addConstraints(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingLeft: 58.5,paddingRight: -35.5)
        
    }
    
    private func addArrangedSubviews(to stack: UIStackView, views: [UIView]) {
        for view in views {
            stack.addArrangedSubview(view)
        }
    }
    
    static func createStackView(alignment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = alignment
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = .equalCentering
        
        return stackView
    }
    
}
