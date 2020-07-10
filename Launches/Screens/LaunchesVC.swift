//
//  LaunchesVC.swift
//  Launches
//
//  Created by Simon Goldring on 7/8/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import UIKit

typealias Section = Int

class LaunchesVC: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Launch>!
    
    var launches: [Launch] = [] {
        didSet {
            filteredLaunches = launches
        }
    }
    var filteredLaunches: [Launch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureSearchController()
        configureDataSource()
        getLaunches()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Launches"
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a launch"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Launch>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, launch) -> UICollectionViewCell? in
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
                    self.launches = launches
                    self.updateData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateData() {
        /*let groupedLaunches = Dictionary(grouping: launches) { $0.success }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Launch>()
        snapshot.appendSections([false])
        snapshot.appendItems(groupedLaunches[false] ?? [])
        snapshot.appendSections([true])
        snapshot.appendItems(groupedLaunches[true] ?? [])*/
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Launch>()
        snapshot.appendSections([0])
        snapshot.appendItems(filteredLaunches)
        dataSource.apply(snapshot)
    }
}

extension LaunchesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let launch = dataSource.itemIdentifier(for: indexPath) {
            let destVC = LaunchInfoVC(with: launch)
            let navController = UINavigationController(rootViewController: destVC)
            present(navController, animated: true)
        }
    }
}

class DataSource: UICollectionViewDiffableDataSource<Section, Launch> {
    
}

extension LaunchesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let filter = searchController.searchBar.text, !filter.isEmpty {
            filteredLaunches = launches.filter({ $0.name.lowercased().contains(filter.lowercased()) })
        } else {
            filteredLaunches = launches
        }
        updateData()
    }
}
