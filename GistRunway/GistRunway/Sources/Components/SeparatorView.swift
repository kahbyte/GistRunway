//
//  SeparatorView.swift
//  GistRunway
//
//  Created by Kauê Sales on 30/09/21.
//

import UIKit

class SeparatorView: UIView {
    private var orientation: Orientation
    private var color: UIColor
    
    init(orientation: Orientation, color: UIColor) {
        self.orientation = orientation
        self.color = color
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
//        guard let color = color else {
//            backgroundColor = .black
//            return
//        }
        
        backgroundColor = color
    }
    
    override var intrinsicContentSize: CGSize {
        switch orientation {
        case .vertical:
            return CGSize(width: 1, height: 30)
        case .horizontal:
            return CGSize(width: 195, height: 1)
        }
        
    }
    
    enum Orientation {
        case vertical
        case horizontal
    }
}
