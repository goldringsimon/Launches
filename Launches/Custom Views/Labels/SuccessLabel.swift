//
//  SuccessLabel.swift
//  Launches
//
//  Created by Simon Goldring on 7/9/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import UIKit

class SuccessLabel: UIView {
    
    var symbolView = UIImageView(frame: .zero)
    var label = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }*/
    
    func set(with success: Bool?) {
        if let success = success {
            switch success {
            case true:
                symbolView.image = UIImage(systemName: "hand.thumbsup")
                label.text = "Success"
                backgroundColor = .systemGreen
                
            case false:
                symbolView.image = UIImage(systemName: "hand.thumbsdown")
                label.text = "Failure"
                backgroundColor = .systemRed
            }
        } else {
            
        }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        
        addSubview(symbolView)
        symbolView.translatesAutoresizingMaskIntoConstraints = false
        symbolView.tintColor = .white
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.lineBreakMode = .byTruncatingTail
        //label.sizeToFit()
        
        NSLayoutConstraint.activate([
            symbolView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolView.topAnchor.constraint(equalTo: topAnchor),
            symbolView.heightAnchor.constraint(equalTo: heightAnchor),
            symbolView.widthAnchor.constraint(equalTo: symbolView.heightAnchor),
            
            label.firstBaselineAnchor.constraint(equalTo: symbolView.firstBaselineAnchor),
            label.leadingAnchor.constraint(equalTo: symbolView.trailingAnchor, constant: 12),
            //label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalTo: symbolView.heightAnchor)
        ])
    }
}
