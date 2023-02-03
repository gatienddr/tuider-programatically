//
//  MessagesViewController.swift
//  tuider-programatically
//
//  Created by Gatien DIDRY on 27/11/2022.
//

import UIKit

class MessagesViewController: UIViewController {
    
    let cellId = "CustomCell"
    
    var users: [Profil]
    
    private let padding: CGFloat = 16
    private let paddingVertical: CGFloat = 10
    
    // MARK: Navigation
    private lazy var rightBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "list.bullet"),
                                   primaryAction: nil,
                                   menu: makeMenu()
        )
        
        return item
    }()
    
    init() {
        users = UsersService.profils.filter(\.wasMatched)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum PresentationMode {
        case list
        case grid
    }
    
    //    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
    //
    //    }
    
    fileprivate func refreshUsers() {
        users = UsersService.profils.filter(\.wasMatched)
    }
    
    private var currentMode: PresentationMode = .list {
        didSet {
            guard currentMode != oldValue else {return}
            setBarButtonItem()
            updateCollectionViewLayout()
        }
    }
    
    private let listImage = UIImage(systemName: "list.bullet")
    private let gridImage = UIImage(systemName: "square.grid.2x2")
    
    private func setBarButtonItem() {
        let item = UIBarButtonItem(
            image: currentMode == .list ? listImage : gridImage,
            primaryAction: nil,
            menu: makeMenu())
        
        navigationItem.rightBarButtonItem = item
        
    }
    
    private func makeMenu() -> UIMenu {
        let actions: [UIAction] = [
            UIAction(
                title: "List",
                state: currentMode == .list ? .on : .off,
                handler: {[weak self] _ in
                    self?.currentMode = .list
                }),
            UIAction(
                title: "Grid",
                state: currentMode == .grid ? .on : .off,
                handler: {[weak self] _ in
                    self?.currentMode = .grid
                })
        ]
        
        let menu = UIMenu(
            title: "Display Mode",
            image: nil,
            children: actions
        )
        
        return menu
    }
    
    private lazy var gridLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2 - padding * 2, height: 150)
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(
            top: paddingVertical,
            left: padding,
            bottom: paddingVertical,
            right: padding)
        return layout
    }()
    
    private lazy var listLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - padding * 2, height: 300)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(
            top: paddingVertical,
            left: padding,
            bottom: paddingVertical,
            right: padding)
        return layout
    }()
    
    private func updateCollectionViewLayout() {
        collectionView.reloadSections([0])
        
        collectionView.setCollectionViewLayout(
            currentMode == .list ? listLayout : gridLayout,
            animated: false)
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: listLayout)
        collectionView.register(
            MessageGridCollectionViewCell.self,
            forCellWithReuseIdentifier: MessageGridCollectionViewCell.reuseIdentifier
        )
        
        collectionView.alwaysBounceVertical = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshUsers()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = rightBarButton
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension MessagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView (
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MessageGridCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? MessageGridCollectionViewCell

            return cell ?? UICollectionViewCell()
        }

}

extension MessagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profile = users[indexPath.row]
        let profileInfoViewController = ProfileInfoViewController(profile: profile)

        profileInfoViewController.modalPresentationStyle = .overFullScreen
        profileInfoViewController.modalTransitionStyle = .crossDissolve
        present(profileInfoViewController, animated: true)
    }
}
