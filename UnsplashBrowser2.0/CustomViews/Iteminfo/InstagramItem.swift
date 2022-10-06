//
//  InstagramItem.swift
//  UnsplashBrowser2.0
//
//  Created by Paweł on 05/10/2022.
//

import UIKit

class InstagramItem: UBItemInfoVC {
    
    override func setType() {
        titleLabel.text = "Instagram: \(user.instagramUsername!)"
        button.set(color: .systemRed, title: "", systameImageName: "camera")
    }
    
    override func actionButtonTapped() {
        let endpoint = URL(string: "https://instagram.com/" + user.instagramUsername!)
        presentSafariVC(with: endpoint!)
    }
    
}
