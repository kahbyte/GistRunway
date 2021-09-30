//
//  CircularImageView.swift
//  GistRunway
//
//  Created by Kauê Sales on 29/09/21.
//

import UIKit

@IBDesignable
class CircularImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }

}
