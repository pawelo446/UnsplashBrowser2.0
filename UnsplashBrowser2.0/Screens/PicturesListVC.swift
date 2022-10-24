//
//  PicturesListVC.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 22/08/2022.
//

import UIKit

class PicturesListVC: UBDataLoadingVC {
    
    enum Section{ case main }
    
    var phrase: String!
    var pictureList: [Picture] = []
    var filteredPictureList: [Picture] = []
    var favoriteIDList: [String] = []
    
    var isFiltering = false
    var isLoadingMore = false
    var currentPage = 1
    var totalPages = 1
    var currentColor: ColorPicker? = nil
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Picture>!
    
    init(phrase: String) {
        super.init(nibName: nil, bundle: nil)
        self.phrase = phrase
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getPictures(color: nil, page: 1, phrase: phrase)
        configureDataSource()
        configureSearchController()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout(in: self.view))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.reuseID)
        collectionView.delegate = self
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Picture>(collectionView: collectionView, cellProvider: { collectionView, indexPath, picture in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.reuseID, for: indexPath) as! PictureCell
            cell.set(picture: picture, isLiked: picture.liked!)
            return cell
        })
    }
    
    
    func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 8
        let topPadding:CGFloat = 18
        let minimumSpacing:CGFloat = 10
        let availableWidth = width - (2 * padding) - minimumSpacing
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: topPadding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.minimumLineSpacing = 30
        return flowLayout
    }
    
    
    func getPictures(color: ColorPicker?, page: Int, phrase: String) {
        presentLoadingView()
        Task {
            do {
                let response = try await NetworkManager.shared.fetchRequest(for: phrase, page: page, color: color)
                self.totalPages = response.totalPages
                self.pictureList.append(contentsOf: response.results)
                self.updateData(pictures: self.pictureList)
            } catch {
                if let ubError = error as? UBError {
                    presentUBAlertOnMainThread(title: "Bad stuff", message: ubError.rawValue, buttonTitle: "ok")
                } else {
                    presentUBAlertOnMainThread(title: "Bad stuff", message: "idk : )", buttonTitle: "ok")
                }
            }
            dismissLoadingView()
        }
    }
    
    
    func updateData(pictures: [Picture]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Picture>()
        snapshot.appendSections([.main])
        snapshot.appendItems(pictures)
        favoriteIDList = PersistanceManager.retrieveIDs()
        pictures.map {$0.liked = self.favoriteIDList.contains($0.id)
            return $0
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    func getColorButtons() -> [UIAction] {
        var colorButtons: [UIAction] = []
        
        let cancelFilterButton = UIAction { (action) in
            self.colorButtonTapped(color: nil)
        }
        cancelFilterButton.image = UIImage(systemName: "circle.slash")
        cancelFilterButton.title = "none"
        colorButtons.append(cancelFilterButton)
        
        for color in ColorPicker.allCases {
            let button = UIAction { (action) in
                self.colorButtonTapped(color: color)
            }
            button.configureColorButton(type: color)
            colorButtons.append(button)
        }
        return colorButtons
    }
    
    
    func colorButtonTapped(color: ColorPicker?) {
        self.pictureList = []
        self.filteredPictureList = []
        self.getPictures(color: color, page: 1, phrase: self.phrase)
        self.currentColor = color
    }
    
    
    func configureViewController() {
        title = phrase
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let menu = UIMenu(title: "Filter by colors", image: nil, identifier: .text, options: .displayInline, children: getColorButtons())
        let addButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "paintpalette"), primaryAction: nil, menu: menu)
        navigationItem.rightBarButtonItem = addButton
    }
}


extension PicturesListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredPictureList.removeAll()
            updateData(pictures: pictureList)
            isFiltering = false
            return
        }
        isFiltering = true
        filteredPictureList = pictureList.filter({ $0.user.username.lowercased().contains(filter.lowercased()) })
        updateData(pictures: filteredPictureList)
    }
}


extension PicturesListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isFiltering ? filteredPictureList : pictureList
        let picture = activeArray[indexPath.item]
        
        let destVC = DetailedPictureVC()
        destVC.picture = picture
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > (contentHeight - height) {
            guard currentPage < totalPages, !isLoadingMore else { return }
            currentPage += 1
            getPictures(color: currentColor, page: currentPage, phrase: phrase)
        }
    }
}
