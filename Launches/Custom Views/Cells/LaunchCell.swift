//
//  LaunchCell.swift
//  Launches
//
//  Created by Simon Goldring on 7/9/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import UIKit

class LaunchCell: UICollectionViewCell {
    static let reuseID = "LaunchCell"
    
    var flightNumberLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(flightNumberLabel)
        flightNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        flightNumberLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            flightNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flightNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flightNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            flightNumberLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(for launch: Launch) {
        flightNumberLabel.text = "#\(launch.flightNumber)"
    }
}
