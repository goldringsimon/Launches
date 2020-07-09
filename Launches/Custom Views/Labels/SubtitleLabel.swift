//
//  SubtitleLabel.swift
//  Launches
//
//  Created by Simon Goldring on 7/9/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import UIKit

class SubtitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .caption1)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
    }
}
