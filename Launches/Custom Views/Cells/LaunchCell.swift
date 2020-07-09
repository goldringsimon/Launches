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
    
    var patchImageView = PatchImageView(frame: .zero)
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
        
        addSubview(patchImageView)
        
        NSLayoutConstraint.activate([
            flightNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flightNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flightNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            flightNumberLabel.heightAnchor.constraint(equalToConstant: 20),
            
            patchImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            patchImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            patchImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            patchImageView.bottomAnchor.constraint(equalTo: flightNumberLabel.topAnchor)
        ])
    }
    
    func set(for launch: Launch) {
        flightNumberLabel.text = "#\(launch.flightNumber)"
        if let patchUrl = launch.links.patch.small {
            patchImageView.downloadImage(fromURL: patchUrl)
        }
    }
}
