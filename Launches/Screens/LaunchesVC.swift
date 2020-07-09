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
    var dataSource: UICollectionViewDiffableDataSource<Int, Launch>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureDataSource()
        getLaunches()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(LaunchCell.self, forCellWithReuseIdentifier: LaunchCell.reuseID)
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Launch>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, launch) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCell.reuseID, for: indexPath) as! LaunchCell
            cell.set(for: launch)
            return cell
        })
    }
    
    private func getLaunches() {
        NetworkManager.shared.getLaunches { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let launches):
                DispatchQueue.main.async {
                    self.updateData(with: launches)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateData(with launches: [Launch]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Launch>()
        snapshot.appendSections([0])
        snapshot.appendItems(launches)
        dataSource.apply(snapshot)
    }
}

extension LaunchesVC: UICollectionViewDelegate {
    
}
