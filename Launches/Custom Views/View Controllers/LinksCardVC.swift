//
//  LinksCardVC.swift
//  Launches
//
//  Created by Simon Goldring on 7/10/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import UIKit

class LinksCardVC: UIViewController {
    
    let redditButton = LinkButton(with: "Reddit", backgroundColor: .systemOrange)
    let youtubeButton = LinkButton(with: "YouTube", backgroundColor: .systemRed)
    let articleButton = LinkButton(with: "Article", backgroundColor: .systemBlue)
    let wikiButton = LinkButton(with: "Wikipedia", backgroundColor: .systemGreen)

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        view.addSubview(redditButton)
        view.addSubview(youtubeButton)
        view.addSubview(articleButton)
        view.addSubview(wikiButton)
        
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            redditButton.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            redditButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            redditButton.widthAnchor.constraint(equalTo: youtubeButton.widthAnchor),
            redditButton.heightAnchor.constraint(equalTo: articleButton.heightAnchor),
            
            youtubeButton.topAnchor.constraint(equalTo: redditButton.topAnchor),
            youtubeButton.leadingAnchor.constraint(equalTo: redditButton.trailingAnchor, constant: padding),
            youtubeButton.heightAnchor.constraint(equalTo: wikiButton.heightAnchor),
            youtubeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            articleButton.topAnchor.constraint(equalTo: redditButton.bottomAnchor, constant: padding),
            articleButton.leadingAnchor.constraint(equalTo: redditButton.leadingAnchor),
            articleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            articleButton.widthAnchor.constraint(equalTo: wikiButton.widthAnchor),
            
            wikiButton.topAnchor.constraint(equalTo: youtubeButton.bottomAnchor, constant: padding),
            wikiButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            wikiButton.leadingAnchor.constraint(equalTo: articleButton.trailingAnchor, constant: padding),
            wikiButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
}
