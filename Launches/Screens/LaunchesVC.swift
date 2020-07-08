//
//  LaunchesVC.swift
//  Launches
//
//  Created by Simon Goldring on 7/8/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import UIKit

class LaunchesVC: UIViewController {
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView()
    }
}
