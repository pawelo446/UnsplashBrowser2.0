//
//  FavoritesListVC.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 16/08/2022.
//

import UIKit

    class FavoritesListVC: UBDataLoadingVC {

        let tableView = UITableView()
        var favorites: [Picture] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            configureViewController()
            configureTableView()
        }
        
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            getfavorites()
        }
        
        
        func getfavorites() {
            PersistanceManager.retrieveFavorites { [weak self] result in
                guard let self = self else {return}
                
                switch result {
                case .success(let favorites):
                    self.updateUI(with: favorites)
                    
                case .failure(let error):
                    self.presentUBAlertOnMainThread(title: "Ups!", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
        
        
        func updateUI(with favorites: [Picture]) {
            if favorites.isEmpty {
              //  self.showEmptyStateView(with: "No favorites?", in: self.view)
            } else {
                self.favorites = favorites
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            }
        }
        
        
        func configureTableView() {
            view.addSubview(tableView)
            tableView.frame = view.bounds
            tableView.rowHeight = 110
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        }
        
        
        private func configureViewController() {
            view.backgroundColor = .systemBackground
            title = "Favorites"
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }


    extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favorites.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
            let favorite = favorites[indexPath.row]
            cell.set(picture: favorite)
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let favorite = favorites[indexPath.row]
            let destVC = DetailedPictureVC()
            destVC.picture = favorite
            let navController = UINavigationController(rootViewController: destVC)
            present(navController, animated: true)
        }
        
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            guard editingStyle == . delete else { return }
            let favorite = favorites[indexPath.row]
            
            PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
                guard let self = self else {return}
                
                guard let error = error else {
                    self.favorites.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .left)
                    return
                }
                self.presentUBAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }

