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
    var flightNameLabel = SubtitleLabel(textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(flightNameLabel)
        
        addSubview(patchImageView)
        
        NSLayoutConstraint.activate([
            flightNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flightNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flightNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            flightNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            patchImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            patchImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            patchImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            patchImageView.bottomAnchor.constraint(equalTo: flightNameLabel.topAnchor)
        ])
    }
    
    func set(for launch: Launch) {
        flightNameLabel.text = launch.name
        if let patchUrl = launch.links.patch.small {
            patchImageView.downloadImage(fromURL: patchUrl)
        }
    }
}
