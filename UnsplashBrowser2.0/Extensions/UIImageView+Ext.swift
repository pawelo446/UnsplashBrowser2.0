//
//  UIImageView+Ext.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 18/09/2022.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from urlString: String) {
        Task {
            self.image = try await NetworkManager.shared.downloadImage(from: urlString) 
        }
    }
}
