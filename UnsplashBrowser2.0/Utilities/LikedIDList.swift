//
//  LikedIDList.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 11/11/2022.
//

import Foundation

class LikedIdList {
    //TODO
    var IdList: [String] = []
    static let shared = LikedIdList()
    private init() {}
    
    func updateIDs() {
        var IdTable: [String] = []
        PersistanceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                IdTable = favorites.map {$0.id}
            case .failure(let error):
                print(error.rawValue)
            }
        }
        IdList = IdTable
        print(IdList)
    }
}
