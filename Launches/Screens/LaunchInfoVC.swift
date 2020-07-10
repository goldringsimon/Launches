//
//  LaunchInfoVC.swift
//  Launches
//
//  Created by Simon Goldring on 7/9/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import UIKit

class LaunchInfoVC: UIViewController {
    
    var patchImageView = PatchImageView(frame: .zero)
    var flightNumberLabel = BodyLabel(textAlignment: .natural)
    var dateLabel = BodyLabel(textAlignment: .natural)
    var detailsLabel = BodyLabel(textAlignment: .natural)
    var successLabel = SuccessLabel(frame: .zero)
    
    var linksCardView = UIView(frame: .zero)
    var linksCardVC = LinksCardVC()
    
    var launch: Launch!
    
    init(with launch: Launch) {
        super.init(nibName: nil, bundle: nil)
        self.launch = launch
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configurePatchImageView()
        configureDetailsLabel()
        configureFlightNumberLabel()
        configureDateLabel()
        configureSuccessLabel()
        configureLinksCard()
        layoutUI()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = launch.name
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func configurePatchImageView() {
        view.addSubview(patchImageView)
        
        if let patchUrl = launch.links.patch.small {
            patchImageView.downloadImage(fromURL: patchUrl)
        }
    }
    
    private func configureDetailsLabel() {
        view.addSubview(detailsLabel)
        
        detailsLabel.text = launch.details ?? ""
        detailsLabel.numberOfLines = 0
        detailsLabel.sizeToFit()
    }
    
    private func configureFlightNumberLabel() {
        view.addSubview(flightNumberLabel)
        flightNumberLabel.text = "Flight #: \(launch.flightNumber)"
    }
    
    private func configureDateLabel() {
        view.addSubview(dateLabel)
        
        let formatter = DateFormatter()
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let launchDate = isoFormatter.date(from: launch.dateUtc)
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        if let launchDate = launchDate {
            dateLabel.text = formatter.string(from: launchDate)
        }
    }
    
    private func configureSuccessLabel() {
        view.addSubview(successLabel)
        
        successLabel.set(with: launch.success)
    }
    
    private func configureLinksCard() {
        view.addSubview(linksCardView)
        linksCardView.translatesAutoresizingMaskIntoConstraints = false
        add(childVC: LinksCardVC(), to: linksCardView)
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            patchImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            patchImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            patchImageView.widthAnchor.constraint(equalToConstant: 120),
            patchImageView.heightAnchor.constraint(equalTo: patchImageView.widthAnchor),
            
            flightNumberLabel.leadingAnchor.constraint(equalTo: patchImageView.trailingAnchor, constant: padding),
            flightNumberLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            flightNumberLabel.topAnchor.constraint(equalTo: patchImageView.topAnchor),
            flightNumberLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.leadingAnchor.constraint(equalTo: patchImageView.trailingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            dateLabel.centerYAnchor.constraint(equalTo: patchImageView.centerYAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
            
            successLabel.bottomAnchor.constraint(equalTo: patchImageView.bottomAnchor),
            successLabel.leadingAnchor.constraint(equalTo: patchImageView.trailingAnchor, constant: padding),
            successLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            successLabel.heightAnchor.constraint(equalToConstant: 18),
            
            linksCardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            linksCardView.topAnchor.constraint(equalTo: patchImageView.bottomAnchor, constant: padding),
            linksCardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            linksCardView.heightAnchor.constraint(equalToConstant: 120),
            
            detailsLabel.leadingAnchor.constraint(equalTo: patchImageView.leadingAnchor),
            detailsLabel.topAnchor.constraint(equalTo: linksCardView.bottomAnchor, constant: padding),
            detailsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
            //detailsLabel.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
